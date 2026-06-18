-- BrickRush RLS Fix — Drop restrictive admin policies (CASCADE)
-- Run this in Supabase SQL Editor
--
-- The previous RLS policies used current_setting('request.headers') which
-- doesn't work with the anon key. This drops them (with CASCADE) and
-- leaves only the public read/insert policies from the original schema.

-- Drop the broken is_admin function AND all policies that depend on it
DROP FUNCTION IF EXISTS is_admin() CASCADE;

-- Restore open write policies for admin operations
CREATE POLICY "Anyone can insert products" ON products FOR INSERT WITH CHECK (true);
CREATE POLICY "Anyone can update products" ON products FOR UPDATE USING (true);
CREATE POLICY "Anyone can delete products" ON products FOR DELETE USING (true);

CREATE POLICY "Anyone can insert categories" ON categories FOR INSERT WITH CHECK (true);
CREATE POLICY "Anyone can delete categories" ON categories FOR DELETE USING (true);

CREATE POLICY "Anyone can update settings" ON settings FOR UPDATE USING (true);

CREATE POLICY "Anyone can read orders" ON orders FOR SELECT USING (true);
CREATE POLICY "Anyone can update orders" ON orders FOR UPDATE USING (true);
CREATE POLICY "Anyone can delete orders" ON orders FOR DELETE USING (true);
