# VibeHub Lite (Vite + Vue + Supabase)

Minimal light-themed project with two pages:

- `/prompts` for AI prompts
- `/tools` for useful links

Both pages are connected to Supabase for loading and inserting data.

## 1) Install

```bash
npm install
```

## 2) Environment variables

Create `.env` from `.env.example` and fill in values:

```env
VITE_SUPABASE_URL=https://your-project-ref.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key
```

## 3) Supabase tables

Run in Supabase SQL editor:

```sql
create table if not exists prompts (
  id bigint generated always as identity primary key,
  name text not null,
  prompt_text text not null,
  created_at timestamptz not null default now()
);

create table if not exists tools (
  id bigint generated always as identity primary key,
  title text not null,
  url text not null,
  description text not null,
  created_at timestamptz not null default now()
);
```

If RLS is enabled, add policies for `select` and `insert` for anon/authenticated users as needed.

## 4) Run

```bash
npm run dev
```

## 5) Build

```bash
npm run build
npm run preview
```
