/*
CREATE DATABASE Airport
go
USE Airport

--�������� ������ --------------------------------------------
CREATE TABLE pilot
(
Id_pilot INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
name VARCHAR(30) NOT NULL,
surname VARCHAR(30) NOT NULL,
patronymic VARCHAR(30) NOT NULL, 
birth DATE NOT NULL
)

CREATE TABLE airplane
(
Id_airplane INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
name_airplane VARCHAR(30) NOT NULL
)

go

CREATE TABLE departures
(
Id_departures INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
Id_pilot INT NOT NULL FOREIGN KEY REFERENCES pilot(Id_pilot),
Id_airplane INT NOT NULL FOREIGN KEY REFERENCES airplane(Id_airplane),
date_departures DATE NOT NULL,
distance FLOAT NOT NULL,
time_departures FLOAT NOT NULL
)
--���������� ������--------------------------------------------------------
go 
INSERT INTO pilot 
(surname, name, patronymic, birth) 
VALUES
( '������', '����', '��������', '1988-10-10'),
( '������', '����', '��������', '1986-09-15'),
( '��������', '����', '�����������', '1987-02-02'),
( '�����', '����', '����������', '1981-11-21')


INSERT INTO airplane 
(name_airplane) 
VALUES
( 'Boeing 747'),
( 'Airbus A320'),
( 'Boing 767'),
( 'Boing 777')
go 

INSERT INTO departures 
(Id_airplane, Id_pilot,  date_departures, distance, time_departures) 
VALUES
(1, 1, '2015-09-01', 895, 2 ),
(2, 2, '2015-09-02', 1200, 3 ),
(2, 3, '2015-09-03', 1423, 3.5 ),
(2, 4, '2015-09-04', 4789, 8 ),
(3, 1, '2015-09-05', 4200, 7.5 ),
(2, 2, '2015-09-06', 1720, 4 ),
(1, 3, '2015-09-07', 1420, 4 ),
(4, 4, '2015-09-08', 874, 2 )
*/
--�������-----------------------------------------------------------------------------------------------------------
--1 ���������� ����� ����, ��������� � ��������� ���� ������, �� ������� ����
--select Id_departures as 'ID �����', '���� � �����' = DATEdiff(day, departures.date_departures, GETDATE())    from departures

--2 �������� �������, ������� ��������� 2 ��� ����� ���������� 
/*
select sv2.id_pl as 'ID ������',pilot.name as '���',pilot.surname as '�������', sv2.num_air as '���������� ��������' from (select sv_departures.sv_ip_pilot as id_pl,  count(sv_departures.sv_ip_airplane) as num_air 
	from (SELECT DISTINCT departures.Id_airplane as sv_ip_airplane, departures.Id_pilot as sv_ip_pilot FROM departures) as sv_departures
		group by sv_departures.sv_ip_pilot) as sv2
	inner join pilot on sv2.id_pl = pilot.Id_pilot
	where sv2.num_air >=2
*/
--3 �������� ������ � ������, ������� �������� ���������� ����������
/*
select departures.Id_pilot , sum(departures.distance) as max_sum_distance from departures
	inner join pilot on departures.Id_pilot = pilot.Id_pilot
	group by  departures.Id_pilot
	having sum(departures.distance) = (select top(1) sum(departures.distance) as max_col from departures
										inner join pilot on departures.Id_pilot = pilot.Id_pilot
										group by  departures.Id_pilot 
										order by max_col desc
)						
*/
--4 ������� ����� ����� ������ ����� ��������� � ���� �� ��� ���������� �������
/*
select departures.Id_pilot, sum(departures.time_departures)as '����� ����� � �����' from departures
	group by departures.Id_pilot 
*/
--5 ���������� �������� ������� �����, (�.�. ����� � ���������� ���������)
/*
select departures.Id_departures, (departures.distance / departures.time_departures) as max_speed from departures
	where (departures.distance / departures.time_departures) = ( select  top(1) (departures.distance / departures.time_departures) as V from departures
																	order by V desc
																	)
*/
--6 �������� ������� ����� ����� � ����
 -- select avg(departures.time_departures) as '������� ����� ����� � ����' from departures

--7 ������� ������ � ������ ����� � ���� ������ 5	
/* 
select departures.Id_departures as 'ID  �����' ,departures.time_departures as '����� � ����' from departures
Where departures.time_departures < 5
*/
-- 8 ���������� ����� ����������, ��������� �� ��������� Boeing 747
/*
select airplane.name_airplane as '������ �������'  , Sum(departures.distance) as '����� ��������' from departures
	inner join airplane on departures.Id_airplane = airplane.Id_airplane
	Where airplane.name_airplane = 'Boeing 747'
	group by airplane.name_airplane 
*/
--9 
/*�������� ������ �� ������� ������ � ������� ������, �� 10.09.2015 � �������� ���������
������ (id � ������� � ����� - ���������� � ����� � ����) (8 � 5 � 2 - 4875 � 8). ���������� ��
������ ������ ��� �������, ��� � ������� ������ ID � ��������� ����, � ������� � ����� �
������� �����
*/
/*
INSERT INTO departures 
(Id_departures, Id_airplane, Id_pilot, distance, time_departures, date_departures ) 
VALUES
(8, 5, 2, 4875, 8, '2015-09-10' )
*/
/*
�����:
�� ��������� ��� ��� ID departures ��������  identity (������������� �����������), � ��� �� � ��� ��� ���� ID = 8
��� ��, � ��� ��� ������� � Id_airplane = 5 
*/
--10 
/*
���������, ������ ��������������� ������� ������ � ������� � ����� ������� ���������,
����� ����� ��������� ��������� ������� ������?

�����:
������ ������ ����� ����� ����� �������, � ������ ����� ������������� ���������� � �������
� �������, ���� �� ���� ������� � ��������� ��������� ����� ���������, �� ������������� ���� �� �������� 3-� ���������� �����
*/

