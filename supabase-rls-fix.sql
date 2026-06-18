-- BrickRush RLS Security Fix
-- Run this in Supabase SQL Editor
-- This adds proper RLS policies so only admin (with valid session) can write

-- ── Helper function to check admin token ──
-- This lets us reuse the same check across multiple policies
CREATE OR REPLACE FUNCTION is_admin()
RETURNS BOOLEAN AS $$
  SELECT EXISTS (
    SELECT 1 FROM admin_sessions
    WHERE token = current_setting('request.headers')::json->>'x-admin-token'
  );
$$ LANGUAGE sql STABLE SECURITY DEFINER;

-- ── Products: restrict write operations to admin only ──
DROP POLICY IF EXISTS "Admin insert products" ON products;
DROP POLICY IF EXISTS "Admin update products" ON products;
DROP POLICY IF EXISTS "Admin delete products" ON products;

CREATE POLICY "Admin insert products" ON products
  FOR INSERT WITH CHECK (is_admin());

CREATE POLICY "Admin update products" ON products
  FOR UPDATE USING (is_admin());

CREATE POLICY "Admin delete products" ON products
  FOR DELETE USING (is_admin());

-- ── Categories: restrict write operations to admin only ──
DROP POLICY IF EXISTS "Admin insert categories" ON categories;
DROP POLICY IF EXISTS "Admin delete categories" ON categories;

CREATE POLICY "Admin insert categories" ON categories
  FOR INSERT WITH CHECK (is_admin());

CREATE POLICY "Admin delete categories" ON categories
  FOR DELETE USING (is_admin());

-- ── Settings: restrict update to admin only ──
DROP POLICY IF EXISTS "Admin update settings" ON settings;

CREATE POLICY "Admin update settings" ON settings
  FOR UPDATE USING (is_admin());

-- ── Orders: restrict read/update/delete to admin only ──
DROP POLICY IF EXISTS "Admin read orders" ON orders;
DROP POLICY IF EXISTS "Admin update orders" ON orders;
DROP POLICY IF EXISTS "Admin delete orders" ON orders;

CREATE POLICY "Admin read orders" ON orders
  FOR SELECT USING (is_admin());

CREATE POLICY "Admin update orders" ON orders
  FOR UPDATE USING (is_admin());

CREATE POLICY "Admin delete orders" ON orders
  FOR DELETE USING (is_admin());
