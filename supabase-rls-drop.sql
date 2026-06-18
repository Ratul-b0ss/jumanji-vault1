-- BrickRush RLS Fix — Drop restrictive admin policies
-- Run this in Supabase SQL Editor
--
-- The previous RLS policies used current_setting('request.headers') which
-- doesn't work with the anon key. This drops them and leaves only the
-- public read/insert policies from the original schema.

-- Drop the broken is_admin function
DROP FUNCTION IF EXISTS is_admin();

-- Drop restrictive policies on products
DROP POLICY IF EXISTS "Admin insert products" ON products;
DROP POLICY IF EXISTS "Admin update products" ON products;
DROP POLICY IF EXISTS "Admin delete products" ON products;

-- Drop restrictive policies on categories
DROP POLICY IF EXISTS "Admin insert categories" ON categories;
DROP POLICY IF EXISTS "Admin delete categories" ON categories;

-- Drop restrictive policies on settings
DROP POLICY IF EXISTS "Admin update settings" ON settings;

-- Drop restrictive policies on orders
DROP POLICY IF EXISTS "Admin read orders" ON orders;
DROP POLICY IF EXISTS "Admin update orders" ON orders;
DROP POLICY IF EXISTS "Admin delete orders" ON orders;

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
