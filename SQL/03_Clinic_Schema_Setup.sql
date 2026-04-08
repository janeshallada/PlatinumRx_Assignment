-- =============================================
-- 1. TABLE CREATION (Schema)
-- =============================================

CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(15)
);

CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10, 2),
    datetime DATETIME,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description TEXT,
    amount DECIMAL(10, 2),
    datetime DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- =============================================
-- 2. DATA INSERTION (Sample Data)
-- =============================================

-- Clinics
INSERT INTO clinics (cid, clinic_name, city, state, country) VALUES 
('cnc-0100001', 'XYZ Clinic', 'Mumbai', 'Maharashtra', 'India'),
('cnc-0100002', 'ABC Wellness', 'Bangalore', 'Karnataka', 'India'),
('cnc-0100003', 'City Health', 'Mumbai', 'Maharashtra', 'India');

-- Customers
INSERT INTO customer (uid, name, mobile) VALUES 
('bk-09f3e-95hj', 'John Doe', '97XXXXXXXX'),
('uid-unique-22', 'Sarah Connor', '98XXXXXXXX'),
('uid-unique-33', 'Mike Ross', '99XXXXXXXX');

-- Clinic Sales (Revenue)
INSERT INTO clinic_sales (oid, uid, cid, amount, datetime, sales_channel) VALUES 
('ord-00100-00100', 'bk-09f3e-95hj', 'cnc-0100001', 24999, '2021-09-23 12:03:22', 'sodat'),
('ord-00100-00101', 'uid-unique-22', 'cnc-0100001', 15000, '2021-09-25 10:00:00', 'direct'),
('ord-00100-00102', 'uid-unique-33', 'cnc-0100002', 50000, '2021-10-05 14:30:00', 'online'),
('ord-00100-00103', 'bk-09f3e-95hj', 'cnc-0100003', 12000, '2021-11-12 09:15:00', 'sodat');

-- Expenses
INSERT INTO expenses (eid, cid, description, amount, datetime) VALUES 
('exp-0100-00100', 'cnc-0100001', 'first-aid supplies', 557, '2021-09-23 07:36:48'),
('exp-0100-00101', 'cnc-0100001', 'rent', 5000, '2021-09-01 00:00:00'),
('exp-0100-00102', 'cnc-0100002', 'equipment repair', 12000, '2021-10-10 11:00:00'),
('exp-0100-00103', 'cnc-0100003', 'staff salary', 8000, '2021-11-01 09:00:00');