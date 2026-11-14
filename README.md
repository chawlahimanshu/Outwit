# OUTWIT — Are you smarter?

A daily trivia game. Every day at midnight a new rival appears (a 5th grader, a golden retriever, a pirate…) with 7 type-in questions, 45 seconds each. Faster answers score more points, up to 7,000 a day. Your score is your altitude: each day's ride climbs toward the rival's flag.

- Single file: `index.html` (no build step)
- 20 rivals in rotation, each with its own pixel-art scene and ride
- Archive of the last 10 days
- Trophy Room: collect rival cards by beating them, and earn accolades
- Optional player accounts (Supabase): sign up, log in, password reset, progress synced across devices

To add a rival, add an entry to `RIVALS`, a matching scene to `SCENES`, and a ride to `VEHICLES` in `index.html`.

## Turning on accounts (one time, ~10 minutes)

Accounts are off until you connect a free Supabase project. Without them, everything still works and progress is saved per device.

1. **Create the project.** Sign up at [supabase.com](https://supabase.com), click **New project**, give it a name (e.g. `outwit`) and a database password, and wait for it to finish setting up.
2. **Create the table.** Open **SQL Editor → New query**, paste the contents of `supabase-setup.sql`, and click **Run**.
3. **Point emails at your site.** Go to **Authentication → URL Configuration**:
   - **Site URL:** your live game link (e.g. your Amplify `https://main.xxxx.amplifyapp.com`)
   - **Redirect URLs:** add the same link. This is where password-reset and confirmation emails send players.
4. **Copy your keys.** Go to **Project Settings → API** (or **Data API**) and copy the **Project URL** and the **anon public** key.
5. **Paste them into `index.html`:**
   ```js
   const SUPABASE_URL = "https://xxxx.supabase.co";
   const SUPABASE_ANON_KEY = "eyJhbGciOi...";
   ```
   The anon key is meant to be public; the table's Row Level Security keeps each player's data private.
6. Commit and push. Amplify redeploys, and the 👤 button in the top-left corner opens sign-up and log-in.

**Email confirmation:** by default Supabase asks new players to confirm their email before logging in. To skip that while testing, turn off **Authentication → Sign In / Providers → Email → Confirm email**.

**Email sending:** Supabase's built-in email is rate-limited (a few emails per hour) and meant for testing. For a real launch, add your own SMTP provider under **Authentication → Emails → SMTP Settings**.
