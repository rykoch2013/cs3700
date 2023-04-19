-- Database Final Project: Part 2

-- When using Programiz.com
DROP TABLE Customers;
DROP TABLE Orders;
DROP TABLE Shippings;

--Part 2: Table Creations

CREATE TABLE Volunteer(
firstName varchar2(30),
lastName varchar2(30),
street varchar2(30),
city varchar2(30),
state varchar2(30),
zip varchar2(30),
country varchar2(30),
countryCode number(8),
areaCode varchar2(30),
telNumber varchar2(30),
CONSTRAINT Volunteer_fname_lname_pk PRIMARY KEY (firstName,lastName));

CREATE TABLE PotentialDonor(
donorID number(8),
firstName varchar2(30),
lastName varchar2(30),
street varchar2(30),
city varchar2(30),
state varchar2(30),
zip varchar2(30),
country varchar2(30),
countryCode number(8),
areaCode varchar2(30),
telNumber varchar2(30),
donorCircle varchar2(30),
spouseName varchar2(30),
amountDonatedLastYear number(10,2),
amountPledgedThisYear number(10,2),
amountPaidThisYear number(10,2),
volunteerFirstName varchar2(30),
volunteerLastName varchar2(30),
CONSTRAINT Donor_donorID_pk PRIMARY KEY (donorID)
FOREIGN KEY (volunteerFirstName,volunteerLastName) REFERENCES Volunteer(firstName,lastName));

CREATE TABLE MatchingCorp(
matchCorpName varchar2(30),
street varchar2(30),
city varchar2(30),
state varchar2(30),
zip varchar2(30),
country varchar2(30),
countryCode number(8),
areaCode varchar2(30),
telNumber varchar2(30),
repName varchar2(30),
rep countryCode number(8),
repAreaCode varchar2(30),
repTelNumber varchar2(30),
percentMatch number(3),
CONSTRAINT MatchCorp_MatchCorpName_pk PRIMARY KEY (matchCorpName));

CREATE TABLE Event(
eventName varchar2(30),
eventDate varchar2(30),
eventTime varchar2(30),
eventLocation varchar2(30),
eventOrganizer varchar2(30),
eventTotalPledged number(10,2),
eventTotalPaid number(10,2),
CONSTRAINT Event_eventName_pk PRIMARY KEY (eventName));

CREATE TABLE ClassRep(
graduationYear date,
firstName varchar2(30),
lastName varchar2(30),
street varchar2(30),
city varchar2(30),
state varchar2(30),
zip varchar2(30),
country varchar2(30),
countryCode number(8),
areaCode varchar2(30),
telNumber varchar2(30),
CONSTRAINT Classrep_graduationYear_pk PRIMARY KEY (graduationYear));

CREATE TABLE Pledge(
pledgeNumber number(8),
pledgeAmount number(10,2),
pledgeDate date,
numPaymentsChosen number(8),
pledgeAmountPaid number(10,2),
numPaymentsMade number(8),
donorID number(8),
eventName varchar2(30),
CONSTRAINT Pledge_pledgeNumber_pk PRIMARY KEY (pledgeNumber),
FOREIGN KEY (donorID) REFERENCES PotentialDonor(donorID),
FOREIGN KEY (eventName) REFERENCES Event(eventName));

CREATE TABLE PledgePayment(
pledgeNumber number(8),
datePaid date,
amountPaid number(10,2),
paymentMethod varchar2(30),
creditCardType varchar2(30),
creditCardNumber varchar2(30),
previousPaymentDate date,
matchCorpName varchar2(30),
CONSTRAINT PledgePayment_pledgeNumber_pk PRIMARY KEY (pledgeNumber,datePaid),
FOREIGN KEY (pledgeNumber) REFERENCES Pledge(pledgeNumber),
FOREIGN KEY (matchCorpName) REFERENCES MatchingCorp(matchCorpName));

CREATE TABLE Attends(
donorID number(8),
eventName varchar2(30),
CONSTRAINT Attends_pk PRIMARY KEY (donorID,eventName));


--Error: UNIQUE constraint failed: Matches.pledgeNumber, Matches.matchCorpName
CREATE TABLE Matches(
pledgeNumber number(8),
matchCorpName varchar2(30),
spouse number(8),
CONSTRAINT Matches_pledgeNumber_matchCorpName PRIMARY KEY (pledgeNumber,matchCorpName),
FOREIGN KEY (matchCorpName) REFERENCES MatchingCorp(matchCorpName));

CREATE TABLE Donor_GradYear(
donorID number(8),
graduationYear date,
degree varchar2(30),
CONSTRAINT DonorGradYr_donorID_gradYear_pk PRIMARY KEY (donorID,graduationYear),
FOREIGN KEY (graduationYear) REFERENCES ClassRep(graduationYear));

CREATE TABLE Donor_Categories(
donorID number(8),
donorCategory varchar2 (30),
CONSTRAINT donorCategory_ID_Category_pk PRIMARY KEY (donorID,donorCategory),
FOREIGN KEY (donorID) REFERENCES PotentialDonor(donorID));

CREATE TABLE Donor_Child(
donorID number(8),
childName varchar2(30),
childGradYear date,
CONSTRAINT donorChild_ID_childName_pk PRIMARY KEY (donorId,childName),
FOREIGN KEY (donorID) REFERENCES PotentialDonor(donorID));

--
-- Part 3: Table Insertion
--

INSERT INTO Volunteer values('Mary','Smith', '123 Main St', 'New
Rochelle','NY','10801','USA',1, '914', '6661234');
INSERT INTO Volunteer values('John','Courtney', '1 Spruce Street','New York','NY',
'10101','USA',1, '917','3456789');
INSERT INTO Volunteer values('Susan','Hynes', '10 Pacific Avenue', 'San Diego',
'CA','92101','USA',1, '619','3216789');
INSERT INTO Volunteer values('Martin','Williams', '1 Windswept Place', 'Chicago',
'IL','60601','USA',1, '312','1239876');
INSERT INTO Volunteer values('Thomas','Smith', '715 North Avenue','New Rochelle','NY',
'10801','USA',1, '914', '6662222');

INSERT INTO PotentialDonor values(111, 'John','Jackson','24 Pine Avenue','New
York','NY','10101','USA',1,'917','7771234','Bronze','Wendy Jackson',4000,3000,2000,null,null);
INSERT INTO PotentialDonor values(222, 'Mary','Lee','10 Ash Street','Miami', 'FL','33010','USA',1,'305', '5551234','Bronze','Thomas
Lee','2000',3000,2000,'Mary','Smith');
INSERT INTO PotentialDonor values(333, 'Ramon','Perez','15 Poplar Avenue','San Diego', 'CA','92101','USA',1,'619',
'8881234','Platinum','Celia Perez',4500,3500,2000,'John','Courtney');
INSERT INTO PotentialDonor values(444, 'Rick','Lee','20 Maple Avenue','New York','NY','10101','USA',1,'917',
'7778888','Platinum','Valerie Paxton',40000,30000,30000,null,null);
INSERT INTO PotentialDonor values(555, 'Samantha','Torno','10 Ash Street','Miami', 'FL','33010','USA',1,'305',
'5551234','Presidential','David Torno',60000,55000,55000,null,null);
INSERT INTO PotentialDonor values(666, 'Adam','Nixon','15-32 Beach Boulevard','Miami', 'FL','33010','USA',1,'305', '5551234',null
,null,0,0,0,'Susan','Hynes');

INSERT INTO MatchingCorp values('IBM', '1 New Orchard Road','Armonk','NY','10504', 'USA',1,'914','4991900', 'Adam
Downs',1,'914','4991901', 100);
INSERT INTO MatchingCorp values('Pepsi Bottling Group', '1 Pepsi Way','Somers','NY','10589', 'USA',1,'914','7676000', 'Kimberly
Jones',1,'914','7676001', 100);
INSERT INTO MatchingCorp values('Prudential Insurance', '751 Broad Street','Newark','NJ','07102',
'USA',1,'973','8026056','Evelyn Walsh',1,'973','8026057', 50 );

INSERT INTO Event values('Fall Carnival','10-Oct-2021','10-5','campus lot', 'Suzanne Hayes',50000, 20000);
INSERT INTO Event values('Holiday Dinner Dance', '20-Dec-2021', '8-12pm','Waldorf-Astoria','Rick Lee', 100000, 70000);
INSERT INTO Event values('Spring Golf Outing','15-May-2022','8-11am','Pines Golf Course', 'John Jackson',75000,60000);
INSERT INTO Event values('Family Picnic','25-Jun-2022','10-4', 'Leisure Park', 'Suzanne Hayes', 0, 0);

INSERT INTO ClassRep values('01-Jan-2021','Sue','Lyons','333 South Street','New Rochelle','NY','10801','USA',1, '914', '8881234');
INSERT INTO ClassRep values('01-Jan-2012', 'John','Jackson','24 Pine Avenue','New York','NY','10101','USA',1,'917','7771234');
INSERT INTO ClassRep values('01-Jan-2011', 'Rick','Lee','20 Maple Avenue','New York','NY','10101','USA',1,'917', '7778888');
INSERT INTO ClassRep values('01-Jan-2010', 'Deirdre','Clancy','10 Oak Avenue', 'Newark','NJ','07102','USA',1,'973','1234567');
INSERT INTO ClassRep values('01-Jan-2002', 'Sam','Levine','202 Elm Road','Chicago', 'IL','60601','USA',1,'917','7654321');
INSERT INTO ClassRep values('01-Jan-1985', 'Jim','Nelson','2 Pacific Highway','San Diego', 'CA','92101','USA',1,'609','8184321');

INSERT INTO Pledge values(1234, 600.00, '02-Feb-2022',3,200.00,1, 111,'Fall Carnival');
INSERT INTO Pledge values(2345,100.00, '28-Dec-2021',1,100.00,1, 222,'Holiday Dinner Dance');
INSERT INTO Pledge values(3456, 1000, '01-Apr-2022',5,200.00,1, 333, null);
INSERT INTO Pledge values(4567, 2000, '31-Dec-2021',1,1000,1,444,'Spring Golf Outing');
INSERT INTO Pledge values(5678, 10000, '01-May-2022',2,5000,1,111,'Holiday Dinner Dance');

INSERT INTO PledgePayment values(1234,'01-Mar-2022',200.00,'check',null,null,'01-Feb-2022',null);
INSERT INTO PledgePayment values(1234,'15-Mar-2022',600.00,'check',null,null,'01-Mar-2022','IBM');
INSERT INTO PledgePayment values(2345,'28-Dec-2021',100.00,'check',null,null,null,null);
INSERT INTO PledgePayment values(2345,'5-Jan-2022',100.00,'check',null,null,null,'Pepsi Bottling Group');
INSERT INTO PledgePayment values(2345,'10-Jan-2022',100.00,'check',null,null,null,'Prudential Insurance');
INSERT INTO PledgePayment values(3456,'01-Apr-2022',200.00,'credit','Visa','123456789101',null,null);
INSERT INTO PledgePayment values(3456,'15-Apr-2022',1000.00,'check',null,null,'01-Apr-2022','Prudential Insurance');
INSERT INTO PledgePayment values(4567,'31-Dec-2021',1000,'check',null, null,null, null);
INSERT INTO PledgePayment values(4567,'15-Jan-2022',1000,'check',null, null,'31-Dec-2021','Pepsi Bottling Group');
INSERT INTO PledgePayment values(5678,'01-May-2022',5000,'check',null, null, null, null);
INSERT INTO PledgePayment values(5678,'15-May-2022',5000,'check',null, null,'01-May-2022','IBM' );


INSERT INTO Attends values(111,'Holiday Dinner Dance');
INSERT INTO Attends values(222,'Holiday Dinner Dance');
INSERT INTO Attends values(111,'Fall Carnival');
INSERT INTO Attends values(444,'Fall Carnival');
INSERT INTO Attends values(444,'Spring Golf Outing');
INSERT INTO Attends values(555,'Holiday Dinner Dance');


--Error: UNIQUE constraint failed: Matches.pledgeNumber, Matches.matchCorpName
INSERT INTO Matches values(1234, 'IBM',0);
INSERT INTO Matches values(1234, 'Prudential Insurance',1);


INSERT INTO Donor_GradYear values(111, '01-Jan-1985', 'BA');
INSERT INTO Donor_GradYear values(111, '01-Jan-2021', 'PhD');
INSERT INTO Donor_GradYear values(222, '01-Jan-2012', 'BS');
INSERT INTO Donor_GradYear values(333, '01-Jan-2012', 'MA');
INSERT INTO Donor_GradYear values(444, '01-Jan-2021', 'BS');
INSERT INTO Donor_GradYear values(555, '01-Jan-2010', 'BA');

INSERT INTO Donor_Categories values(111, 'alum');
INSERT INTO Donor_Categories values(111, 'parent');
INSERT INTO Donor_Categories values(222, 'alum');
INSERT INTO Donor_Categories values(333, 'parent');
INSERT INTO Donor_Categories values(444, 'alum');
INSERT INTO Donor_Categories values(555, 'alum');

INSERT INTO Donor_Child values(333,'Samantha Torno', '01-Jan-2010');

--
-- Part 4: Query
--

--DONE
--Based on Donor_Categories table only, calculate the number of donors for each donor category.
SELECT donorCategory,COUNT(1)
as numDonors
FROM Donor_Categories
GROUP BY donorCategory
ORDER BY numDonors;

--DONE
--Based on Volunteer table only, find all volunteers in the state of New York, i.e. state is NY.
SELECT * 
FROM Volunteer 
WHERE state = 'NY';

--DONE
--Find the names of all the potential donors who attended the Holiday Dinner Dance
SELECT Attends.donorID,firstName,lastName
FROM PotentialDonor,Attends
WHERE eventName = 'Holiday Dinner Dance'
AND Attends.donorID=PotentialDonor.donorID;

--Find the name of each company that matched a donation and the total amount per company
--NOTHING WORKS
SELECT *
FROM MatchingCorp
Where MatchingCorp.matchCorpName=Matches.matchCorpName;

--DONE
--Find the total amount in pledges due to the event of Holiday Dinner Dance

SELECT SUM(pledgeAmount) - SUM(pledgeAmountPaid)
AS amountDue
FROM Pledge
WHERE eventName = 'Holiday Dinner Dance';

--Find the total amount in pledges for each of the fundraising events.


--DONE ENOUGH
--Find the ID and total amount pledged by each person.
SELECT donorID,amountPledgedThisYear+amountDonatedLastYear
FROM PotentialDonor
