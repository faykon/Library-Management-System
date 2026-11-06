PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Loans;
DROP TABLE IF EXISTS Members;
DROP TABLE IF EXISTS Books;

CREATE TABLE Books (
    book_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    author TEXT NOT NULL,
    available INTEGER NOT NULL DEFAULT 1
        CHECK (available IN (0, 1))
);

CREATE TABLE Members (
    member_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE,
    join_date TEXT
);

CREATE TABLE Loans (
    loan_id INTEGER PRIMARY KEY,
    book_id INTEGER NOT NULL,
    member_id INTEGER NOT NULL,
    loan_date TEXT NOT NULL,
    return_date TEXT,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

INSERT INTO Books (title, author, available)
VALUES
    ('Harry Potter', 'J.K. Rowling', 1),
    ('The Hobbit', 'J.R.R. Tolkien', 0),
    ('1984', 'George Orwell', 1),
    ('Pride and Prejudice', 'Jane Austen', 1),
    ('The Little Prince', 'Antoine de Saint-Exupery', 1);

INSERT INTO Members (name, email, join_date)
VALUES
    ('Maria Papadopoulou', 'maria@example.com', '2026-01-10'),
    ('Nikos Georgiou', 'nikos@example.com', '2026-02-15'),
    ('Eleni Dimitriou', 'eleni@example.com', '2026-03-20');

INSERT INTO Loans (book_id, member_id, loan_date, return_date)
VALUES
    (2, 1, '2026-10-09', NULL),
    (1, 2, '2026-09-01', '2026-09-15'),
    (3, 1, '2026-08-10', '2026-08-20'),
    (2, 3, '2026-07-05', '2026-07-19');

SELECT * FROM Books;
SELECT * FROM Members;
SELECT * FROM Loans;

SELECT
    Books.title,
    Members.name,
    Loans.loan_date
FROM Loans
JOIN Books
    ON Loans.book_id = Books.book_id
JOIN Members
    ON Loans.member_id = Members.member_id;
