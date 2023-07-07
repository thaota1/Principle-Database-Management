/* AUTHOR Ta Thi Phuong Thao*/
/*LAB 3*/
/*TASK 5*/
CREATE DATABASE EMPLOYEE
USE EMPLOYEE
GO
CREATE TABLE Employee(
Employeename varchar(30) NOT NULL,
street varchar(30) NOT NULL,
city varchar(30) NOT NULL
PRIMARY KEY(Employeename)
)
CREATE TABLE WORKS(
Employeename varchar(30) NOT NULL,
Companyname varchar(30) NOT NULL ,
Salary [money] NOT NULL
PRIMARY KEY(Employeename) 
)

CREATE TABLE COMPANY(
Companyname varchar(30) NOT NULL , 
city varchar(30) NOT NULL 
PRIMARY KEY(Companyname)
)
CREATE TABLE MANAGES(
Employeename varchar(30) NOT NULL,
Managername varchar(30) NOT NULL
PRIMARY KEY(Managername)
)

ALTER TABLE WORKS  WITH CHECK ADD  CONSTRAINT [FK_WORKS_Employee] FOREIGN KEY(Employeename)
REFERENCES Employee (Employeename)
ALTER TABLE WORKS  WITH CHECK ADD  CONSTRAINT [FK_WORKS_COMPANY] FOREIGN KEY(Companyname)
REFERENCES COMPANY (Companyname) 
ALTER TABLE MANAGES WITH CHECK ADD  CONSTRAINT [FK_MANAGES_Employee] FOREIGN KEY(Employeename)
REFERENCES Employee (Employeename)


GO
INSERT INTO Employee(Employeename, street, city) 
VALUES('NGUYEN VAN A', 'DIEN BIEN PHU', 'HO CHI MINH')
INSERT INTO Employee(Employeename, street, city) 
VALUES('TRUONG VAN B', 'LE THI RIENG', 'HO CHI MINH')
INSERT INTO Employee(Employeename, street, city) 
VALUES('LY VAN C', 'PHAM VAN DONG', 'HO CHI MINH')
INSERT INTO Employee(Employeename, street, city) 
VALUES('MAI VAN D', 'NAM KY KHOI NGHIA', 'HO CHI MINH')
INSERT INTO Employee(Employeename, street, city) 
VALUES('PHAN VAN E', 'HAI BA TRUNG', 'HO CHI MINH') 



INSERT INTO COMPANY(Companyname, city)
VALUES('FPT', 'HO CHI MINH') 
INSERT INTO COMPANY(Companyname, city)
VALUES('VIETTEL', 'HANOI')
INSERT INTO COMPANY(Companyname, city)
VALUES('GRAB', 'HO CHI MINH')
INSERT INTO COMPANY(Companyname, city)
VALUES('BAEMIN', 'HANOI')
INSERT INTO COMPANY(Companyname, city)
VALUES('THEGIOIDIDONG', 'HO CHI MINH') 

INSERT INTO WORKS(Employeename, Companyname,Salary)
VALUES('NGUYEN VAN A', 'VIETTEL', 1000)
INSERT INTO WORKS(Employeename, Companyname,Salary)
VALUES('TRUONG VAN B', 'FPT', 2000)
INSERT INTO WORKS(Employeename, Companyname,Salary)
VALUES('LY VAN C', 'GRAB', 10000)
INSERT INTO WORKS(Employeename, Companyname,Salary)
VALUES('MAI VAN D', 'BAEMIN', 15000)
INSERT INTO WORKS(Employeename, Companyname,Salary)
VALUES('PHAN VAN E', 'THEGIOIDIDONG', 5000) 



INSERT INTO MANAGES(Employeename, Managername)
VALUES('NGUYEN VAN A', 'TRUONG VAN B') 
INSERT INTO MANAGES(Employeename, Managername)
VALUES('TRUONG VAN B', 'LY VAN C')
INSERT INTO MANAGES(Employeename, Managername)
VALUES('LY VAN C', 'MAI VAN D')
INSERT INTO MANAGES(Employeename, Managername)
VALUES('MAI VAN D', 'PHAN VAN E')
INSERT INTO MANAGES(Employeename, Managername)
VALUES('PHAN VAN E', 'NGUYEN VAN A')

SELECT * FROM WORKS
/*NAME OF EMPLOYEES WHO WORK FOR THE 1ST BANK*/
SELECT Employeename
FROM WORKS
WHERE Companyname = 'GRAB'  
/*the names and cities of residence of all employees who work for First Bank Corporation*/
SELECT WORKS.Employeename, Employee.city
FROM WORKS, Employee
WHERE Companyname = 'GRAB' AND WORKS.Employeename = Employee.Employeename


/*the names, street addresses, and cities of residence of all employees who work for First Bank Corporation and earn more than $10,000*/

SELECT WORKS.Employeename, Employee.street, Employee.city
FROM WORKS, Employee
WHERE WORKS.Salary >= 10000 AND Employee.Employeename = WORKS.Employeename 

/*all employees in the database who live in the same cities as the companies for which they work*/
SELECT Employee.Employeename
FROM COMPANY, Employee, WORKS
WHERE Employee.city = COMPANY.city AND WORKS.Employeename = Employee.Employeename AND COMPANY.Companyname = WORKS.Companyname 

/*all employees in the database who live in the same cities and on the same streets as do their managers*/
SELECT Employee.Employeename
FROM Employee, MANAGES
WHERE Employee.city = Employee.city AND Employee.street = Employee.street AND MANAGES.Managername = Employee.Employeename 

/*all employees in the database who do not work for First Bank Corporation*/
SELECT Employeename
FROM  WORKS
WHERE Companyname != 'GRAB' 

/*all employees in the database who earn more than each employee of Small Bank Corporation*/
SELECT Employee.Employeename
FROM WORKS, Employee
WHERE WORKS.Salary > WORKS.Salary AND WORKS.Companyname = WORKS.Companyname AND Employee.Employeename = WORKS.Employeename 