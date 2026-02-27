-- VibeHub Lite seed data
-- Run this after schema.sql

truncate table public.prompts restart identity cascade;
truncate table public.tools restart identity cascade;
truncate table public.user_logins restart identity cascade;

insert into public.prompts (name, prompt_text) values
  ('Edvinas', 'Create a 30-day JavaScript learning plan with daily 45-minute tasks.'),
  ('Norbertas', 'Draft a clean onboarding checklist for a junior frontend developer.'),
  ('Helmes Team', 'Generate 5 concise release note bullet points from merged PR titles.');

insert into public.tools (title, url, description) values
  ('Supabase', 'https://supabase.com', 'Postgres database and backend services.'),
  ('Vue', 'https://vuejs.org', 'Frontend framework used for this project.'),
  ('Vite', 'https://vite.dev', 'Fast local dev server and build tool.');

insert into public.user_logins (email, password_hash) values
  ('demo@vibehub.lt', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f');
