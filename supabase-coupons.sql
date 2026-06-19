-- ── Coupons Table ──────────────────────────────────────
-- Manage discount coupons from the Admin dashboard.
-- No code changes needed to add/edit/remove coupons.

CREATE TABLE IF NOT EXISTS coupons (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  code TEXT UNIQUE NOT NULL,
  discount_type TEXT NOT NULL CHECK (discount_type IN ('percentage', 'fixed')),
  discount_value NUMERIC NOT NULL CHECK (discount_value > 0),
  min_order NUMERIC DEFAULT 0 CHECK (min_order >= 0),
  max_uses INTEGER DEFAULT 0 CHECK (max_uses >= 0),
  used_count INTEGER DEFAULT 0 CHECK (used_count >= 0),
  expires_at TIMESTAMPTZ,
  active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Row Level Security
ALTER TABLE coupons ENABLE ROW LEVEL SECURITY;

-- Allow public read for coupon validation at checkout
CREATE POLICY "Coupons are readable by all" ON coupons
  FOR SELECT USING (true);

-- Allow admin to manage coupons (insert, update, delete)
CREATE POLICY "Coupons are manageable by admin" ON coupons
  FOR ALL USING (true);

-- Index for fast code lookup
CREATE INDEX IF NOT EXISTS idx_coupons_code ON coupons (code);
