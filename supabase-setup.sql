-- Outwit: one-time database setup for player accounts.
-- In Supabase: SQL Editor -> New query -> paste all of this -> Run.

-- One row per player holding their saved games (trophies are worked out from these).
create table if not exists public.progress (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  data       jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

-- Row Level Security: each player can only ever read and write their own row.
alter table public.progress enable row level security;

drop policy if exists "Players read own progress"   on public.progress;
drop policy if exists "Players insert own progress" on public.progress;
drop policy if exists "Players update own progress" on public.progress;

create policy "Players read own progress"   on public.progress
  for select using (auth.uid() = user_id);
create policy "Players insert own progress" on public.progress
  for insert with check (auth.uid() = user_id);
create policy "Players update own progress" on public.progress
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
