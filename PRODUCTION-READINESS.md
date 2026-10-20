# Class Compass: production readiness and test report

Tested on 19–20 Oct 2026 against the local stack:
- Apache with PHP 8.3 and opcache
- MariaDB 10.4
- Flutter 3.38.6 web build
- Android release APK on a Pixel 9a emulator

## What was tested

| Area | How | Result |
|---|---|---|
| Every API endpoint the app calls (295) | GET-swept as guest, super admin, SaaS admin, accountant, parent and learner | No server errors. 3 validation-type 500s now return proper 404/422 codes |
| Role isolation | Parent and learner hitting staff endpoints | **Fixed.** Blocked (403) on 175–180 staff endpoints |
| Staff permissions (RBAC) | 46 GETs and 8 POSTs as super, system and SaaS admin, accountant, librarian, hostel and transport | **Fixed.** Each role reaches only its own modules (e.g. librarian 403 on payroll/accounting/fees, accountant 403 on library/roles/settings); admins unaffected |
| School isolation (multi-tenant) | School A admin reading, editing, deleting and marking attendance on school B's learner | **Fixed.** All blocked (404/422) |
| Subscription plans | Demo school (Shule, active) and a test school signed up via `POST /api/frontend/onboarding`, trial then expired, then upgraded; test school deleted afterwards | **Fixed.** Expired school: 402 on every staff module sampled (students, branches, dashboard, fees, payroll, SMS, hostel, transport, library, exams, accounting, CMS, gateways, curriculum, print links); login, profile, logout, plans/packages, `subscription/*` requests and the parent portal still 200. Learner limit (200th learner, bulk file bigger than the room left) and branch limit (2nd on Shule, 4th on Shule Pro) return 402; reads unaffected |
| Secrets exposure | Settings and SaaS-settings responses as guest and parent | **Fixed.** Credentials only reach settings managers |
| Admit learner, list learners, attendance, notice, library book, fee collection screen | Write-flow script as school admin | Pass |
| M-Pesa STK push, callback, fee posting, balance | End-to-end with simulated Safaricom responses | Pass: correct payload, forged callback rejected, duplicate callback ignored, balance 45,000 → 35,000 |
| Paystack initialise, verify, post | End-to-end with simulated Paystack responses | Pass: wrong reference rejected |
| School sign-up | From the website form and via the API | Pass: CBC applied, roles provisioned, 30-day trial, admin can log in and admit learners |
| Curriculum presets | CBC applied twice | Pass, idempotent |
| Web app screens (204 routes) | Every admin route opened, console errors captured | Pass. 2 dead legacy quiz screens redirected |
| Android app | Release APK on the emulator: homepage with live data, parent login | Pass, after the fixes below |
| Demo database | `demo.sql` re-imported with the installer's own method | Pass (212 tables) |
| Performance | API response time | about 0.15 s per request with opcache (was 1.3–4 s) |

## Problems found and fixed in this pass

**Critical / high**
1. **Parents and learners could use every staff API.** That included accounting reports, payroll, the list of all institutes, roles, onboarding records, and the school's payment-gateway keys. A new middleware (`RestrictPortalUsers`) now limits portal accounts to the parent and learner APIs.
2. **School data was not isolated.** One school's admin could read, change and delete another school's learners by changing the ID. Fixed system-wide (`App\Support\Tenancy`):
   - every model on a table with `institute_id` is filtered to the user's school;
   - `exists`/`unique` validation is checked within the school.
3. **Credentials leaked:**
   - `GET /api/get-saas-settings` was **public** and returned the Vercel token and the platform gateway keys;
   - `administration/general_settings` gave any logged-in user the Twilio token, Zoom secret, SMS key and gateway keys — and let them **change** settings.

   Credentials are now redacted for everyone except settings managers, and writes require the system-settings permission.
4. **Public maintenance endpoints:**
   - `system/unlink-storage` let anyone break all images;
   - `system/clear-cache` let anyone wipe the caches;
   - `system/all-students-get` listed every school's learners and attendance QR codes.
   - the language write routes (`POST languages`, `update-key`, `import`, `set-default`) had no login at all, so anyone could rewrite or replace the translations every school uses. The upload's language name also went straight into the file path.

   All four now require the platform admin (a school's Super Admin gets 403 because translations are shared by all schools). Reading translations stays public, and language names are limited to letters, digits, `-` and `_`.
5. **Public `POST /api/register`** created accounts with no school attached. Removed (the app doesn't use it). Accounts without a school now see nothing.
6. **New schools couldn't add learners, parents or staff.** Roles are per school/branch, but none were created for new schools or new branches (the demo school's Westlands campus included). `RoleProvisioner` now creates them at sign-up, at branch creation, and on demand; existing branches were backfilled.
7. **Staff could call any module's API.** The app hid menus by permission, but the server didn't check, so a librarian's token could read payroll and accounts or change roles. A new middleware (`EnforceStaffPermissions`) maps each API area to the permission group the sidebar uses (`payroll.*`, `accounting_management.*`/`accounting_report.*`, `fees_management.*`, `library_management.*`, `master_configuration.*`, `hostel_panel`, ...). Super, System and SaaS admins keep full access. Shared lists (classes, sessions, notices, routines) stay readable by all staff, and changing them needs the permission. The student list is also readable by fees, attendance, exam, library, hostel and transport roles, because their screens pick learners from it.

7a. **Subscription plans were not enforced, and a school could give itself any plan.** See *Subscription plans* below for the rules.
   - `CheckSubscription` is rewritten and attached to the staff route groups of every module, plus `print-links` and `curriculum`.
   - Plan activation (`subscription/upgrade`), request approval and the request list are now platform-admin only. They were open to any logged-in user.
   - The app's purchase call (`subscription/payment-upgrade`) now records a pending upgrade request instead of activating the plan, because no verified payment backs it.
   - Plan create/edit/delete is platform-admin only. Before, a school admin could raise every plan's limits.
   - `onboardings-list` and `onboardings-approve` are platform-admin only. The list exposed every sign-up's details.
   - Public sign-up ignores `extra_days`. Before, anyone could sign up with a ten-year "trial".
   - An approved upgrade request now grants one plan duration. It used to grant two (`extra_days` was set to the duration and then added to it).
   - Re-submitting an upgrade request now updates the requested plan, not just the price.
7b. **Any school could read, edit, deactivate or delete other schools** through `/api/institutes`. That table isn't tenant-scoped, because the platform admin manages every school.
   - A school's staff now see only their own school: the list returns their one record, and any other school's id returns 404.
   - Create, edit, delete and `institutes-status-update` are platform-admin only.
   - Tested with two schools: a school admin's cross-school and own-school writes return 403, while the SaaS admin still lists, edits and toggles every school.

**Medium / functional**
8. **Parent dashboard hung**, on Android and web. The API returns `[]` for empty data, and the model parsers crashed on it. 272 parsers across 147 files now accept it.
9. **The learner quiz list crashed.** It referenced a removed module; it is rebuilt on the QuestionBank quizzes, and correct answers are no longer sent to learners.
10. **Parent exam routine:** an SQL binding mismatch, fixed.
11. **Login was not rate-limited.** Login is now limited to 10 tries a minute and student OTP endpoints to 3–5 a minute. A wrong password now returns 422 with a clear message.
12. **Login emails were unique only per school**, but login looks users up by email across all schools. They are now unique system-wide.
13. **Raw SQL error text was shown to users.** It is now hidden when debug is off; details go to the log.
14. **Library history** returned 500 for learners with no library record. It now returns an empty list.
15. **`QUEUE_CONNECTION=file` is not a valid driver**; changed to `sync`.
16. **CORS** now comes from `CORS_ALLOWED_ORIGINS`, with no cookie credentials (the apps use bearer tokens). HTTPS links are forced when `APP_URL` is https, and `TRUSTED_PROXIES` is supported.
17. **Parent "my children" list was empty** when a learner was linked only through the parent record. It now includes the parent's linked child; the demo seeder sets the link as well.
18. **Android:**
    - package renamed to `ke.classcompass.app` and Dart package to `class_compass`;
    - the vendor's Firebase plugin and config are removed (they were unused);
    - plain HTTP is allowed only for local development hosts;
    - release builds fall back to the debug key when no upload key exists;
    - Paystack opens in the phone's browser and the app keeps checking the payment status;
    - the status bar no longer overlaps the website header.

## Subscription plans

`App\Http\Middleware\CheckSubscription` (alias `check.subscription`) runs on the staff route groups of every module. The limits come from the `plans` table (`student_limit`, `branch_limit`) through the school's subscription in `subscriptions`.

| Plan | Duration | Learners | Branches | Price (KES/term) |
|---|---|---|---|---|
| Free Trial | 30 days | 200 | 1 | — |
| Msingi | 120 days | 200 | 1 | 2,500 |
| Shule | 120 days | 700 | 1 | 5,000 |
| Shule Pro | 120 days | 1,500 | 3 | 9,500 |

- **Active subscription** means `status = active` and `end_date` today or later.
- **No active subscription** (expired, inactive or missing): every staff API returns 402. These stay reachable so the school can sign in and renew:
  - `login`, `logout`, `profile`, `profile-update`, `change-password`;
  - `subscription/*` (request and purchase);
  - `GET plans`, `get-packages`, `get-saas-settings`, `saas-digital-payment`, `administration/general_settings`.
- **Not affected:** the platform admin, and parents and learners. They are already confined to the portal by `RestrictPortalUsers`, so the parent and learner portals keep working when a school expires.
- **Learner limit** is checked only on `POST /api/students` and `POST /api/students-bulk-imports`. It counts learners not deleted. A bulk file bigger than the room left is refused whole.
- **Branch limit** is checked only on `POST /api/branches`. Reading and editing never hit a limit, so a school that is over its limit (for example after a downgrade) keeps working; it just can't add more.
- **Response.** HTTP 402 with `{"status": false, "message": "...", "data": {"code": ...}}`. The app shows `message` in its error snackbar as it is. The codes are:
  - `subscription_expired`, with `expired_on`;
  - `learner_limit_reached`, with `limit` and `plan`;
  - `branch_limit_reached`, with `limit` and `plan`.

  Example: "Your school's subscription expired on 1 Oct 2026. Renew your plan to continue."
- **Renewing.** The school picks a plan in the app, which creates a pending upgrade request. The platform admin approves it (`subscription/approve-request/{id}`). The subscription then runs for the plan's duration from the approval date.

## Not done / still needs a decision

- **Subscription payments aren't verified.** A school's plan purchase only creates a pending request, and the platform admin approves it (SaaS admin → upgrade requests) after confirming the money arrived. Automatic activation needs a server-verified M-Pesa/Paystack callback for SaaS payments.
- **Demo school is over its branch limit.** It is on Shule (1 branch) but has 2 campuses. Both stay usable; adding a third is refused. Move it to Shule Pro if the demo should show multi-campus.
- **Staff RBAC has no seeded teacher account to test with.** No Teacher user is seeded, so the `teacher_panel` paths (attendance, marks, routines, quizzes) were not swept. Endpoints that no rule covers (e.g. the e-learning `course*` APIs and `teacher/*`) still rely on their controllers' own checks.
- **The app's "set default language" call uses GET**, but the route has always been POST, so that button returns 405. Change `localization_repository.dart` to `postData` if the feature is used.
- **Real-money tests.** M-Pesa and Paystack were tested with simulated gateway responses. Run one small live payment with your Daraja sandbox app and your Paystack test keys before launch.
- **iOS** wasn't built (it needs a Mac). **Windows desktop** needs the Visual Studio C++ tools.

## Go-live checklist

1. **Server.** Linux with PHP 8.2+, opcache on, MySQL 8 / MariaDB 10.6+ and HTTPS.
   - Document root: `api/public`
   - Web app on its own domain, with a fallback to `index.html`
2. **`.env`:**
   - `APP_URL` (https), `FRONTEND_URL`, `DB_*`
   - mail settings, `CONTACT_*`
   - `CORS_ALLOWED_ORIGINS` (your app and school domains)
   - `TRUSTED_PROXIES` (if you're behind Cloudflare or a load balancer)
   - `APP_DEBUG=false`
3. **Commands:**
   ```
   composer install --no-dev -o
   php artisan key:generate --force
   php artisan passport:keys --force
   php artisan storage:link
   php artisan migrate --force
   php artisan config:cache
   php artisan route:cache
   ```
4. **Install.** Import `demo.sql` (or use `/install`). Then change every demo password or delete the demo users, and delete `demo.sql` from the server.
5. **Payments.** Each school enters its own Daraja and Paystack keys. Safaricom must reach `https://YOUR-API/api/payment/mpesa/callback/...`. Set the Paystack webhook to `https://YOUR-API/api/payment/paystack/webhook`.
6. **Builds:**
   - Web app:
     ```
     flutter build web --release --dart-define=API_BASE_URL=https://YOUR-API
     ```
   - Android: create an upload key in `android/key.properties`, then run
     ```
     flutter build appbundle --release --dart-define=API_BASE_URL=https://YOUR-API
     ```
7. **Backups.** Nightly database dump plus `storage/app/public`. Monitor `storage/logs`.
