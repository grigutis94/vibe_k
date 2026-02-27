-- VibeHub Lite schema
-- Run this first in Supabase SQL Editor

create table if not exists public.prompts (
  id bigint generated always as identity primary key,
  name text not null,
  prompt_text text not null,
  created_at timestamptz not null default now()
);

create table if not exists public.tools (
  id bigint generated always as identity primary key,
  title text not null,
  url text not null,
  description text not null,
  created_at timestamptz not null default now()
);

create table if not exists public.user_logins (
  id bigint generated always as identity primary key,
  email text not null,
  password_hash text not null,
  created_at timestamptz not null default now()
);

-- Optional but useful indexes
create index if not exists idx_prompts_created_at on public.prompts (created_at desc);
create index if not exists idx_tools_created_at on public.tools (created_at desc);
create index if not exists idx_user_logins_email on public.user_logins (email);

-- Enable Row Level Security
alter table public.prompts enable row level security;
alter table public.tools enable row level security;
alter table public.user_logins enable row level security;

-- Policies for prompts
create policy "prompts_select_anon_auth"
on public.prompts
for select
to anon, authenticated
using (true);

create policy "prompts_insert_anon_auth"
on public.prompts
for insert
to anon, authenticated
with check (true);

-- Policies for tools
create policy "tools_select_anon_auth"
on public.tools
for select
to anon, authenticated
using (true);

create policy "tools_insert_anon_auth"
on public.tools
for insert
to anon, authenticated
with check (true);

-- Policies for user_logins
create policy "user_logins_insert_anon_auth"
on public.user_logins
for insert
to anon, authenticated
with check (true);

-- Optional read policy for admin/testing convenience
create policy "user_logins_select_anon_auth"
on public.user_logins
for select
to anon, authenticated
using (true);
