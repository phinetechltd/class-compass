# Security audit — Mighty School Pro v1.6

Date: 2026-10-19
Scope: `install-api-code-v1.6.zip` (Laravel API, 18,627 files incl. vendor), `updated-api-code-v1.6.zip` (patch, 1,470 files), `web-app-desktop-code-v1.6.zip` (Flutter app, 2,533 files).

Cleaned sources are in this folder:

| Folder | From |
|---|---|
| `api/` | install-api-code-v1.6.zip |
| `api-update-patch/` | updated-api-code-v1.6.zip |
| `web-app/` | web-app-desktop-code-v1.6.zip |

The original zips are untouched. **Deploy from `cleaned/`, not from the zips** — the zips still contain the issues fixed below.

## Malware / backdoor scan — no injected code found

| Check | Result |
|---|---|
| Nulled-site strings (`nullphpscript`, `jiourl`, etc.) in code | None inside the zips; only in 3 redirect `.html` files beside them (deleted) |
| `eval`, `gzinflate`, `str_rot13`, `create_function`, `preg_replace /e`, `$_GET[..](..)`, shell exec in app/module code | None. `base64_decode` hits are legitimate (see finding 2 and Razorpay callback) |
| PHP files in `public/`, `storage/`, stray `.htaccess` / `.user.ini` | Only the standard `public/index.php` and `.htaccess` |
| `vendor/` packages vs `composer.lock` | Exact match, no extra packages, no `eval(base64_decode…)` droppers |
| Very long single-line PHP (packed payloads) | Only Faker's word-list files (normal) |
| File timestamp outliers | All app files 2026-03 except root `index.php` (2026-02), which is the stock Laravel front controller |
| Outbound hosts | Payment/SMS gateways, Zoom, Vercel, rdap.org, vendor support site for purchase-key check — all explained by features. Exception: polyfill.io (finding 3) |

## Fixed in `cleaned/`

### 1. CRITICAL — Unauthenticated remote code execution via `/upgrade`
`routes/web.php` exposed `GET/POST /upgrade` with no auth. `InstallController::uploadStore()` extracted any uploaded zip straight into the app root, so anyone could overwrite a PHP file and take over the server (zip-slip also possible).
**Fix:** removed both routes, the `upgradeIndex`/`uploadStore` methods (in `api/` and `api-update-patch/`), and `resources/views/upgrade.blade.php`. Upgrade by deploying files + `php artisan migrate` instead.

### 2. Removed polyfill.io script (supply-chain risk)
`payment/stripe.blade.php` (3 copies) loaded `https://polyfill.io/...`. That domain was taken over in 2024 and served malicious JS. It only polyfilled `fetch`, which every supported browser has. **Fix:** line removed.

### 3. Shipped `.env` with a shared `APP_KEY`
Every copy of this package shared the same `APP_KEY`, so anyone with the zip could forge encrypted cookies/sessions on your install. **Fix:** new random `APP_KEY`, `APP_ENV=production`, `LOG_LEVEL=error`. Still run `php artisan key:generate --force` on each server you deploy to.

### 4. Nulled-site files deleted
`NullPHPscript.com.html`, `Download More PHP Scripts.html`, `Online Documentation (Updated).html` (redirects to nullphpscript.com / a jiourl.com short link).

### 5. HIGH — Student records enumerable without login (IDOR) — fixed
`/student-vital/{data}` and `/{student,teacher,staff}-list-for-card-print/{data}` were public. `{data}` was plain base64 JSON (`{"institute_id":1,"branch_id":1,"student_id":42}`) built by the Flutter app, so anyone could loop over IDs and read every student's results and ID-card data in every institute. `vital()` also ignored `institute_id` when it looked up the student.
**Fix (API, `cleaned/api/`):**
- New `POST /api/print-links` (`auth:api`, throttled), handled by `app/Http/Controllers/PrintLinkController.php`. It takes the institute and branch from the logged-in user, not from the client. For `student_vital` it checks that the student is in that institute and branch, and that a Student user is asking for their own record, or a Parent user for their own child. Student and Parent users can't request the ID-card lists. It returns a `URL::temporarySignedRoute` link that is valid for 30 minutes.
- `routes/web.php`: the four print routes are now inside `Route::middleware('signed')`, so an unsigned, edited or expired URL gets **403**. (The teacher and staff route names were swapped; they are corrected now.)
- `WebsiteController`: the student lookup in `vital()` is now limited to the signed institute/branch. The ID-card lists no longer fall back to institute/branch `1`, and the payload is decoded as URL-safe base64. This file is mirrored in `api-update-patch/`.

**Fix (app, `cleaned/web-app/`):** `IdCardController.openPrintLink()` calls the new endpoint and opens the URL it gets back. `id_card_widget.dart` and `id_card_type_selection_widget_widget.dart` no longer build the links themselves, and the old path constants in `AppConstants` are replaced by `printLinks`.
**Deploy together:** an old app build still opens unsigned links, and those now get 403. `APP_URL` and proxy settings must match the host users open, or the signature check fails (for HTTPS behind a proxy, configure trusted proxies). `api-update-patch/` has no `routes/` folder. If you upgrade with that patch, also copy `routes/web.php`, `routes/api.php` and `PrintLinkController.php` from `cleaned/api/`.

## Not fixed — needs your action

### 6. HIGH — Default admin accounts in `demo.sql`
The installer wipes the DB and imports `demo.sql`, which contains preset logins: `superadmin@gmail.com`, `saasadmin@gmail.com`, `systemadmin@gmail.com`, `accountant@gmail.com`, `librarian@gmail.com`, `hostel@gmail.com`, `transport@gmail.com`. Their password hashes ship in the file, so every install starts with the same credentials.
**Action:** immediately after install, change every one of these passwords (or delete the accounts you don't use), and delete `demo.sql` from the server.

### 7. MEDIUM — Flutter app points at the vendor's Firebase
`web-app/android/app/google-services.json` belongs to Firebase project `codemoly-e341f`, not yours. Push notifications / analytics from your app would go to that project. Replace it (and iOS/web Firebase configs) with your own project's files before building.

### 8. LOW — housekeeping
- `vendor/` includes dev packages (phpunit, pest, mockery, larastan). Run `composer install --no-dev --optimize-autoloader` for production.
- `install/complete` route is outside the install guard (only clears caches — low impact).
- Root `.htaccess` contains cPanel PHP settings from the vendor's server (`session.save_path` for ea-php74, 1 GB upload limits). Review for your host.
- Point the web server document root at `api/public`, not `api/`, so `.env`, `demo.sql` and `storage/` are never web-reachable.

## If you already ran an earlier copy on a server
Assume compromise if `/upgrade` was reachable: check for unexpected/modified PHP files (compare against `cleaned/api`), rotate DB, mail, payment-gateway and SMS credentials, regenerate `APP_KEY` (logs everyone out), and change all admin passwords.

## Update (Class Compass rebrand pass)

### 9. HIGH — Vendor Zoom credentials hard-coded — fixed
`api/config/zoom.php` used the vendor's own Zoom account ID, client key and secret as fallback values. Every install that didn't set its own Zoom values would create meetings on the vendor's Zoom account (and the vendor could see them). **Fix:** fallbacks removed. Set `ZOOM_ACCOUNT_ID`, `ZOOM_CLIENT_KEY` and `ZOOM_CLIENT_SECRET` in `.env`. Zoom token errors are now caught so listing meetings still works.

## Update 2 (Kenya release: M-Pesa, Paystack, curricula)

Fixed:
- **HIGH — Any user could overwrite any school's payment keys.** `PUT /api/digital-payment/{id}` and its status toggle didn't check which school the setting belonged to, or who was asking. Now they only work on the caller's own school, and parents and students get 403. The platform (SaaS) gateway endpoints only accept the SaaS admin. For everyone else, the platform gateway list no longer includes secret keys.
- **HIGH — Paystack payments could never complete, and the checkout page crashed.** The view used an undefined `$payer`, and the callback had no `payment_id`, so the controller crashed loading its config. Rewritten: the transaction is initialised server-side with a callback that carries the payment id, then verified with Paystack (status, amount and currency) before it is marked paid.
- **HIGH — Settings leaked between schools.** `get_option()` ignored the institute, so every school read school #1's values (academic year, currency, SMS and Zoom keys…). It now reads only the logged-in user's school, preferring their branch.
- **MEDIUM — Plain-text passwords in onboarding records.** `onboardings.collected_data` stored the new admin's password in plain text. It is now hashed, and approval works with both old and new records.
- **MEDIUM — Same OAuth signing keys in every install.** `storage/oauth-*.key` ships with the package. The installer now runs `passport:keys --force`, and this install's keys were regenerated.
- **MEDIUM — The service worker served stale apps and intercepted API calls.** The vendor's `service_worker.js` cached `/` and `main.dart.js` cache-first and handled every request. It is replaced by a network-first worker that only handles same-origin static files.
- **LOW:**
  - The public sign-up and contact forms are now rate-limited.
  - Dead library routes pointed at controllers that no longer exist, which broke `route:list` and `route:cache`. They are removed.
  - Gateway controllers crashed when constructed without a payment. They are now null-safe.
  - Security headers (`nosniff`, `Referrer-Policy`, `X-Frame-Options`, `Permissions-Policy`) are added in `public/.htaccess`.

New payment endpoints:
- M-Pesa callbacks need a per-payment HMAC token.
- Paystack webhooks need a valid `x-paystack-signature`.
- Amounts always come from the server-side balance; parents can't pay more than the balance.
- Confirming a payment is idempotent (row lock).

## Update 3 (production-readiness pass, 20 Oct 2026)
Fixed:
- parents and learners reaching staff APIs
- no isolation between schools
- public SaaS settings leaking the Vercel token and gateway keys
- settings readable and writable by any user
- public storage, cache and learner-list maintenance endpoints
- public self-registration
- missing per-school roles
- no login rate limit
- raw SQL errors shown to users

Full details and the go-live checklist: `PRODUCTION-READINESS.md`.
