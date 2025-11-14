# Supabase Email Template Setup

This guide explains how to set up branded email templates for AI Operator Academy in your Supabase project.

## Email Templates Included

1. **SUPABASE_EMAIL_TEMPLATE_CONFIRM.html** - Confirmation email for new signups
2. **SUPABASE_EMAIL_TEMPLATE_RESET_PASSWORD.html** - Password reset email

## Features

- **Brand Colors**: Purple gradient (#9333ea → #7c3aed) matching the site design
- **Dark Theme**: Matches the AI Operator Academy dark mode aesthetic
- **Responsive**: Works on all devices and email clients
- **Professional Layout**: Clean, modern design with icons and clear CTAs
- **Security**: Clear messaging about expiration and security best practices

## Setup Instructions

### Step 1: Access Email Templates

1. Go to your [Supabase Dashboard](https://app.supabase.com)
2. Select your AI Academy project
3. Navigate to **Authentication** → **Email Templates** (in the sidebar)

### Step 2: Configure Confirmation Email

1. Select **"Confirm signup"** from the template dropdown
2. Copy the contents of `SUPABASE_EMAIL_TEMPLATE_CONFIRM.html`
3. Paste into the email template editor
4. The template uses these Supabase variables:
   - `{{ .ConfirmationURL }}` - Auto-populated confirmation link
5. Click **Save**

### Step 3: Configure Password Reset Email

1. Select **"Reset Password"** from the template dropdown
2. Copy the contents of `SUPABASE_EMAIL_TEMPLATE_RESET_PASSWORD.html`
3. Paste into the email template editor
4. The template uses these Supabase variables:
   - `{{ .ConfirmationURL }}` - Auto-populated reset link
5. Click **Save**

### Step 4: Email Provider Settings

By default, Supabase uses their email service (limited to 4 emails/hour for development). For production:

1. Go to **Settings** → **Auth** → **SMTP Settings**
2. Configure your own SMTP provider (recommended):
   - **SendGrid** (free tier: 100 emails/day)
   - **AWS SES** (very low cost)
   - **Mailgun** (pay as you go)
   - **Postmark** (free tier available)

### Step 5: Email Confirmation Settings

**For Development/Testing** (easier):
1. Go to **Authentication** → **Providers** → **Email**
2. Toggle **"Confirm email"** to **OFF**
3. Users can sign in immediately without email verification

**For Production** (recommended):
1. Keep **"Confirm email"** **ON**
2. Users must verify email before accessing the platform
3. Prevents spam accounts and ensures valid email addresses

## Testing Your Emails

1. Create a test account using your email template
2. Check your inbox for the branded confirmation email
3. Verify all links work correctly
4. Test on different email clients (Gmail, Outlook, etc.)

## Customization

To customize the templates further:

- **Colors**: Search for `#9333ea` and `#7c3aed` to change brand colors
- **Logo**: The lightning bolt SVG can be replaced with your logo URL
- **Content**: Update the "What's Next?" section with your specific features
- **Footer**: Update copyright year and company name

## Template Variables

Supabase provides these variables for email templates:

- `{{ .ConfirmationURL }}` - Email confirmation or password reset link
- `{{ .Token }}` - Raw token (use ConfirmationURL instead)
- `{{ .TokenHash }}` - Hashed token (use ConfirmationURL instead)
- `{{ .SiteURL }}` - Your site URL from Auth settings
- `{{ .Email }}` - User's email address

## Troubleshooting

**Emails not sending:**
- Check Supabase Auth logs in Dashboard
- Verify SMTP settings if using custom provider
- Check spam folder
- Verify "Confirm email" toggle matches your setup

**Styling issues:**
- Some email clients strip CSS - the templates use inline styles
- Test in multiple email clients
- Use [Litmus](https://litmus.com/) or [Email on Acid](https://www.emailonacid.com/) for comprehensive testing

**Links not working:**
- Verify Site URL in **Authentication** → **URL Configuration**
- Ensure redirect URLs are added to allowed list
- Check that {{ .ConfirmationURL }} is not modified in template

## Additional Email Templates

You may also want to customize:

- **Magic Link** - Passwordless authentication email
- **Change Email Address** - Email change confirmation
- **Invite User** - Team/admin invite emails (if applicable)

Use the same design system from the provided templates for consistency.

## Support

For Supabase email issues, refer to:
- [Supabase Auth Email Docs](https://supabase.com/docs/guides/auth/auth-email-templates)
- [Supabase SMTP Settings](https://supabase.com/docs/guides/auth/auth-smtp)
