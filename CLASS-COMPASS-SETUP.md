# Class Compass: run, configure and deploy

> Before going live, follow the go-live checklist in `PRODUCTION-READINESS.md`.

Class Compass is the rebranded Mighty School Pro v1.6, built for Kenyan schools. It has two parts:

| Part | Folder | Tech |
|---|---|---|
| API, product website and backend | `api/` | Laravel 11, PHP 8.2+ (8.3 used locally), MySQL/MariaDB |
| School app: web, desktop and mobile | `web-app/` | Flutter **3.38.x**. The lockfile needs ≥ 3.38; 3.35 fails to compile. |
| Brand kit and banners | `brand/` | PNG/JPG/ICO |

Deploy from `api/` and `web-app/`. `api-update-patch/` is the vendor's 1.5 → 1.6 patch. It is older than `api/` and lacks this release's changes, so don't use it.

---

## Run locally (this PC)

1. Start MariaDB from the XAMPP Control Panel. The database is `class_compass` (user `root`, no password).
2. Start the server:
   ```
   C:\xampp\apache\bin\httpd.exe -f "C:\Users\ondie\Downloads\Mighty School Pro v1.6\cleaned\dev-server\httpd-classcompass.conf" -DFOREGROUND
   ```
   | URL | What |
   |---|---|
   | http://127.0.0.1:8000 | Product website: landing page, pricing and free-trial sign-up |
   | http://127.0.0.1:5000 | School app (demo school website, then **Login**) |
3. After you change `.env` or the routes, run `php artisan config:cache` and `php artisan route:cache` in `api/`. Threaded Apache on Windows needs a cached config.

### Demo logins

| Role | Email | Password |
|---|---|---|
| Super admin (demo school) | `superadmin@gmail.com` | vendor default (see `SECURITY-AUDIT.md`) |
| SaaS / platform admin | `saasadmin@gmail.com` | vendor default |
| Parent of Wanjiku Kamau (Grade 7) | `parent@classcompass.test` | `ParentDemo2026` |
| Learner | `learner@classcompass.test` | `ParentDemo2026` |

Change or delete all of these before going live.

To re-create the Kenyan demo data in any institute, run `php artisan classcompass:kenya-demo --institute=1 --branch=1 --password=...`. It sets up the CBC classes, fees of KSh 15,000 per term, and the learner and parent accounts above.

---

## New in this release

### Curricula: CBC, 8-4-4, British, College/TVET
- **Master configuration → Curriculum** (`/curriculum`). Pick a preset and click **Apply**. It creates:
  - the classes, with a default stream "A"
  - the subjects for each class
  - the grading scale, also applied class by class
- It never deletes existing classes or subjects, so you can run it again safely. Untick "Replace the grading scale" to keep your current grades.
- The presets:
  - **CBC:** PP1 – Grade 12 with the KNEC 8-level rubric (EE1 90+, EE2 75+, ME1 58+, ME2 41+, AE1 31+, AE2 21+, BE1 11+, BE2 0+)
  - **8-4-4:** Form 3 – 4, KCSE A – E on 12 points
  - **British:** Reception – Year 13, A* – U
  - **College/TVET:** Certificate/Diploma years, graded Distinction, Credit, Pass, Fail
- Schools choose a curriculum when they sign up on the website, and it is applied automatically.
- API: `GET /api/curriculum` and `POST /api/curriculum/apply` (`curriculum`, `classes`, `subjects`, `grades`).

### M-Pesa (Daraja) and Paystack for school fees
Each school connects **its own** Paybill/Till and Paystack account, and the money goes straight to the school.

**School admin setup** (Master configuration → Payment gateway):
1. **M-Pesa (Daraja).** On developer.safaricom.co.ke, create an app with *Lipa na M-Pesa Online* and copy the consumer key, consumer secret and passkey.
   - Choose **Paybill**, or **Till (Buy Goods)**. A Till also needs the store/head-office number as the shortcode.
   - Choose **Sandbox** to test. The sandbox shortcode is `174379` with Safaricom's published sandbox passkey. Switch to **Production** when your live app is approved.
   - Click **Test connection**, then **Save**, then switch the card **on**.
   - Safaricom must be able to reach your API over **public HTTPS**. Set `APP_URL` to it, or fill in "Public API URL for callbacks".
2. **Paystack.** Paste the public and secret keys from your Paystack (Kenya) dashboard, save, and switch the card on.
   - Optional: set the webhook URL to `https://YOUR-API/api/payment/paystack/webhook`.

**Parents and learners** see **Pay School Fees** in the menu (`/pay-fees`):
- The screen shows the outstanding balance, worked out on the server.
- The parent enters an amount and picks M-Pesa (enters their phone and gets an STK prompt) or Paystack (redirected to checkout).
- When the payment is confirmed, it is posted automatically as a normal fee collection: an invoice, the sub-heads paid oldest first, and an accounting voucher on the "Digital Payment" ledger.

**Bursar view:** Fees reports → **Online Fee Payments** (`/online-fee-payments`) lists every payment with its M-Pesa receipt and whether it was posted.

**How a payment is confirmed:**
- **M-Pesa** callback URLs carry an HMAC token, so forged callbacks are rejected. If the callback is late or blocked, the status screen asks Safaricom directly (STK query).
- **Paystack** payments are verified server-side: status, amount and currency must match.
- Confirming twice (callback + poll + webhook) posts the payment only once.

### Product website (`/` on the API domain)
- Kenya-focused landing page with:
  - CBC/curricula and M-Pesa sections
  - per-term pricing in KES, with a term/year toggle and a learner-count plan finder
  - FAQ and SEO/Open Graph tags
  - a working **free-trial sign-up**, which creates the school, admin, curriculum and a 30-day trial
- Pricing is per term. Keep it in sync with the `plans` table:

  | Plan | Price per term | Learners | Branches |
  |---|---|---|---|
  | Free Trial | free for 30 days | 200 | 1 |
  | Msingi | KSh 2,500 | 200 | 1 |
  | Shule | KSh 5,000 | 201 – 700 | 1 |
  | Shule Pro | KSh 9,500 | 701 – 1,500 | 3 |
  | Group & College | custom | — | — |

  The prices are in `resources/views/saas-landing-page.blade.php` (`$plans`). Change them there and in the `plans` table.
- Contact details: set `CONTACT_EMAIL`, `CONTACT_PHONE` and `CONTACT_WHATSAPP` in `.env`. Empty values are hidden. A WhatsApp button appears when `CONTACT_WHATSAPP` is set.

### School website (`/` in the web app)
- Redesigned to match the product site. The page is `lib/feature/landing_page/presentation/screens/school_home_page.dart`. Sections:
  - navigation
  - hero, with the first CMS banner and an "at a glance" panel
  - "How can we help you today?" cards for parents, learners, new families and staff
  - About and Why choose us, from the CMS
  - the CBC learning pathway, with the EE/ME/AE/BE explainer
  - admission steps from the CMS, plus a "What to bring" checklist
  - a step-by-step M-Pesa fee-payment guide with a safety notice
  - parent portal and events, from the CMS
  - testimonials and FAQ (CMS entries plus built-in parent FAQs)
  - contact details, an updates sign-up and the footer
- Everything a school edits in **CMS Management** (banners, about, why choose us, admissions, events, testimonials, FAQ, website settings) appears automatically. Fill in phone, email and address in Website Settings to show them on the contact section.
- The old vendor homepage (`web_landing_page.dart`) is still in the code but no longer routed.

### Branding
- The brand kit is in `brand/`: horizontal logo (with and without tagline), reversed, stacked, icon, reversed icon, monochrome navy and white, navy and light app icons, social avatar and favicon set.
- Banners are in `brand/banners/`:
  - product heroes: CBC, M-Pesa, parents
  - school-site banners, with text and as text-free backgrounds
  - Open Graph image
- The app icons on every platform use the navy icon. The sidebar uses the white-text logo.
- New loading screen: the brand mark in a rotating blue→green ring, rotating status messages and a progress bar. It supports dark mode and reduced motion, and hides when Flutter paints its first frame.
- The demo school is "Compass Academy, Nairobi", with local banners and icons. The old demo's external `i.ibb.co` images are gone.
- School website photos are in `web-app/assets/image/site/`. They are free-licence Unsplash photos (the Unsplash licence allows commercial use without credit) of Kenyan and East African learners and teachers. The `app-*.jpg` files are real screenshots of the parent portal using the demo learner's data. A school's own CMS banner and About images replace the hero and About photos when they load.
- `classcompass:kenya-demo` also gives the demo learner six weeks of attendance and a KSh 15,000 Term 1 M-Pesa payment, so the parent portal has real figures to show.

---

## Rebuild the web app

```
C:\Users\ondie\Documents\Environments\flutter_3.38.6\bin\flutter build web --release --dart-define=API_BASE_URL=https://api.your-domain.co.ke
```
Upload `web-app/build/web/`. The web server must send unknown paths to `index.html`. The bundled service worker is network-first and never touches API calls, so new deployments show up on the next load.

## Deploy the API (production checklist)

1. Upload `api/` and point the document root at `api/public`. Serve it over HTTPS; M-Pesa callbacks require it.
2. Set these in `.env`:
   - `APP_URL` (the public API URL)
   - `FRONTEND_URL` (the web app URL)
   - `DB_*`
   - mail settings
   - `CONTACT_*`
   - `ZOOM_*`, if you use Zoom
3. Run `php artisan key:generate --force`.
4. Install. Either use `/install`, which imports `demo.sql` and now also regenerates the Passport keys, or import `demo.sql` yourself and then run `php artisan migrate --force` and `php artisan passport:keys --force`.
5. Run these:
   ```
   php artisan storage:link
   composer install --no-dev --optimize-autoloader
   php artisan config:cache
   php artisan route:cache
   ```
6. Change every demo password (or delete the demo users) and delete `demo.sql` from the server.
7. Read `SECURITY-AUDIT.md`.
