create database foodrush;
use foodrush;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL UNIQUE,
    address VARCHAR(255),
    city VARCHAR(50),
    registration_date DATE,
    status VARCHAR(20) DEFAULT 'Active'
);
show tables;
CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_name VARCHAR(100) NOT NULL,
    owner_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    address VARCHAR(255),
    city VARCHAR(50),
    cuisine_type VARCHAR(50),
    opening_time TIME,
    closing_time TIME,
    rating DECIMAL(2,1),
    status VARCHAR(20) DEFAULT 'Active',
    CHECK (rating BETWEEN 1 AND 5)
);
show tables;
CREATE TABLE food_categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255)
);
show tables;
CREATE TABLE menu_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT NOT NULL,
    category_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    price DECIMAL(10,2) NOT NULL,
    is_vegetarian BOOLEAN DEFAULT TRUE,
    is_available BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id),

    FOREIGN KEY (category_id)
        REFERENCES food_categories(category_id),

    CHECK (price > 0)
);
show tables;
CREATE TABLE delivery_partners (
    delivery_partner_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    joining_date DATE,
    vehicle_type VARCHAR(30),
    vehicle_number VARCHAR(20) UNIQUE,
    status VARCHAR(20) DEFAULT 'Available'
);
show tables;


CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    delivery_partner_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    delivery_address VARCHAR(255) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    delivery_fee DECIMAL(10,2) DEFAULT 0.00,
    discount DECIMAL(10,2) DEFAULT 0.00,
    tax DECIMAL(10,2) DEFAULT 0.00,
    total_amount DECIMAL(10,2) NOT NULL,
    order_status VARCHAR(30) DEFAULT 'Placed',

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id),

    FOREIGN KEY (delivery_partner_id)
        REFERENCES delivery_partners(delivery_partner_id),

    CHECK (subtotal >= 0),
    CHECK (delivery_fee >= 0),
    CHECK (discount >= 0),
    CHECK (tax >= 0),
    CHECK (total_amount >= 0)
);
show tables;


CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (item_id)
        REFERENCES menu_items(item_id),

    CHECK (quantity > 0),
    CHECK (unit_price > 0),
    CHECK (subtotal >= 0)
);
show tables;


CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(30) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_status VARCHAR(20) DEFAULT 'Pending',
    transaction_reference VARCHAR(100) UNIQUE,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CHECK (amount >= 0)
);
show tables;


CREATE TABLE deliveries (
    delivery_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    delivery_partner_id INT NOT NULL,
    assigned_time DATETIME,
    pickup_time DATETIME,
    delivery_time DATETIME,
    delivery_status VARCHAR(20) DEFAULT 'Assigned',

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (delivery_partner_id)
        REFERENCES delivery_partners(delivery_partner_id)
);
show tables;


CREATE TABLE coupons (
    coupon_id INT PRIMARY KEY AUTO_INCREMENT,
    coupon_code VARCHAR(30) NOT NULL UNIQUE,
    description VARCHAR(255),
    discount_type VARCHAR(20) NOT NULL,
    discount_value DECIMAL(10,2) NOT NULL,
    minimum_order_amount DECIMAL(10,2) DEFAULT 0.00,
    maximum_discount DECIMAL(10,2),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Active',

    CHECK (discount_value > 0),
    CHECK (minimum_order_amount >= 0),
    CHECK (maximum_discount IS NULL OR maximum_discount > 0),
    CHECK (end_date >= start_date)
);
show tables;


CREATE TABLE order_coupons (
    order_coupon_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    coupon_id INT NOT NULL,
    discount_amount DECIMAL(10,2) DEFAULT 0.00,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (coupon_id)
        REFERENCES coupons(coupon_id),

    CHECK (discount_amount >= 0)
);
show tables;


CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    rating INT NOT NULL,
    review_text VARCHAR(500),
    review_date DATE DEFAULT (CURRENT_DATE),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id),

    CHECK (rating BETWEEN 1 AND 5)
);
show tables;
use foodrush;
show tables;
DESCRIBE customers;
DESCRIBE restaurants;
DESCRIBE food_categories;
DESCRIBE menu_items;
DESCRIBE delivery_partners;
DESCRIBE orders;
DESCRIBE order_items;
DESCRIBE payments;
DESCRIBE deliveries;
DESCRIBE coupons;
DESCRIBE order_coupons;
DESCRIBE reviews;
show tables;
USE foodrush;

INSERT INTO food_categories
(category_name, description)
VALUES
('Pizza', 'Italian style pizzas'),
('Burger', 'Different types of burgers'),
('Indian', 'Traditional Indian food'),
('Chinese', 'Chinese and Indo-Chinese food'),
('Desserts', 'Sweet dishes and desserts'),
('Beverages', 'Hot and cold beverages'),
('South Indian', 'South Indian dishes'),
('Fast Food', 'Quick and popular fast food'),
('Biryani', 'Different varieties of biryani'),
('Healthy Food', 'Healthy and nutritious meals');
select * from food_categories;


INSERT INTO restaurants
(restaurant_name, owner_name, phone, email, address, city,
 cuisine_type, opening_time, closing_time, rating, status)
VALUES
('Spice Garden', 'Rahul Sharma', '9876500001', 'spicegarden@gmail.com',
 'MG Road', 'Mumbai', 'Indian', '10:00:00', '23:00:00', 4.6, 'Active'),

('Pizza Palace', 'Amit Patel', '9876500002', 'pizzapalace@gmail.com',
 'FC Road', 'Pune', 'Pizza', '11:00:00', '23:30:00', 4.4, 'Active'),

('Royal Biryani House', 'Imran Khan', '9876500003', 'royalbiryani@gmail.com',
 'Andheri East', 'Mumbai', 'Biryani', '11:00:00', '23:00:00', 4.7, 'Active'),

('Dragon Wok', 'Neha Joshi', '9876500004', 'dragonwok@gmail.com',
 'Baner Road', 'Pune', 'Chinese', '11:00:00', '22:30:00', 4.3, 'Active'),

('Burger Hub', 'Rohit Mehta', '9876500005', 'burgerhub@gmail.com',
 'Vashi Sector 17', 'Navi Mumbai', 'Fast Food', '10:30:00', '23:30:00', 4.2, 'Active'),

('South Spice', 'Priya Nair', '9876500006', 'southspice@gmail.com',
 'Indiranagar', 'Bengaluru', 'South Indian', '07:30:00', '22:00:00', 4.8, 'Active'),

('Sweet Treats', 'Pooja Shah', '9876500007', 'sweettreats@gmail.com',
 'Powai', 'Mumbai', 'Desserts', '12:00:00', '23:00:00', 4.5, 'Active'),

('Healthy Bowl', 'Karan Verma', '9876500008', 'healthybowl@gmail.com',
 'Hinjewadi', 'Pune', 'Healthy Food', '08:00:00', '21:30:00', 4.6, 'Active'),

('Cafe Delight', 'Sneha Kulkarni', '9876500009', 'cafedelight@gmail.com',
 'Airoli', 'Navi Mumbai', 'Beverages', '08:00:00', '22:00:00', 4.1, 'Active'),

('Tasty Corner', 'Vikas Gupta', '9876500010', 'tastycorner@gmail.com',
 'Thane West', 'Thane', 'Fast Food', '10:00:00', '22:30:00', 4.0, 'Active'),

('Urban Tadka', 'Manish Singh', '9876500011', 'urbantadka@gmail.com',
 'Goregaon West', 'Mumbai', 'Indian', '11:00:00', '23:00:00', 4.5, 'Active'),

('Chaat Junction', 'Riya Desai', '9876500012', 'chaatjunction@gmail.com',
 'Kothrud', 'Pune', 'Indian', '10:00:00', '22:00:00', 4.2, 'Active'),

('The Pasta House', 'Arjun Rao', '9876500013', 'pastahouse@gmail.com',
 'Whitefield', 'Bengaluru', 'Pizza', '11:30:00', '23:00:00', 4.4, 'Active'),

('Bowl & Grill', 'Sahil Kapoor', '9876500014', 'bowlandgrill@gmail.com',
 'Nerul', 'Navi Mumbai', 'Healthy Food', '11:00:00', '22:30:00', 4.3, 'Active'),

('Food Street', 'Anjali Patil', '9876500015', 'foodstreet@gmail.com',
 'Dadar', 'Mumbai', 'Fast Food', '10:00:00', '23:00:00', 4.1, 'Active');
 select * from restaurants;
 SELECT restaurant_id, restaurant_name, city, cuisine_type, rating
FROM restaurants;
USE foodrush;

INSERT INTO delivery_partners
(first_name, last_name, phone, email, joining_date,
 vehicle_type, vehicle_number, status)
VALUES
('Ravi', 'Patil', '9876510001', 'ravi.patil@gmail.com', '2024-01-15', 'Bike', 'MH01AB1001', 'Available'),
('Aakash', 'Shinde', '9876510002', 'aakash.shinde@gmail.com', '2024-02-10', 'Bike', 'MH02CD1002', 'Busy'),
('Suresh', 'Jadhav', '9876510003', 'suresh.jadhav@gmail.com', '2024-03-05', 'Scooter', 'MH43EF1003', 'Available'),
('Vijay', 'More', '9876510004', 'vijay.more@gmail.com', '2024-04-12', 'Bike', 'MH04GH1004', 'Offline'),
('Rahul', 'Kadam', '9876510005', 'rahul.kadam@gmail.com', '2024-05-20', 'Bike', 'MH05IJ1005', 'Available'),
('Prakash', 'Gaikwad', '9876510006', 'prakash.gaikwad@gmail.com', '2024-06-18', 'Scooter', 'MH06KL1006', 'Busy'),
('Nitin', 'Pawar', '9876510007', 'nitin.pawar@gmail.com', '2024-07-22', 'Bike', 'MH07MN1007', 'Available'),
('Akshay', 'Deshmukh', '9876510008', 'akshay.deshmukh@gmail.com', '2024-08-14', 'Bike', 'MH08OP1008', 'Available'),
('Ganesh', 'Bhosale', '9876510009', 'ganesh.bhosale@gmail.com', '2024-09-09', 'Scooter', 'MH09QR1009', 'Offline'),
('Rohan', 'Kulkarni', '9876510010', 'rohan.kulkarni@gmail.com', '2024-10-11', 'Bike', 'MH10ST1010', 'Busy'),
('Sameer', 'Joshi', '9876510011', 'sameer.joshi@gmail.com', '2024-11-03', 'Bike', 'MH11UV1011', 'Available'),
('Mahesh', 'Salunkhe', '9876510012', 'mahesh.salunkhe@gmail.com', '2024-12-16', 'Scooter', 'MH12WX1012', 'Available'),
('Deepak', 'Sawant', '9876510013', 'deepak.sawant@gmail.com', '2025-01-08', 'Bike', 'MH13YZ1013', 'Busy'),
('Sachin', 'Chavan', '9876510014', 'sachin.chavan@gmail.com', '2025-02-19', 'Bike', 'MH14AA1014', 'Available'),
('Manoj', 'Thakur', '9876510015', 'manoj.thakur@gmail.com', '2025-03-21', 'Scooter', 'MH15BB1015', 'Offline'),
('Kunal', 'Mehta', '9876510016', 'kunal.mehta@gmail.com', '2025-04-13', 'Bike', 'MH16CC1016', 'Available'),
('Vishal', 'Verma', '9876510017', 'vishal.verma@gmail.com', '2025-05-17', 'Bike', 'MH17DD1017', 'Busy'),
('Harish', 'Rane', '9876510018', 'harish.rane@gmail.com', '2025-06-25', 'Scooter', 'MH18EE1018', 'Available'),
('Sanjay', 'Yadav', '9876510019', 'sanjay.yadav@gmail.com', '2025-07-07', 'Bike', 'MH19FF1019', 'Available'),
('Amol', 'Kore', '9876510020', 'amol.kore@gmail.com', '2025-08-29', 'Bike', 'MH20GG1020', 'Busy'),
('Dinesh', 'Mhatre', '9876510021', 'dinesh.mhatre@gmail.com', '2025-09-15', 'Scooter', 'MH21HH1021', 'Available'),
('Yash', 'Pawar', '9876510022', 'yash.pawar@gmail.com', '2025-10-20', 'Bike', 'MH22II1022', 'Offline'),
('Swapnil', 'Patil', '9876510023', 'swapnil.patil@gmail.com', '2025-11-12', 'Bike', 'MH23JJ1023', 'Available'),
('Aditya', 'Raut', '9876510024', 'aditya.raut@gmail.com', '2025-12-05', 'Scooter', 'MH24KK1024', 'Busy'),
('Omkar', 'Shah', '9876510025', 'omkar.shah@gmail.com', '2026-01-10', 'Bike', 'MH25LL1025', 'Available');

SELECT
    delivery_partner_id,
    first_name,
    last_name,
    vehicle_type,
    status
FROM delivery_partners;
USE foodrush;

INSERT INTO customers
(first_name, last_name, email, phone, address, city, registration_date, status)
VALUES
('Aarav','Sharma','aarav.sharma@gmail.com','9000000001','Andheri East','Mumbai','2025-01-05','Active'),
('Ananya','Patel','ananya.patel@gmail.com','9000000002','Vashi Sector 17','Navi Mumbai','2025-01-10','Active'),
('Rohan','Desai','rohan.desai@gmail.com','9000000003','Kothrud','Pune','2025-01-15','Active'),
('Priya','Joshi','priya.joshi@gmail.com','9000000004','Thane West','Thane','2025-01-20','Active'),
('Aditya','Kulkarni','aditya.kulkarni@gmail.com','9000000005','Airoli','Navi Mumbai','2025-01-25','Active'),
('Sneha','Patil','sneha.patil@gmail.com','9000000006','Dadar','Mumbai','2025-02-01','Active'),
('Vivek','Shah','vivek.shah@gmail.com','9000000007','Baner','Pune','2025-02-05','Active'),
('Neha','Verma','neha.verma@gmail.com','9000000008','Powai','Mumbai','2025-02-10','Active'),
('Karan','Mehta','karan.mehta@gmail.com','9000000009','Nerul','Navi Mumbai','2025-02-15','Active'),
('Pooja','Rane','pooja.rane@gmail.com','9000000010','Goregaon West','Mumbai','2025-02-20','Active'),
('Rahul','Pawar','rahul.pawar@gmail.com','9000000011','Wakad','Pune','2025-03-01','Active'),
('Isha','Nair','isha.nair@gmail.com','9000000012','Indiranagar','Bengaluru','2025-03-05','Active'),
('Sahil','Gupta','sahil.gupta@gmail.com','9000000013','Hinjewadi','Pune','2025-03-10','Active'),
('Kavya','Singh','kavya.singh@gmail.com','9000000014','Whitefield','Bengaluru','2025-03-15','Active'),
('Amit','Jadhav','amit.jadhav@gmail.com','9000000015','Vikhroli','Mumbai','2025-03-20','Active'),
('Simran','Kaur','simran.kaur@gmail.com','9000000016','Kurla','Mumbai','2025-03-25','Active'),
('Nikhil','More','nikhil.more@gmail.com','9000000017','Pimpri','Pune','2025-04-01','Active'),
('Riya','Deshmukh','riya.deshmukh@gmail.com','9000000018','Kalyan','Thane','2025-04-05','Active'),
('Suresh','Bhosale','suresh.bhosale@gmail.com','9000000019','Ghatkopar','Mumbai','2025-04-10','Active'),
('Meera','Iyer','meera.iyer@gmail.com','9000000020','Koramangala','Bengaluru','2025-04-15','Active'),
('Vishal','Chavan','vishal.chavan@gmail.com','9000000021','Vashi','Navi Mumbai','2025-04-20','Active'),
('Tanvi','Shinde','tanvi.shinde@gmail.com','9000000022','Mulund','Mumbai','2025-04-25','Active'),
('Akash','Raut','akash.raut@gmail.com','9000000023','Hadapsar','Pune','2025-05-01','Active'),
('Shreya','Kadam','shreya.kadam@gmail.com','9000000024','Airoli','Navi Mumbai','2025-05-05','Active'),
('Manish','Yadav','manish.yadav@gmail.com','9000000025','Andheri West','Mumbai','2025-05-10','Active'),
('Divya','Rao','divya.rao@gmail.com','9000000026','Marathahalli','Bengaluru','2025-05-15','Active'),
('Omkar','Sawant','omkar.sawant@gmail.com','9000000027','Thane West','Thane','2025-05-20','Active'),
('Nandini','Joshi','nandini.joshi@gmail.com','9000000028','Pune Camp','Pune','2025-05-25','Active'),
('Yash','Patil','yash.patil@gmail.com','9000000029','Nerul','Navi Mumbai','2025-06-01','Active'),
('Mansi','Shah','mansi.shah@gmail.com','9000000030','Bandra West','Mumbai','2025-06-05','Active'),
('Siddharth','Mehta','siddharth.mehta@gmail.com','9000000031','Viman Nagar','Pune','2025-06-10','Active'),
('Ayesha','Khan','ayesha.khan@gmail.com','9000000032','Jogeshwari','Mumbai','2025-06-15','Active'),
('Harsh','Verma','harsh.verma@gmail.com','9000000033','Kharadi','Pune','2025-06-20','Active'),
('Swati','Pawar','swati.pawar@gmail.com','9000000034','Belapur','Navi Mumbai','2025-06-25','Active'),
('Dev','Malhotra','dev.malhotra@gmail.com','9000000035','Powai','Mumbai','2025-07-01','Active'),
('Komal','Jadhav','komal.jadhav@gmail.com','9000000036','Wakad','Pune','2025-07-05','Active'),
('Varun','Nair','varun.nair@gmail.com','9000000037','Electronic City','Bengaluru','2025-07-10','Active'),
('Pallavi','Desai','pallavi.desai@gmail.com','9000000038','Dadar','Mumbai','2025-07-15','Active'),
('Aniket','Mhatre','aniket.mhatre@gmail.com','9000000039','Ghansoli','Navi Mumbai','2025-07-20','Active'),
('Shruti','Kulkarni','shruti.kulkarni@gmail.com','9000000040','Kothrud','Pune','2025-07-25','Active'),
('Raj','Thakur','raj.thakur@gmail.com','9000000041','Borivali','Mumbai','2025-08-01','Active'),
('Monika','Gupta','monika.gupta@gmail.com','9000000042','Aundh','Pune','2025-08-05','Active'),
('Abhishek','Rane','abhishek.rane@gmail.com','9000000043','Sanpada','Navi Mumbai','2025-08-10','Active'),
('Sakshi','More','sakshi.more@gmail.com','9000000044','Malad West','Mumbai','2025-08-15','Active'),
('Jay','Shinde','jay.shinde@gmail.com','9000000045','Pimple Saudagar','Pune','2025-08-20','Active'),
('Rutuja','Pawar','rutuja.pawar@gmail.com','9000000046','Vashi','Navi Mumbai','2025-08-25','Active'),
('Arjun','Rao','arjun.rao@gmail.com','9000000047','Whitefield','Bengaluru','2025-09-01','Active'),
('Sonali','Patil','sonali.patil@gmail.com','9000000048','Thane West','Thane','2025-09-05','Active'),
('Tejas','Deshmukh','tejas.deshmukh@gmail.com','9000000049','Goregaon East','Mumbai','2025-09-10','Active'),
('Bhakti','Joshi','bhakti.joshi@gmail.com','9000000050','Nerul','Navi Mumbai','2025-09-15','Active');

SELECT COUNT(*) AS total_customers
FROM customers;

USE foodrush;

INSERT INTO menu_items
(restaurant_id, category_id, item_name, description, price, is_vegetarian, is_available)
VALUES
(1, 3, 'Paneer Butter Masala', 'Creamy paneer curry', 280.00, TRUE, TRUE),
(1, 3, 'Dal Tadka', 'Yellow lentils with spices', 180.00, TRUE, TRUE),
(1, 3, 'Butter Naan', 'Soft Indian flatbread', 60.00, TRUE, TRUE),
(1, 9, 'Chicken Biryani', 'Aromatic chicken biryani', 320.00, FALSE, TRUE),
(1, 5, 'Gulab Jamun', 'Indian sweet dessert', 100.00, TRUE, TRUE),
(1, 6, 'Mango Lassi', 'Refreshing mango drink', 120.00, TRUE, TRUE),
(1, 8, 'Veg Sandwich', 'Fresh vegetable sandwich', 150.00, TRUE, TRUE),

(2, 1, 'Margherita Pizza', 'Classic cheese pizza', 299.00, TRUE, TRUE),
(2, 1, 'Farmhouse Pizza', 'Vegetable loaded pizza', 399.00, TRUE, TRUE),
(2, 1, 'Paneer Pizza', 'Paneer and cheese pizza', 429.00, TRUE, TRUE),
(2, 8, 'French Fries', 'Crispy potato fries', 149.00, TRUE, TRUE),
(2, 6, 'Cold Coffee', 'Chilled creamy coffee', 139.00, TRUE, TRUE),
(2, 5, 'Chocolate Brownie', 'Warm chocolate brownie', 179.00, TRUE, TRUE),
(2, 8, 'Garlic Bread', 'Cheesy garlic bread', 199.00, TRUE, TRUE),

(3, 9, 'Chicken Dum Biryani', 'Traditional chicken dum biryani', 349.00, FALSE, TRUE),
(3, 9, 'Mutton Biryani', 'Aromatic mutton biryani', 449.00, FALSE, TRUE),
(3, 9, 'Veg Biryani', 'Mixed vegetable biryani', 279.00, TRUE, TRUE),
(3, 3, 'Chicken Tikka', 'Grilled chicken tikka', 329.00, FALSE, TRUE),
(3, 5, 'Phirni', 'Traditional rice pudding', 120.00, TRUE, TRUE),
(3, 6, 'Masala Chaas', 'Spiced buttermilk', 80.00, TRUE, TRUE),
(3, 8, 'Chicken Seekh Roll', 'Spiced chicken roll', 220.00, FALSE, TRUE),

(4, 4, 'Veg Hakka Noodles', 'Stir fried noodles', 220.00, TRUE, TRUE),
(4, 4, 'Chicken Hakka Noodles', 'Chicken stir fried noodles', 280.00, FALSE, TRUE),
(4, 4, 'Veg Manchurian', 'Crispy vegetable balls', 210.00, TRUE, TRUE),
(4, 4, 'Chicken Manchurian', 'Chicken in spicy sauce', 290.00, FALSE, TRUE),
(4, 4, 'Schezwan Fried Rice', 'Spicy fried rice', 240.00, TRUE, TRUE),
(4, 6, 'Lemon Iced Tea', 'Chilled lemon tea', 110.00, TRUE, TRUE),
(4, 5, 'Honey Noodles', 'Sweet noodle dessert', 160.00, TRUE, TRUE),

(5, 8, 'Classic Veg Burger', 'Vegetable patty burger', 179.00, TRUE, TRUE),
(5, 8, 'Chicken Burger', 'Crispy chicken burger', 229.00, FALSE, TRUE),
(5, 8, 'Cheese Burger', 'Cheesy classic burger', 249.00, TRUE, TRUE),
(5, 8, 'Peri Peri Fries', 'Spicy potato fries', 169.00, TRUE, TRUE),
(5, 6, 'Cold Drink', 'Chilled soft drink', 80.00, TRUE, TRUE),
(5, 5, 'Chocolate Shake', 'Rich chocolate milkshake', 199.00, TRUE, TRUE),
(5, 5, 'Vanilla Ice Cream', 'Creamy vanilla ice cream', 149.00, TRUE, TRUE),

(6, 7, 'Masala Dosa', 'Crispy dosa with potato filling', 160.00, TRUE, TRUE),
(6, 7, 'Idli Sambar', 'Soft idli with sambar', 120.00, TRUE, TRUE),
(6, 7, 'Medu Vada', 'Crispy South Indian vada', 110.00, TRUE, TRUE),
(6, 7, 'Plain Dosa', 'Crispy plain dosa', 130.00, TRUE, TRUE),
(6, 3, 'South Indian Thali', 'Complete vegetarian thali', 280.00, TRUE, TRUE),
(6, 6, 'Filter Coffee', 'Traditional South Indian coffee', 90.00, TRUE, TRUE),
(6, 5, 'Kesari Bath', 'Sweet semolina dessert', 100.00, TRUE, TRUE),

(7, 5, 'Chocolate Cake', 'Rich chocolate cake', 220.00, TRUE, TRUE),
(7, 5, 'Red Velvet Cake', 'Classic red velvet cake', 260.00, TRUE, TRUE),
(7, 5, 'Brownie', 'Chocolate walnut brownie', 180.00, TRUE, TRUE),
(7, 5, 'Cheesecake', 'Creamy cheesecake', 280.00, TRUE, TRUE),
(7, 5, 'Gulab Jamun', 'Soft syrupy dessert', 120.00, TRUE, TRUE),
(7, 6, 'Cold Coffee', 'Chilled coffee beverage', 150.00, TRUE, TRUE),
(7, 6, 'Strawberry Shake', 'Fresh strawberry shake', 190.00, TRUE, TRUE),

(8, 10, 'Veg Healthy Bowl', 'Fresh vegetables and grains', 280.00, TRUE, TRUE),
(8, 10, 'Paneer Protein Bowl', 'Paneer with healthy grains', 320.00, TRUE, TRUE),
(8, 10, 'Chicken Protein Bowl', 'Chicken with healthy grains', 360.00, FALSE, TRUE),
(8, 10, 'Quinoa Salad', 'Healthy quinoa vegetable salad', 290.00, TRUE, TRUE),
(8, 10, 'Fruit Bowl', 'Fresh seasonal fruits', 220.00, TRUE, TRUE),
(8, 6, 'Green Smoothie', 'Healthy green smoothie', 180.00, TRUE, TRUE),
(8, 5, 'Yogurt Parfait', 'Yogurt with fruits and nuts', 200.00, TRUE, TRUE),

(9, 6, 'Cappuccino', 'Classic Italian coffee', 150.00, TRUE, TRUE),
(9, 6, 'Latte', 'Smooth milk coffee', 170.00, TRUE, TRUE),
(9, 6, 'Cold Coffee', 'Chilled coffee', 160.00, TRUE, TRUE),
(9, 6, 'Masala Tea', 'Indian spiced tea', 90.00, TRUE, TRUE),
(9, 5, 'Blueberry Muffin', 'Fresh blueberry muffin', 140.00, TRUE, TRUE),
(9, 5, 'Chocolate Muffin', 'Chocolate muffin', 150.00, TRUE, TRUE),
(9, 8, 'Veg Grilled Sandwich', 'Grilled vegetable sandwich', 180.00, TRUE, TRUE),

(10, 8, 'Veg Frankie', 'Spiced vegetable wrap', 150.00, TRUE, TRUE),
(10, 8, 'Paneer Frankie', 'Paneer stuffed wrap', 190.00, TRUE, TRUE),
(10, 8, 'Chicken Frankie', 'Chicken stuffed wrap', 220.00, FALSE, TRUE),
(10, 8, 'Cheese Sandwich', 'Grilled cheese sandwich', 170.00, TRUE, TRUE),
(10, 3, 'Pav Bhaji', 'Mumbai style pav bhaji', 180.00, TRUE, TRUE),
(10, 6, 'Lemon Soda', 'Refreshing lemon soda', 90.00, TRUE, TRUE),
(10, 5, 'Kulfi', 'Traditional Indian ice cream', 120.00, TRUE, TRUE),

(11, 3, 'Paneer Tikka', 'Grilled cottage cheese', 280.00, TRUE, TRUE),
(11, 3, 'Butter Chicken', 'Creamy chicken curry', 340.00, FALSE, TRUE),
(11, 3, 'Dal Makhani', 'Slow cooked black lentils', 220.00, TRUE, TRUE),
(11, 3, 'Tandoori Roti', 'Indian clay oven bread', 45.00, TRUE, TRUE),
(11, 9, 'Veg Biryani', 'Aromatic vegetable rice', 260.00, TRUE, TRUE),
(11, 5, 'Rasmalai', 'Soft cottage cheese dessert', 140.00, TRUE, TRUE),
(11, 6, 'Sweet Lassi', 'Traditional sweet lassi', 110.00, TRUE, TRUE),

(12, 8, 'Aloo Chaat', 'Spicy potato chaat', 130.00, TRUE, TRUE),
(12, 8, 'Pani Puri', 'Crispy pani puri', 100.00, TRUE, TRUE),
(12, 8, 'Bhel Puri', 'Mumbai style bhel', 110.00, TRUE, TRUE),
(12, 8, 'Sev Puri', 'Crispy sev puri', 120.00, TRUE, TRUE),
(12, 3, 'Misal Pav', 'Spicy Maharashtrian dish', 150.00, TRUE, TRUE),
(12, 5, 'Shrikhand', 'Sweet yogurt dessert', 130.00, TRUE, TRUE),
(12, 6, 'Sol Kadhi', 'Traditional Maharashtrian drink', 100.00, TRUE, TRUE),

(13, 1, 'Penne Arrabbiata', 'Penne pasta in tomato sauce', 280.00, TRUE, TRUE),
(13, 1, 'White Sauce Pasta', 'Creamy white sauce pasta', 300.00, TRUE, TRUE),
(13, 1, 'Cheese Pasta', 'Cheesy pasta', 320.00, TRUE, TRUE),
(13, 1, 'Veg Pizza', 'Loaded vegetable pizza', 350.00, TRUE, TRUE),
(13, 5, 'Tiramisu', 'Classic Italian dessert', 260.00, TRUE, TRUE),
(13, 6, 'Iced Latte', 'Cold milk coffee', 180.00, TRUE, TRUE),

(14, 10, 'Grilled Paneer Bowl', 'Healthy paneer meal bowl', 330.00, TRUE, TRUE),
(14, 10, 'Grilled Chicken Bowl', 'Healthy grilled chicken bowl', 380.00, FALSE, TRUE),
(14, 10, 'Greek Salad', 'Fresh Greek style salad', 290.00, TRUE, TRUE),
(14, 10, 'Avocado Salad', 'Fresh avocado salad', 350.00, TRUE, TRUE),
(14, 8, 'Grilled Sandwich', 'Healthy grilled sandwich', 200.00, TRUE, TRUE),
(14, 6, 'Fresh Lime Juice', 'Fresh lime drink', 100.00, TRUE, TRUE),

(15, 8, 'Veg Pizza Slice', 'Fresh vegetable pizza slice', 140.00, TRUE, TRUE),
(15, 8, 'Chicken Roll', 'Spicy chicken roll', 180.00, FALSE, TRUE),
(15, 8, 'Veg Roll', 'Fresh vegetable roll', 150.00, TRUE, TRUE),
(15, 3, 'Chole Bhature', 'North Indian classic dish', 220.00, TRUE, TRUE),
(15, 3, 'Rajma Rice', 'Rajma with steamed rice', 200.00, TRUE, TRUE),
(15, 6, 'Mango Shake', 'Fresh mango shake', 180.00, TRUE, TRUE),
(15, 5, 'Ice Cream Sundae', 'Chocolate ice cream sundae', 220.00, TRUE, TRUE);

SELECT *
FROM menu_items
LIMIT 10;

USE foodrush;

INSERT INTO coupons
(coupon_code, description, discount_type, discount_value,
 minimum_order_amount, maximum_discount, start_date, end_date, status)
VALUES
('WELCOME50', 'Welcome discount', 'Percentage', 50.00, 499.00, 200.00, '2026-01-01', '2026-12-31', 'Active'),
('SAVE20', '20 percent off', 'Percentage', 20.00, 599.00, 150.00, '2026-01-01', '2026-12-31', 'Active'),
('FOOD100', 'Flat 100 off', 'Flat', 100.00, 699.00, 100.00, '2026-01-01', '2026-12-31', 'Active'),
('FIRSTORDER', 'First order discount', 'Percentage', 30.00, 399.00, 150.00, '2026-01-01', '2026-12-31', 'Active'),
('NEWUSER75', 'New user offer', 'Flat', 75.00, 499.00, 75.00, '2026-01-01', '2026-12-31', 'Active'),
('WEEKEND25', 'Weekend special offer', 'Percentage', 25.00, 799.00, 250.00, '2026-01-01', '2026-12-31', 'Active'),
('PIZZA100', 'Pizza discount', 'Flat', 100.00, 599.00, 100.00, '2026-01-01', '2026-12-31', 'Active'),
('BURGER50', 'Burger offer', 'Flat', 50.00, 399.00, 50.00, '2026-01-01', '2026-12-31', 'Active'),
('SAVE10', '10 percent discount', 'Percentage', 10.00, 499.00, 100.00, '2026-01-01', '2026-12-31', 'Active'),
('MEAL150', 'Meal discount', 'Flat', 150.00, 999.00, 150.00, '2026-01-01', '2026-12-31', 'Active'),
('TASTY30', 'Tasty food offer', 'Percentage', 30.00, 699.00, 200.00, '2026-01-01', '2026-12-31', 'Active'),
('FOOD20', 'Food special discount', 'Percentage', 20.00, 499.00, 150.00, '2026-01-01', '2026-12-31', 'Active'),
('FLAT75', 'Flat 75 off', 'Flat', 75.00, 399.00, 75.00, '2026-01-01', '2026-12-31', 'Active'),
('ORDER200', 'Large order discount', 'Flat', 200.00, 1299.00, 200.00, '2026-01-01', '2026-12-31', 'Active'),
('SPECIAL15', 'Special 15 percent off', 'Percentage', 15.00, 599.00, 120.00, '2026-01-01', '2026-12-31', 'Active'),
('FREEDOM100', 'Special flat discount', 'Flat', 100.00, 699.00, 100.00, '2026-01-01', '2026-12-31', 'Active'),
('LUNCH50', 'Lunch offer', 'Flat', 50.00, 399.00, 50.00, '2026-01-01', '2026-12-31', 'Active'),
('DINNER20', 'Dinner discount', 'Percentage', 20.00, 699.00, 150.00, '2026-01-01', '2026-12-31', 'Active'),
('HEALTHY100', 'Healthy food offer', 'Flat', 100.00, 799.00, 100.00, '2026-01-01', '2026-12-31', 'Active'),
('BIGORDER25', 'Big order discount', 'Percentage', 25.00, 999.00, 250.00, '2026-01-01', '2026-12-31', 'Active');

SELECT COUNT(*) AS total_coupons
FROM coupons;

SELECT * FROM coupons;

SELECT
    customer_id,
    restaurant_id
FROM customers
CROSS JOIN restaurants
LIMIT 10;


SELECT COUNT(*) AS total_orders
FROM orders;

USE foodrush;

INSERT INTO orders
(
    customer_id,
    restaurant_id,
    delivery_partner_id,
    order_date,
    delivery_address,
    subtotal,
    delivery_fee,
    discount,
    tax,
    total_amount,
    order_status
)
WITH RECURSIVE order_numbers AS (
    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM order_numbers
    WHERE n < 300
)
SELECT
    ((n - 1) % 50) + 1 AS customer_id,
    ((n - 1) % 15) + 1 AS restaurant_id,
    ((n - 1) % 25) + 1 AS delivery_partner_id,

    DATE_ADD(
        '2026-01-01 10:00:00',
        INTERVAL (n - 1) DAY
    ) AS order_date,

    CONCAT(
        CASE ((n - 1) % 10)
            WHEN 0 THEN 'Andheri East'
            WHEN 1 THEN 'Vashi Sector 17'
            WHEN 2 THEN 'Airoli'
            WHEN 3 THEN 'Thane West'
            WHEN 4 THEN 'Powai'
            WHEN 5 THEN 'Nerul'
            WHEN 6 THEN 'Dadar'
            WHEN 7 THEN 'Baner'
            WHEN 8 THEN 'Kothrud'
            ELSE 'Goregaon West'
        END,
        ', Mumbai'
    ) AS delivery_address,

    300 + ((n * 37) % 1200) AS subtotal,

    CASE
        WHEN n % 5 = 0 THEN 0.00
        ELSE 40.00
    END AS delivery_fee,

    CASE
        WHEN n % 10 = 0 THEN 100.00
        WHEN n % 7 = 0 THEN 50.00
        ELSE 0.00
    END AS discount,

    ROUND(
        (300 + ((n * 37) % 1200)) * 0.05,
        2
    ) AS tax,

    ROUND(
        (300 + ((n * 37) % 1200))
        +
        CASE
            WHEN n % 5 = 0 THEN 0.00
            ELSE 40.00
        END
        -
        CASE
            WHEN n % 10 = 0 THEN 100.00
            WHEN n % 7 = 0 THEN 50.00
            ELSE 0.00
        END
        +
        ((300 + ((n * 37) % 1200)) * 0.05),
        2
    ) AS total_amount,

    CASE
        WHEN n % 20 = 0 THEN 'Cancelled'
        WHEN n % 15 = 0 THEN 'Delivered'
        WHEN n % 10 = 0 THEN 'Out for Delivery'
        WHEN n % 5 = 0 THEN 'Preparing'
        ELSE 'Delivered'
    END AS order_status

FROM order_numbers;

SELECT COUNT(*) AS total_orders
FROM orders;


SELECT *
FROM orders
LIMIT 10;

USE foodrush;

INSERT INTO order_items
(order_id, item_id, quantity, unit_price, subtotal)

SELECT
    o.order_id,
    m.item_id,
    CASE
        WHEN o.order_id % 3 = 0 THEN 2
        ELSE 1
    END AS quantity,
    m.price AS unit_price,
    m.price *
    CASE
        WHEN o.order_id % 3 = 0 THEN 2
        ELSE 1
    END AS subtotal

FROM orders o
JOIN menu_items m
    ON m.restaurant_id = o.restaurant_id
WHERE m.item_id =
      ((o.order_id - 1) % 100) + 1

UNION ALL

SELECT
    o.order_id,
    m.item_id,
    1 AS quantity,
    m.price AS unit_price,
    m.price AS subtotal

FROM orders o
JOIN menu_items m
    ON m.restaurant_id = o.restaurant_id
WHERE m.item_id =
      ((o.order_id + 9) % 100) + 1;
      
      SELECT COUNT(*) AS total_order_items
FROM order_items;

USE foodrush;

DELETE FROM order_items;


SELECT *
FROM order_items
LIMIT 10;



SELECT COUNT(*) AS total_order_items
FROM order_items;


SELECT
    oi.order_item_id,
    oi.order_id,
    oi.item_id,
    mi.restaurant_id,
    oi.quantity,
    oi.unit_price,
    oi.subtotal
FROM order_items oi
JOIN menu_items mi
    ON oi.item_id = mi.item_id
ORDER BY oi.order_item_id;


DELETE FROM order_items;


SELECT COUNT(*) AS total_order_items
FROM order_items;


USE foodrush;

TRUNCATE TABLE order_items;

SELECT COUNT(*) AS total_order_items
FROM order_items;


USE foodrush;

INSERT INTO order_items
(order_id, item_id, quantity, unit_price, subtotal)
SELECT
    o.order_id,
    mi.item_id,
    CASE
        WHEN o.order_id % 3 = 0 THEN 2
        ELSE 1
    END AS quantity,
    mi.price AS unit_price,
    mi.price *
    CASE
        WHEN o.order_id % 3 = 0 THEN 2
        ELSE 1
    END AS subtotal
FROM orders o
JOIN menu_items mi
    ON mi.restaurant_id = o.restaurant_id
WHERE mi.item_id = (
    SELECT MIN(mi2.item_id)
    FROM menu_items mi2
    WHERE mi2.restaurant_id = o.restaurant_id
);

INSERT INTO order_items
(order_id, item_id, quantity, unit_price, subtotal)
SELECT
    o.order_id,
    mi.item_id,
    1 AS quantity,
    mi.price AS unit_price,
    mi.price AS subtotal
FROM orders o
JOIN menu_items mi
    ON mi.restaurant_id = o.restaurant_id
WHERE mi.item_id = (
    SELECT MIN(mi2.item_id) + 1
    FROM menu_items mi2
    WHERE mi2.restaurant_id = o.restaurant_id
);



SELECT COUNT(*) AS total_order_items
FROM order_items;






USE foodrush;

INSERT INTO order_items
(order_id, item_id, quantity, unit_price, subtotal)
SELECT
    o.order_id,
    mi.item_id,
    1 AS quantity,
    mi.price AS unit_price,
    mi.price AS subtotal
FROM orders o
JOIN menu_items mi
    ON mi.item_id = (
        SELECT mi2.item_id
        FROM menu_items mi2
        WHERE mi2.restaurant_id = o.restaurant_id
        ORDER BY mi2.item_id
        LIMIT 1 OFFSET 1
    )
WHERE NOT EXISTS (
    SELECT 1
    FROM order_items oi
    WHERE oi.order_id = o.order_id
      AND oi.item_id = mi.item_id
);



SELECT COUNT(*) AS total_order_items
FROM order_items;



USE foodrush;

SELECT
    restaurant_id,
    COUNT(*) AS menu_item_count,
    MIN(item_id) AS first_item_id,
    MAX(item_id) AS last_item_id
FROM menu_items
GROUP BY restaurant_id
ORDER BY restaurant_id;

SELECT 
    restaurant_id,
    COUNT(*) AS menu_items
FROM menu_items
GROUP BY restaurant_id
ORDER BY restaurant_id;



INSERT INTO order_items
(order_id, item_id, quantity, unit_price, subtotal)
SELECT
    o.order_id,
    m.item_id,
    1,
    m.price,
    m.price
FROM orders o
JOIN menu_items m
    ON m.restaurant_id = o.restaurant_id
WHERE m.item_id = (
    SELECT MIN(m2.item_id)
    FROM menu_items m2
    WHERE m2.restaurant_id = o.restaurant_id
)
LIMIT 250;





SELECT COUNT(*) FROM order_items;



USE foodrush;

INSERT INTO payments
(order_id, payment_date, payment_method, amount, payment_status, transaction_reference)
SELECT
    order_id,
    order_date,
    CASE
        WHEN order_id % 3 = 0 THEN 'UPI'
        WHEN order_id % 3 = 1 THEN 'Card'
        ELSE 'Cash'
    END,
    total_amount,
    'Completed',
    CONCAT('TXN', order_id)
FROM orders;



SELECT COUNT(*) FROM payments;

INSERT INTO deliveries
(order_id, delivery_partner_id, assigned_time, pickup_time, delivery_time, delivery_status)
SELECT
    o.order_id,
    o.delivery_partner_id,
    o.order_date,
    DATE_ADD(o.order_date, INTERVAL 15 MINUTE),
    DATE_ADD(o.order_date, INTERVAL 45 MINUTE),
    'Delivered'
FROM orders o
WHERE o.delivery_partner_id IS NOT NULL
LIMIT 250;




SELECT COUNT(*) FROM deliveries;



INSERT INTO reviews
(order_id, customer_id, restaurant_id, rating, review_text, review_date)
SELECT
    o.order_id,
    o.customer_id,
    o.restaurant_id,
    (o.order_id % 5) + 1,
    CASE
        WHEN o.order_id % 3 = 0 THEN 'Good food and service'
        WHEN o.order_id % 3 = 1 THEN 'Tasty food and fast delivery'
        ELSE 'Nice experience'
    END,
    DATE(o.order_date)
FROM orders o
LIMIT 150;


SELECT COUNT(*) FROM reviews;



INSERT INTO order_coupons
(order_id, coupon_id, discount_amount)
SELECT
    o.order_id,
    ((o.order_id - 1) % 20) + 1,
    50.00
FROM orders o
LIMIT 150;


SELECT COUNT(*) FROM order_coupons;


USE foodrush;

SELECT 'customers' AS table_name, COUNT(*) AS total FROM customers
UNION ALL
SELECT 'restaurants', COUNT(*) FROM restaurants
UNION ALL
SELECT 'food_categories', COUNT(*) FROM food_categories
UNION ALL
SELECT 'menu_items', COUNT(*) FROM menu_items
UNION ALL
SELECT 'delivery_partners', COUNT(*) FROM delivery_partners
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'payments', COUNT(*) FROM payments
UNION ALL
SELECT 'deliveries', COUNT(*) FROM deliveries
UNION ALL
SELECT 'coupons', COUNT(*) FROM coupons
UNION ALL
SELECT 'order_coupons', COUNT(*) FROM order_coupons
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews;



-- Q1 :Find the total number of customers in the FoodRush system.



SELECT COUNT(*) AS total_customers
FROM customers;

USE foodrush;
-- Question 2: Find the total number of restaurants

SELECT COUNT(*) AS total_restaurants
FROM restaurants;


-- Question 3: Find the total number of food categories
SELECT COUNT(*) AS total_categories
FROM food_categories;

-- Question 4: Find the total number of menu items
SELECT COUNT(*) AS total_menu_items
FROM menu_items;



-- Question 5: Find the total number of delivery partners
SELECT COUNT(*) AS total_delivery_partners
FROM delivery_partners;


-- Question 6: Find the total number of orders
SELECT COUNT(*) AS total_orders



-- Question 7: Find the total number of order items
SELECT COUNT(*) AS total_order_items


-- Question 8: Find the total number of payments
SELECT COUNT(*) AS total_payments
FROM payments;


-- Question 9: Find the total number of deliveries
SELECT COUNT(*) AS total_deliveries
FROM deliveries;

-- Question 10: Find the total number of coupons
SELECT COUNT(*) AS total_coupons
FROM coupons;





-- Question 11: Find the total number of reviews
SELECT COUNT(*) AS total_reviews



-- Question 12: Find the total revenue generated from all orders
SELECT SUM(total_amount) AS total_revenue
FROM orders;




-- Question 13: Find the average order value
SELECT AVG(total_amount) AS average_order_value






-- Question 14: Find the highest order amount
SELECT MAX(total_amount) AS highest_order_amount
FROM orders;



-- Question 15: Find the lowest order amount
SELECT MIN(total_amount) AS lowest_order_amount
FROM orders;


-- Question 16: Find the total discount given on all orders
SELECT SUM(discount) AS total_discount
FROM orders;


-- Question 17: Find the total tax collected
SELECT SUM(tax) AS total_tax
FROM orders;


-- Find the total delivery charges collected from all orders.
SELECT SUM(delivery_fee) AS total_delivery_charges
FROM orders;

-- Find the total number of cancelled orders.

SELECT COUNT(*) AS cancelled_orders
FROM orders
WHERE order_status = 'Cancelled';


-- Find the cancellation rate of orders.
SELECT 
    ROUND(
        (COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END) * 100.0) 
        / COUNT(*), 
        2
    ) AS cancellation_rate
FROM orders;



-- Find the average delivery time in minutes.


DESCRIBE deliveries;

SELECT 
    ROUND(
        AVG(TIMESTAMPDIFF(MINUTE, pickup_time, delivery_time)), 
        2
    ) AS average_delivery_time_minutes
FROM deliveries
WHERE pickup_time IS NOT NULL
  AND delivery_time IS NOT NULL;
  
  
 -- Q22: Find the number of successful/completed orders.
 
 
SELECT COUNT(*) AS completed_orders
FROM orders
WHERE order_status = 'Delivered';



-- Question 23:Find the number of pending orders.

SELECT COUNT(*) AS pending_orders
FROM orders
WHERE order_status = 'Pending';


-- Question 24:Find the number of orders that are currently cancelled.

SELECT 
    r.restaurant_name,
    ROUND(SUM(o.total_amount), 2) AS total_revenue
FROM restaurants r
JOIN orders o 
    ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY total_revenue DESC
LIMIT 5;

-- Question 25:Find the top 5 most ordered menu items based on total quantity sold.

SELECT 
    m.item_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM menu_items m
JOIN order_items oi 
    ON m.item_id = oi.item_id
GROUP BY m.item_id, m.item_name
ORDER BY total_quantity_sold DESC
LIMIT 5;



-- Question 26:Find the restaurant with the highest number of orders.

SELECT 
    r.restaurant_name,
    COUNT(o.order_id) AS total_orders
FROM restaurants r
JOIN orders o 
    ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY total_orders DESC
LIMIT 1;


-- Question 27:Find the top 5 customers based on their total spending.


describe customers;


SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    ROUND(SUM(o.total_amount), 2) AS total_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spending DESC
LIMIT 5;


-- Question 28:Find the most popular payment method based on the number of payments.

SELECT 
    payment_method,
    COUNT(*) AS total_payments
FROM payments
GROUP BY payment_method
ORDER BY total_payments DESC
LIMIT 1;


-- Question 29 :Find the top 5 delivery partners based on the number of deliveries completed.

SELECT 
    d.delivery_partner_id,
    COUNT(d.delivery_id) AS total_deliveries
FROM deliveries d
WHERE d.delivery_status = 'Delivered'
GROUP BY d.delivery_partner_id
ORDER BY total_deliveries DESC
LIMIT 5;


-- Question 30 :Find the most popular food category based on the number of menu items.

SELECT 
    fc.category_name,
    COUNT(m.item_id) AS total_menu_items
FROM food_categories fc
JOIN menu_items m
    ON fc.category_id = m.category_id
GROUP BY fc.category_id, fc.category_name
ORDER BY total_menu_items DESC
LIMIT 1;

-- Question 31: Find the average rating given by customers for each restaurant.

SELECT 
    r.restaurant_name,
    ROUND(AVG(rv.rating), 2) AS average_rating
FROM restaurants r
JOIN reviews rv
    ON r.restaurant_id = rv.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY average_rating DESC;

-- Question 32: Find the total number of reviews received by each restaurant.

SELECT 
    r.restaurant_name,
    COUNT(rv.review_id) AS total_reviews
FROM restaurants r
JOIN reviews rv
    ON r.restaurant_id = rv.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY total_reviews DESC;

-- Question 33: Find the restaurant with the highest average rating.

SELECT 
    r.restaurant_name,
    ROUND(AVG(rv.rating), 2) AS average_rating
FROM restaurants r
JOIN reviews rv
    ON r.restaurant_id = rv.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY average_rating DESC
LIMIT 1;


-- Question 34: Find the total revenue generated by each restaurant.

SELECT 
    r.restaurant_name,
    ROUND(SUM(o.total_amount), 2) AS total_revenue
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY total_revenue DESC;

-- Question 35: Find the restaurant with the lowest total revenue.

SELECT 
    r.restaurant_name,
    ROUND(SUM(o.total_amount), 2) AS total_revenue
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY total_revenue ASC
LIMIT 1;

-- Question 36: Find the restaurant with the highest total revenue

SELECT 
    r.restaurant_name,
    ROUND(SUM(o.total_amount), 2) AS total_revenue
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY total_revenue DESC
LIMIT 1;

-- Question 37: Find the restaurant with the highest average rating

SELECT 
    r.restaurant_name,
    ROUND(AVG(rv.rating), 2) AS average_rating
FROM restaurants r
JOIN reviews rv
    ON r.restaurant_id = rv.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY average_rating DESC
LIMIT 1;

-- Question 38: Find the restaurant with the lowest average rating

SELECT 
    r.restaurant_name,
    ROUND(AVG(rv.rating), 2) AS average_rating
FROM restaurants r
JOIN reviews rv
    ON r.restaurant_id = rv.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY average_rating ASC
LIMIT 1;



-- Question 39: Find the restaurant with the highest number of reviews

SELECT 
    r.restaurant_name,
    COUNT(rv.review_id) AS total_reviews
FROM restaurants r
JOIN reviews rv
    ON r.restaurant_id = rv.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY total_reviews DESC
LIMIT 1;


-- Question 40: Find the restaurant with the lowest number of reviews

SELECT 
    r.restaurant_name,
    COUNT(rv.review_id) AS total_reviews
FROM restaurants r
JOIN reviews rv
    ON r.restaurant_id = rv.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY total_reviews ASC
LIMIT 1;


-- Question 41: Find the restaurant with the highest number of delivered orders

SELECT 
    r.restaurant_name,
    COUNT(o.order_id) AS delivered_orders
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
WHERE o.order_status = 'Delivered'
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY delivered_orders DESC
LIMIT 1;



-- Question 43: Find the restaurant with the highest total number of orders

SELECT 
    r.restaurant_name,
    COUNT(o.order_id) AS total_orders
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY total_orders DESC
LIMIT 1;


-- Question 44: Find the restaurant with the lowest total number of orders

SELECT 
    r.restaurant_name,
    COUNT(o.order_id) AS total_orders
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY total_orders ASC
LIMIT 1;

-- Question 45: Find the customer with the highest number of orders

SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_orders DESC
LIMIT 1;



-- Question 46: Find the customer with the lowest number of orders

SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_orders ASC
LIMIT 1;



-- Question 47: Find the customer with the highest total spending

SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    ROUND(SUM(o.total_amount), 2) AS total_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spending DESC
LIMIT 1;




-- Question 48: Find the customer with the lowest total spending

SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    ROUND(SUM(o.total_amount), 2) AS total_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spending ASC
LIMIT 1;


-- Question 49: Find the customer who placed the highest-value single order


SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    ROUND(MAX(o.total_amount), 2) AS highest_order_amount
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY highest_order_amount DESC
LIMIT 1;

-- Question 50: Find the customer who placed the lowest-value single order

SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    ROUND(MIN(o.total_amount), 2) AS lowest_order_amount
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY lowest_order_amount ASC
LIMIT 1;

