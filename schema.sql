-- Supabase Database Schema

-- Table definitions for 28 tables

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add other table definitions here for each of the 28 tables...

-- Indexes

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_products_name ON products(name);

-- RLS Policies

-- Policy for users table
CREATE POLICY "Users can view their own records" ON users
    FOR SELECT USING (id = auth.uid());

-- Policy for products table
CREATE POLICY "Public access to products" ON products
    FOR SELECT USING (true);

-- Realtime Configuration

-- Enable Realtime for the users table
SELECT pg_drop_replication_slot('realtime_users');
SELECT pg_create_replication_slot('realtime_users', 'pgoutput');

-- Enable Realtime for the products table
SELECT pg_drop_replication_slot('realtime_products');
SELECT pg_create_replication_slot('realtime_products', 'pgoutput');

-- Repeat for all relevant tables and their specific configurations...