--create database
create database Crime_Management

-- create  table crime
 create table Crime (CrimeId int identity(100,1) primary key,IncidentType varchar(250),
 IncidentDate date not null ,Location varchar(250),Description Text,Status varchar(20))
 
 --create table victim 

 create table Victim(VictimId int identity(50,1) primary key,CrimeID int not null foreign key references Crime(CrimeId),
 VictimName varchar(255),ContactInfo varchar(255),Injuries varchar(255))

 --alter table because age is asked in table

 alter table  victim
 add age int

 --update the values
 update victim 
 set age=25
 where victimid=50
 update victim 
 set age=20
 where victimid=51
 update victim 
 set age=35
 where victimid=52
 update victim 
 set age=30
 where victimid=53
 
 
 
 
 
 --create table Suspect 

 create table suspect (SuspectId int identity(1,1) primary key,CrimeID int not null foreign key references Crime(CrimeId),
 SuspectName varchar(250), Description Text,CriminalHistory Text)

 
 -- alter the table because age is specified inn the query
 alter table suspect 
 add age int
 --update the age because age is asked in query
 update suspect 
 set age=25
 where suspectid=1
 update suspect 
 set age=30
 where suspectid=2
 update suspect  
 set age=36
 where suspectid=3
 update suspect 
 set age=45
 where suspectid=4
 --Insert into crime

 insert into Crime  values ('Robbery','2023-09-15','123 Main St,Cityville','Armed robbery at a convenience store','open'),
                           ('Homicide','2023-09-20','456 Elm St,Townville','Investigation into a murder case','Under Investigation'),
                           ('Theft', '2023-09-10','789 Oak St,Villagetown','Shoplifting incident at a mall','closed')
insert into crime values ('Robbery','2023-09-06','569 Benny St,California','Armed robbery at a street','under investigation')

insert into crime values ('Theft','2025-05-23','153 ABC St,Villagetown','Theft  costly jewels from home','closed')
insert into crime values('Robbery','2025-02-28','485 Anna Nagar Chennai','Armed robbery at home','open')
insert into crime values('Theft','2024-11-20','469 hfc st, Delhi','Theft bike','under investigation')
insert into crime values('Homicide','2024-06-03','632,kl st Bangalore','Investigation into attempt murder','Under Investigation')
insert into crime values('Assualt','2024-02-04','778,KK Nagar , Chennai','attempt murder','Under Investigation')

select * from crime

--insert into victim
insert into Victim values(100,'John Doe','johndoe@example.com','Minor injuries'),
                        (101,'Jane Smith','janesmith@example.com','Deceased'),
                        (102,'Alice Johnson','alicejohnson@example.com','None')

insert into victim values(103,'Steve john','stevejohn@example.com','Minor injuries')
insert into victim values(104,'Andrea Jacob','andreajacob@exampple.com','None')
insert into victim values(107,'Ramesh','ramesh@example.com','Minor injuries',40)
insert into victim values(108,'Rober 1','rober1@example.com','Minor injuries',25)

insert into victim values (109,'Sudha','sudha@example.com','None',23)
insert into victim values(110,'Praveen G','praveeng@example.com','Deceased',35)

--inseret into suspect

insert into Suspect values(100,'Rober 1 ','Armed and masked robber','Previous robbery convictions'),
                          (101,'Unknown','Investigatin ongoing',Null),
                          (102,'Suspect 1','Shoplifting suspect','Prior Shoplifting arrests')
insert into suspect values(103,'Suspect 2','person present in the street','Previous robbery cases')
insert into suspect values(104,'Rober 1 ','Armed and masked robber','Previous robbery convictions',25)
insert into suspect values (107,'unknown','Unidentified masked robber',null,50)
insert into suspect values (108,'Main suspect','wore mask and so tall',null,20)
insert into  suspect values (109,null,'wore mask and escaped from the spot',null,26)
insert into suspect values (110,null,'masked man ran after assult','previous murder convictions',40)

 --Solve the below queries:
--1. Select all open incidents. 
  select * from crime where status='open'

--2.Find the total number of incidents.
  select count(*)  as Total_incidents from crime 

--3.List all unique incident types
   select distinct IncidentType as Incidents from crime

--4.Retrieve incidents that occurred between '2023-09-01' and '2023-09-10
select * from crime where IncidentDate between '2023-09-01' and '2023-09-10'

--5.List persons involved in incidents in descending order of age
     select  suspectname  from suspect  order by age desc

--6.Find the average age of persons involved in incidents
 select avg(age) as average_age from suspect

--7.List incident types and their counts, only for open cases
  select incidentType, count(crimeid) as open_case from crime where status ='open' group by incidentType

--8.Find persons with names containing 'Doe
  select Victimname from victim where victimname  like '%Doe'

--9.Retrieve the names of persons involved in open cases and closed cases
  select suspectname from suspect s join crime c on  s.crimeid= c.crimeid  where c.status in ('open','closed')

--10.. List incident types where there are persons aged 30 or 35 involved
   select c.IncidentType from crime c join suspect s on c.crimeid=s.crimeid where age in(30,35)

--11.Find persons involved in incidents of the same type as 'Robbery'
   select s.suspectname from suspect s join crime c on c.crimeid=s.crimeid where incidenttype='Robbery'

--12. List incident types with more than one open case
     select IncidentType from crime  where status='open' group  by incidentType having count(status) >1

--13.List all incidents with suspects whose names also appear as victims in other incidents
      select distinct  c.crimeid, s.suspectname from crime c
      join suspect s on  c.crimeid = s.crimeid
      join victim v on s.suspectname = v.victimname
      WHERE s.crimeid != v.crimeid
--14.Retrieve all incidents along with victim and suspect details
    select v.victimname,v.contactinfo, s.suspectname,s.description from victim v 
    join crime c 
    on v.crimeid=c.crimeid
    join suspect s
    on s.crimeid=c.crimeid

 --15.Find incidents where the suspect is older than any victim
      select  c.crimeid,s.suspectname,s.age as suspect_age from crime c
      join  suspect s ON c.crimeid = s.crimeid
      join  victim v ON c.crimeid = v.crimeid
      group by c.crimeid, s.suspectname, s.age
      having s.age > MIN(v.age);    

 --16.Find suspects involved in multiple incidents
 select suspectname, count(distinct crimeid) as incident_count
 from suspect
 group  by  suspectname
 having count (distinct crimeid) > 1

 --17.List incidents with no suspects involved
   select c.incidentType from crime c left  join suspect s on s.crimeid = c.crimeid where s.suspectname is null

 --18.List all cases where at least one incident is of type 'Homicide' and all other incidents are of type 'Robbery'
   select crimeid from crime
   group by crimeid
   having 
    sum(CASE WHEN incidentType = 'Homicide' THEN 1 ELSE 0 END) >= 1
    AND
    sum(CASE WHEN incidentType NOT IN ('Homicide', 'Robbery') THEN 1 ELSE 0 END) = 0;

   

 --19.Retrieve a list of all incidents and the associated suspects, showing suspects for each incident, or
--'No Suspect' if there are none
   select  c.incidentType, isnull(s.suspectname, 'No Suspect') as suspect_name from suspect s left join crime c on c.crimeid=s.crimeid

--20.List all suspects who have been involved in incidents with incident types 'Robbery' or 'Assault'
   select s.suspectname from suspect s join crime c on c.crimeid=s.crimeid where incidentType = 'Robbery'
   or incidentType = 'Assualt'
