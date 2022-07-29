
Create DATABASE vitals_mgmt_db
Create DATABASE [AP]

CREATE TABLE patient (
    id int,
    name varchar(255),
    dob date,
    Address varchar(255),
    city varchar(255),
    country varchar(255)
);

Select * from patient where id=1

Select name,dob from patient where id=1 

INSERT INTO patient (id, name, address, dob, city, country)
VALUES (8, 'Tilak', 'No.42 Jayanta nagar Ram nagar', '08-12-1976','Delhi', 'India');

Update patient set city= 'Lahore' where country = 'Pakistan' 

Select name,dob from patient where country='India' order by dob asc
Select name,dob from patient where country='India' order by dob desc

/* set column names on dispay*/
Select id as PatientID, dob as dateofbirth from patient
Select PatientID=id, dateofbirth=dob from patient /*old method*/

