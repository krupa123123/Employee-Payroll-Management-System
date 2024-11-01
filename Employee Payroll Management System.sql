-- Create Database
CREATE DATABASE EmployeePayrollDB;
GO

USE EmployeePayrollDB;
GO

-- Create Employeesdata Table
CREATE TABLE Employeesdata (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100),
    Position NVARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE,
    Status NVARCHAR(20)
);
GO

-- Create PayPeriods Table
CREATE TABLE PayPeriods (
    PayPeriodID INT IDENTITY(1,1) PRIMARY KEY,
    StartDate DATE,
    EndDate DATE
);
GO

-- Create Payroll Table
CREATE TABLE Payroll (
    PayrollID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    PayPeriodID INT,
    GrossPay DECIMAL(10, 2),
    NetPay DECIMAL(10, 2),
    FOREIGN KEY (EmployeeID) REFERENCES Employeesdata(EmployeeID),
    FOREIGN KEY (PayPeriodID) REFERENCES PayPeriods(PayPeriodID)
);
GO

-- Create Deductions Table
CREATE TABLE Deductions (
    DeductionID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    DeductionType NVARCHAR(50),
    Amount DECIMAL(10, 2),
    FOREIGN KEY (EmployeeID) REFERENCES Employeesdata(EmployeeID)
);
GO

-- Insert Sample Employees
INSERT INTO Employeesdata (FirstName, LastName, Email, Position, Salary, HireDate, Status) VALUES
('John', 'Doe', 'john.doe@example.com', 'Developer', 60000, '2023-01-10', 'Active'),
('Jane', 'Smith', 'jane.smith@example.com', 'Manager', 75000, '2023-01-15', 'Active'),
('Bob', 'Johnson', 'bob.johnson@example.com', 'Designer', 50000, '2023-02-01', 'Active'),
('Alice', 'Williams', 'alice.williams@example.com', 'Analyst', 55000, '2023-02-10', 'Active'),
('Tom', 'Brown', 'tom.brown@example.com', 'Tester', 45000, '2023-02-15', 'Active');
GO

-- Insert Sample Pay Periods
INSERT INTO PayPeriods (StartDate, EndDate) VALUES
('2023-01-01', '2023-01-15'),
('2023-01-16', '2023-01-31'),
('2023-02-01', '2023-02-15'),
('2023-02-16', '2023-02-28');
GO

-- Insert Sample Payroll Records
INSERT INTO Payroll (EmployeeID, PayPeriodID, GrossPay, NetPay) VALUES
(1, 1, 3000, 2700),
(2, 2, 4000, 3600),
(3, 3, 2500, 2250),
(4, 4, 2800, 2520),
(5, 4, 2200, 1980);
GO

-- Insert Sample Deductions
INSERT INTO Deductions (EmployeeID, DeductionType, Amount) VALUES
(1, 'Health Insurance', 200.00),
(2, '401k Contribution', 150.00),
(3, 'Health Insurance', 200.00),
(4, 'Health Insurance', 200.00),
(5, 'Health Insurance', 200.00);
GO

-- Query to Get Payroll Report for a Pay Period
SELECT p.PayrollID, e.FirstName, e.LastName, p.GrossPay, p.NetPay, pp.StartDate, pp.EndDate
FROM Payroll p
JOIN Employeesdata e ON p.EmployeeID = e.EmployeeID
JOIN PayPeriods pp ON p.PayPeriodID = pp.PayPeriodID
WHERE pp.PayPeriodID = 1; -- Replace with actual PayPeriodID for specific report
GO

-- Query to Get Employee Deductions
SELECT e.FirstName, e.LastName, d.DeductionType, d.Amount
FROM Deductions d
JOIN Employeesdata e ON d.EmployeeID = e.EmployeeID
WHERE e.EmployeeID = 1; -- Replace with actual EmployeeID for specific deductions
GO
