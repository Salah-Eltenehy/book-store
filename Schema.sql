drop database BookStore;
create database BookStore;
use BookStore;
/*
CREATE TABLE category(
    category VARCHAR(20),
    PRIMARY KEY(category)
);
*/
CREATE TABLE publisher(
    name VARCHAR(30),
    address VARCHAR(40) NOT NULL,
    telephone_number CHAR(14) NOT NULL,
    PRIMARY KEY(name)
);

CREATE TABLE book(
    ISBN CHAR(13),
    title VARCHAR(50) NOT NULL,
    publisher VARCHAR(30) NOT NULL,
    publication_year DATE,
    price DOUBLE NOT NULL,
    category VARCHAR(20),
    stock INT NOT NULL,
    threshold INT NOT NULL,
    image_url varchar(250),
    PRIMARY KEY(ISBN),
    #FOREIGN KEY(category) REFERENCES category (category),
    FOREIGN KEY(publisher) REFERENCES publisher (name)
);

CREATE TABLE author(
    ISBN CHAR(13),
    author VARCHAR(30),
    PRIMARY KEY(ISBN, author),
    FOREIGN KEY(ISBN) REFERENCES book (ISBN)
);

CREATE TABLE user(
    username VARCHAR(40),
    password VARCHAR(40) NOT NULL,
    first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(15) NOT NULL,
    email VARCHAR(40),
    phone_number CHAR(11),
    shipping_address VARCHAR(40) NOT NULL,
    is_manger BOOLEAN NOT NULL DEFAULT false, 
    PRIMARY KEY(username)
);

CREATE TABLE cart(
	cart_id INT AUTO_INCREMENT,
    username VARCHAR(40) NOT NULL,
    total_price INT,
    purchased_date date NOT NULL,
    credit_cart_number CHAR(16) NOT NULL,
    cvv CHAR(3) NOT NULL,
	expiry_date date NOT NULL,
    PRIMARY KEY(cart_id),
    FOREIGN KEY(username) REFERENCES user (username) on update CASCADE
);

CREATE TABLE cart_book(
	cart_id INT,
    ISBN CHAR(13) NOT NULL,
    no_books INT default 1,
	PRIMARY KEY(cart_id,ISBN),
    FOREIGN KEY(cart_id) REFERENCES cart(cart_id),
    FOREIGN KEY(ISBN) REFERENCES book(ISBN)
);


CREATE TABLE sale(
    saleId INT,
    username VARCHAR(40),
    ISBN CHAR(13) NOT NULL,
    amount INT NOT NULL,
    sale_date DATE NOT NULL,
    price DOUBLE NOT NULL,
    PRIMARY KEY(saleId),
    FOREIGN KEY(username) REFERENCES user (username) on update CASCADE,
    FOREIGN KEY(ISBN) REFERENCES book (ISBN)
);

CREATE TABLE book_order(
    orderId INT AUTO_INCREMENT,
    ISBN CHAR(13) NOT NULL,
    quantity INT NOT NULL,
    publisher VARCHAR(30) NOT NULL,
    PRIMARY KEY(orderId),
    FOREIGN KEY(ISBN) REFERENCES book (ISBN),
    FOREIGN KEY(publisher) REFERENCES publisher (name)
);