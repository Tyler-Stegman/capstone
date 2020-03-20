drop database if exists prs;
create database prs;
use prs;

create table User (
	ID				int				primary key auto_increment,
    UserName		varchar(20)		not null,
    Password		varchar(10)		not null,
    FirstName		varchar(20)		not null,
    LastName		varchar(20)		not null,
    PhoneNumber		varchar(12)		not null,
    Email			varchar(75)		not null,
    IsReviewer		tinyint			not null,
    IsAdmin			tinyint			not null,
    
    CONSTRAINT uname unique (UserName)
    );
    
-- Code example: BB-101 for Best Buy, AMZ-001 for Amazon, etc. 
    
create table Vendor (
	ID				int				primary key auto_increment,
    Code			varchar(10)		not null unique,
    Name			varchar(255)	not null,
    Address			varchar(255)	not null,
    City			varchar(255)	not null,
    State			varchar(2)		not null,
    Zip				varchar(5)		not null,
    PhoneNumber		varchar(12)		not null,
    Email			varchar(100)	not null,
    
    CONSTRAINT vcode unique (Code)
    );

create table Request (
	ID					int				primary key auto_increment,
    UserID				int				not null,
    Description			varchar(100)	not null,
    Justification		varchar(255)	not null,
    DateNeeded			date			not null,
    DeliveryMode		varchar(25)		not null,
    Status				varchar(20)		not null,
    Total				decimal(10,2)	not null,
    SubmittedDate		datetime		not null,
    ReasonForRejection	varchar(100),
    
    FOREIGN KEY (UserID) REFERENCES User(ID)
	);
    
create table Product (
	ID				int				primary key auto_increment,
    VendorID		int				not null,
    PartNumber		varchar(50)		not null,
    Name			varchar(150)	not null,
    Price			decimal(10,2)	not null,
    Unit			varchar(255),
    PhotoPath		varchar(255),
    
    FOREIGN KEY (VendorID) REFERENCES Vendor(ID),
    CONSTRAINT vendor_part unique (VendorID, PartNumber)
    );
    
create table LineItem (
	ID				int				primary key auto_increment,
    RequestID		int				not null,
    ProductID		int				not null,
    Quantity		int				not null,
    
    FOREIGN KEY (ProductID) REFERENCES Product(ID),
    FOREIGN KEY (RequestID) REFERENCES Request(ID),
    CONSTRAINT req_pdt unique (RequestID, ProductID)
	);
    
insert into User (UserName, Password, FirstName, LastName, PhoneNumber, Email, IsReviewer, IsAdmin) 
	values ('Bob_Ross', 'BobbyRo$$', 'Bob', 'Ross', '513-448-6248', 'Bob_Ross@gmail.com', 1, 0);
insert into User (ID, UserName, Password, FirstName, LastName, PhoneNumber, Email, IsReviewer, IsAdmin)
	values ('Goose88', 'password@21', 'Anthony', 'Edwards', '212-876-5309', 'RIO_Goose@gmail.com', 1, 0);
insert into User (ID, UserName, Password, FirstName, LastName, PhoneNumber, Email, IsReviewer, IsAdmin)
	values ('Maverick', 'imthebest', 'Pete', 'Mitchell', '418-890-4859', 'TG1@hotmail.com', 0, 1);
    
insert into Vendor (Code, Name, Address, City, State, Zip, PhoneNumber, Email)
	values ('MC224', 'MicroCenter - Sharonville,OH', '11755 Mosteller Rd', 'Sharonville', 'OH', '45241', '513-782-8500', 'MikeS1@microcenter.com')

    

    

