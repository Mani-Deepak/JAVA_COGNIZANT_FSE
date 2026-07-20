-- Schema Setup Script for PL/SQL Exercises

-- 1. Drop existing tables if they exist
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Transactions CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Accounts CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Loans CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Customers CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Employees CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Tables drop warning: Some tables did not exist.');
END;
/

-- 2. Create tables
CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    DOB DATE,
    Balance NUMBER,
    LastModified DATE,
    IsVIP VARCHAR2(5) DEFAULT 'FALSE'
);

CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    AccountType VARCHAR2(20),
    Balance NUMBER,
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Transactions (
    TransactionID NUMBER PRIMARY KEY,
    AccountID NUMBER,
    TransactionDate DATE,
    Amount NUMBER,
    TransactionType VARCHAR2(10),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    LoanAmount NUMBER,
    InterestRate NUMBER,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Position VARCHAR2(50),
    Salary NUMBER,
    Department VARCHAR2(50),
    HireDate DATE
);

-- 3. Seed Sample Data
INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
VALUES (1, 'John Doe', TO_DATE('1955-05-15', 'YYYY-MM-DD'), 11000, SYSDATE, 'FALSE'); -- Age > 60, Balance > 10,000

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
VALUES (2, 'Jane Smith', TO_DATE('1990-07-20', 'YYYY-MM-DD'), 1500, SYSDATE, 'FALSE');

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
VALUES (3, 'Old Member', TO_DATE('1945-11-30', 'YYYY-MM-DD'), 8500, SYSDATE, 'FALSE'); -- Age > 60, Balance < 10,000

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (1, 1, 'Savings', 11000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (2, 2, 'Checking', 1500, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (3, 3, 'Savings', 8500, SYSDATE);

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (1, 1, SYSDATE, 200, 'Deposit');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (2, 2, SYSDATE, 300, 'Withdrawal');

-- Loan due in 15 days (due in less than 30 days)
INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (1, 1, 5000, 5, SYSDATE - 100, SYSDATE + 15);

-- Loan due in 45 days
INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (2, 2, 8000, 6, SYSDATE - 50, SYSDATE + 45);

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (1, 'Alice Johnson', 'Manager', 70000, 'HR', TO_DATE('2015-06-15', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (2, 'Bob Brown', 'Developer', 60000, 'IT', TO_DATE('2017-03-20', 'YYYY-MM-DD'));

COMMIT;
/
