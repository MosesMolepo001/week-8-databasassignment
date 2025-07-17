-- Drop and Create the database
DROP DATABASE IF EXISTS library_management;
CREATE DATABASE library_management;
USE library_management;

-- Books Table
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    publication_year INT,
    total_copies INT NOT NULL,
    available_copies INT NOT NULL
);

-- Members Table
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    membership_date DATE DEFAULT (CURRENT_DATE)
);

-- Librarians Table
CREATE TABLE librarians (
    librarian_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Reservations Table
CREATE TABLE reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    book_id INT,
    reservation_date DATE DEFAULT (CURRENT_DATE),
    status ENUM('reserved', 'cancelled', 'fulfilled') DEFAULT 'reserved',
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE
);

-- Loans Table
CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    member_id INT,
    issue_date DATE DEFAULT (CURRENT_DATE),
    due_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- Insert Sample Books
INSERT INTO books (title, author, genre, publication_year, total_copies, available_copies)
VALUES
('1984', 'George Orwell', 'Dystopian', 1949, 5, 3),
('The Great Gatsby', 'F. Scott Fitzgerald', 'Classic', 1925, 3, 1),
('Harry Potter and the Sorcerer\'s Stone', 'J.K. Rowling', 'Fantasy', 1997, 10, 7);

-- Insert Sample Members
INSERT INTO members (name, email, phone)
VALUES
('Alice Johnson', 'alice@example.com', '123-456-7890'),
('Bob Smith', 'bob@example.com', '987-654-3210');

-- Insert Sample Librarian
INSERT INTO librarians (name, email)
VALUES
('Jane Doe', 'jane.librarian@example.com');

-- Insert Sample Reservations
INSERT INTO reservations (member_id, book_id, reservation_date, status)
VALUES
(1, 1, '2025-07-15', 'reserved'),
(2, 3, '2025-07-16', 'fulfilled');

-- Insert Sample Loans
INSERT INTO loans (book_id, member_id, issue_date, due_date, return_date)
VALUES
(1, 1, '2025-07-15', '2025-07-30', NULL),
(3, 2, '2025-07-10', '2025-07-25', '2025-07-20');
