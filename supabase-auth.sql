-- BrickRush Admin Auth (Simplified)
-- Run this in Supabase SQL Editor

-- ── Admin sessions table ──
CREATE TABLE IF NOT EXISTS admin_sessions (
  token TEXT PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE admin_sessions ENABLE ROW LEVEL SECURITY;

-- Open access for sessions (anyone can read/insert/delete)
CREATE POLICY "Anyone can insert sessions" ON admin_sessions FOR INSERT WITH CHECK (true);
CREATE POLICY "Anyone can read sessions" ON admin_sessions FOR SELECT USING (true);
CREATE POLICY "Anyone can delete sessions" ON admin_sessions FOR DELETE USING (true);
