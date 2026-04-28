CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE,
    email VARCHAR(255) UNIQUE,
    password_hash VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    price DECIMAL(10,2),
    stock INT DEFAULT 0
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    total DECIMAL(10,2),
    status VARCHAR(50) DEFAULT 'pending'
);

INSERT INTO products VALUES (1, 'DevOps Course', 'Mastery', 99.99, 100);
INSERT INTO products VALUES (2, 'Kubernetes', 'Production', 49.99, 50);
INSERT INTO products VALUES (3, 'Docker Guide', 'Deep dive', 79.99, 75);
