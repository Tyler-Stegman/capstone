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
    
insert into User (ID, UserName, Password, FirstName, LastName, PhoneNumber, Email, IsReviewer, IsAdmin) 
	values (1, 'Bob_Ross', 'BobbyRo$$', 'Bob', 'Ross', '513-448-6248', 'Bob_Ross@gmail.com', 1, 0);
insert into User (ID, UserName, Password, FirstName, LastName, PhoneNumber, Email, IsReviewer, IsAdmin)
	values (2, 'Goose88', '2ndbest', 'Anthony', 'Edwards', '212-876-5309', 'RIO_Goose@gmail.com', 1, 0);
insert into User (ID, UserName, Password, FirstName, LastName, PhoneNumber, Email, IsReviewer, IsAdmin)
	values (3, 'Maverick', 'imthebest', 'Pete', 'Mitchell', '418-890-4859', 'TG1@hotmail.com', 0, 1);
    
insert into Vendor (ID, Code, Name, Address, City, State, Zip, PhoneNumber, Email)
	values (1, 'MC224', 'MicroCenter - Sharonville,OH', '11755 Mosteller Rd', 'Sharonville', 'OH', '45241', '513-782-8500', 'MikeS1@microcenter.com');
insert into Vendor (ID, Code, Name, Address, City, State, Zip, PhoneNumber, Email)
	values (2, 'SC456', 'The Shepherd Color Company', '4539 Dues Dr', 'Cincinnati', 'OH', '45246', '513-874-0714', 'SalesUSA@shepherdcolor.com');
insert into Vendor (ID, Code, Name, Address, City, State, Zip, PhoneNumber, Email)
	values (3, 'ATH89', 'Anthem Insurance Company', '4361 Irwin Simpson Rd', 'Mason', 'OH', '45040', '800-483-2311', 'Contact@anthem.com');
insert into Vendor (ID, Code, Name, Address, City, State, Zip, PhoneNumber, Email)
	values (4, 'CTS01', 'CTS-Midwest', '5901 Creek Rd', 'Cincinnati', 'OH', '45242', '513-793-0670', 'CTS-Midwest@CTS.com');
    
insert into Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	values (1, 1, '1ECJ9', 'Standard Toilet Paper Dispenser', 86.00, '1 PK', 'https://www.grainger.com/product/TOUGH-GUY-Security-Toilet-Paper-Dispenser-1ECJ9');
insert into Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	values (2, 4, '1LYJ8', 'Coreless Toilet Paper Dispenser', 15.90, '1 PK', 'https://www.grainger.com/product/GEORGIA-PACIFIC-Toilet-Paper-Dispenser-1LYJ8');
insert into Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	values (3, 2, '1PHJ1', 'Toilet Paper - 2000 ft.', 50.00, '8 PK', 'https://www.grainger.com/product/GEORGIA-PACIFIC-Acclaim-1-Ply-Jumbo-Toilet-1PHJ1');
insert into Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	values (4, 3, '1PHJ2', 'Toilet Paper - 1000 ft.', 46.08, '8 PK', 'https://www.grainger.com/product/GEORGIA-PACIFIC-Envision-2-Ply-Jumbo-Toilet-1PHJ2');
insert into Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	values (5, 4, '31XG56', 'Vinyl Basket Truck - 15 cu. ft. Capacity', 275.00, '1 EA', 'https://www.grainger.com/product/ROYAL-BASKET-TRUCKS-Blue-Vinyl-Basket-Truck-31XG56?breadcrumbCatId=CC_1003_1000140_27770_1000502_4436');
insert into Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	values (6, 3, '20JK38', 'Vinyl Basket Truck - 20 cu. ft. Capacity', 510.00, '1 EA', 'https://www.grainger.com/product/ROYAL-BASKET-TRUCKS-Blue-Vinyl-Basket-Truck-20JK38?breadcrumbCatId=CC_1003_1000140_27770_1000502_4436');
insert into Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	values (7, 3, '15Y109', 'Thread Connection Broom Handle - Plastic', 7.00, '1 EA', 'https://www.grainger.com/product/TOUGH-GUY-Black-Threaded-Metal-Metal-15Y109');
insert into Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	values (8, 1, '15Y111', 'Thread Connection Broom Handle - Metal', 20.50, '1 EA', 'https://www.grainger.com/product/TOUGH-GUY-Black-Threaded-Metal-Metal-15Y111');
insert into Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	values (9, 2, '2RRA2', 'Push Broom Head - Wood, Acme Thread', 25.25, '1 EA', 'https://www.grainger.com/product/ABILITY-ONE-Mixed-Filament-Push-Broom-2RRA2');
insert into Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	values (10, 2, '1ELK1', 'Cleaning Pail - 5 gal.', 17.40, '1 EA', 'https://www.grainger.com/product/TOUGH-GUY-Pail-1ELK1');
insert into Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	values (11, 4, '32UV16', 'Microfiber Cloth', 93.50, '12 PK', 'https://www.grainger.com/product/TOUGH-GUY-Microfiber-Cloth-32UV16');




    

    

