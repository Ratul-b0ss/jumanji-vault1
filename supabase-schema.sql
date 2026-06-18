-- BrickRush Supabase Schema
-- Run this in Supabase SQL Editor (https://supabase.com/dashboard/project/bpgdniisgxzgrrcqlnwp/sql/new)

-- ── Products table ──
CREATE TABLE IF NOT EXISTS products (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name TEXT NOT NULL,
  price TEXT NOT NULL,
  discount_price TEXT,
  image TEXT NOT NULL,
  category TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ── Categories table ──
CREATE TABLE IF NOT EXISTS categories (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ── Orders table ──
CREATE TABLE IF NOT EXISTS orders (
  id TEXT PRIMARY KEY,
  items_json JSONB NOT NULL DEFAULT '[]',
  subtotal REAL NOT NULL DEFAULT 0,
  delivery_fee REAL NOT NULL DEFAULT 0,
  total REAL NOT NULL DEFAULT 0,
  zone TEXT NOT NULL DEFAULT '',
  customer_name TEXT NOT NULL,
  customer_phone TEXT NOT NULL,
  customer_address TEXT NOT NULL DEFAULT '',
  payment_method TEXT NOT NULL DEFAULT '',
  payment_trxid TEXT NOT NULL DEFAULT '',
  status TEXT NOT NULL DEFAULT 'pending',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ── Settings (single row) ──
CREATE TABLE IF NOT EXISTS settings (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  contact TEXT NOT NULL DEFAULT '',
  bkash TEXT NOT NULL DEFAULT '',
  nagad TEXT NOT NULL DEFAULT '',
  facebook TEXT NOT NULL DEFAULT '',
  instagram TEXT NOT NULL DEFAULT '',
  fee_ctg REAL NOT NULL DEFAULT 70,
  fee_outside REAL NOT NULL DEFAULT 130,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE settings ENABLE ROW LEVEL SECURITY;

-- ── Public read policies (anyone can read products, categories, settings) ──
CREATE POLICY "Public read products" ON products FOR SELECT USING (true);
CREATE POLICY "Public read categories" ON categories FOR SELECT USING (true);
CREATE POLICY "Public read settings" ON settings FOR SELECT USING (true);
CREATE POLICY "Anyone can create orders" ON orders FOR INSERT WITH CHECK (true);

-- ── Insert default settings row ──
INSERT INTO settings (contact, bkash, nagad, fee_ctg, fee_outside)
VALUES ('', '', '', 70, 130);

-- ── Insert default categories ──
INSERT INTO categories (name) VALUES ('Marvel'), ('DC'), ('Anime'), ('Star Wars'), ('One Piece'), ('Stranger Things'), ('Exclusive');

-- ── Insert default products ──
INSERT INTO products (name, price, image, category) VALUES
  ('Iron Man Mk 85', 'Tk 450', 'https://placehold.co/400x533/111/50e3c2?text=Iron+Man&font=inter', 'Marvel'),
  ('Batman Dark Knight', 'Tk 380', 'https://placehold.co/400x533/111/50e3c2?text=Batman&font=inter', 'DC'),
  ('Goku Ultra Instinct', 'Tk 520', 'https://placehold.co/400x533/111/50e3c2?text=Goku&font=inter', 'Anime'),
  ('Eleven', 'Tk 420', 'https://placehold.co/400x533/111/50e3c2?text=Eleven&font=inter', 'Stranger Things'),
  ('Spider-Man Miles', 'Tk 480', 'https://placehold.co/400x533/111/50e3c2?text=Miles&font=inter', 'Marvel'),
  ('Luffy Gear 5', 'Tk 550', 'https://placehold.co/400x533/111/50e3c2?text=Luffy&font=inter', 'One Piece'),
  ('Mandalorian', 'Tk 600', 'https://placehold.co/400x533/111/50e3c2?text=Mando&font=inter', 'Star Wars'),
  ('Naruto Baryon', 'Tk 520', 'https://placehold.co/400x533/111/50e3c2?text=Naruto&font=inter', 'Anime'),
  ('Wolverine Logan', 'Tk 460', 'https://placehold.co/400x533/111/50e3c2?text=Wolverine&font=inter', 'Marvel'),
  ('Joker Heath', 'Tk 400', 'https://placehold.co/400x533/111/50e3c2?text=Joker&font=inter', 'DC'),
  ('Tanjiro Sun', 'Tk 490', 'https://placehold.co/400x533/111/50e3c2?text=Tanjiro&font=inter', 'Anime'),
  ('Darth Vader', 'Tk 650', 'https://placehold.co/400x533/111/50e3c2?text=Vader&font=inter', 'Star Wars');

-- ═══════════════════════════════════════════
-- MIGRATION: Add social link columns (run if table already exists)
-- ═══════════════════════════════════════════
-- Only needed if you already created the settings table without these columns.
-- Run this in the Supabase SQL Editor after the main schema.
/*
ALTER TABLE settings ADD COLUMN facebook TEXT NOT NULL DEFAULT '';
ALTER TABLE settings ADD COLUMN instagram TEXT NOT NULL DEFAULT '';
*/
