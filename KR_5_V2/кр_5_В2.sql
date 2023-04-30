/*
CREATE DATABASE Airport
go
USE Airport

--Создание таблиц --------------------------------------------
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
--Заполнение таблиц--------------------------------------------------------
go 
INSERT INTO pilot 
(surname, name, patronymic, birth) 
VALUES
( 'Петров', 'Петр', 'Петрович', '1988-10-10'),
( 'Иванов', 'Иван', 'Иванович', '1986-09-15'),
( 'Курпатов', 'Олег', 'Анатольевич', '1987-02-02'),
( 'Агеев', 'Федр', 'Николаевич', '1981-11-21')


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
--Запросы-----------------------------------------------------------------------------------------------------------
--1 Рассчитать число дней, прошедших с последней даты вылета, на текущую дату
--select Id_departures as 'ID полёта', 'Дней с полёта' = DATEdiff(day, departures.date_departures, GETDATE())    from departures

--2 Показать пилотов, которые управляли 2 или более самолетами 
/*
select sv2.id_pl as 'ID пилота',pilot.name as 'Имя',pilot.surname as 'Фамилия', sv2.num_air as 'Количество самолётов' from (select sv_departures.sv_ip_pilot as id_pl,  count(sv_departures.sv_ip_airplane) as num_air 
	from (SELECT DISTINCT departures.Id_airplane as sv_ip_airplane, departures.Id_pilot as sv_ip_pilot FROM departures) as sv_departures
		group by sv_departures.sv_ip_pilot) as sv2
	inner join pilot on sv2.id_pl = pilot.Id_pilot
	where sv2.num_air >=2
*/
--3 Показать данные о пилоте, который пролетел наибольшее расстояние
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
--4 Сколько всего часов каждый пилот находился в пути за все количество вылетов
/*
select departures.Id_pilot, sum(departures.time_departures)as 'Общее время в полёте' from departures
	group by departures.Id_pilot 
*/
--5 Рассчитать наиболее быстрый полет, (т.е. полет с наибольшей скоростью)
/*
select departures.Id_departures, (departures.distance / departures.time_departures) as max_speed from departures
	where (departures.distance / departures.time_departures) = ( select  top(1) (departures.distance / departures.time_departures) as V from departures
																	order by V desc
																	)
*/
--6 Показать среднее число часов в пути
 -- select avg(departures.time_departures) as 'Среднее число часов в пути' from departures

--7 Выбрать полеты с числом часов в пути меньше 5	
/* 
select departures.Id_departures as 'ID  рейса' ,departures.time_departures as 'Часов в пути' from departures
Where departures.time_departures < 5
*/
-- 8 Рассчитать общее расстояние, пройдённое на самолетах Boeing 747
/*
select airplane.name_airplane as 'Модель самолёта'  , Sum(departures.distance) as 'Общая истанция' from departures
	inner join airplane on departures.Id_airplane = airplane.Id_airplane
	Where airplane.name_airplane = 'Boeing 747'
	group by airplane.name_airplane 
*/
--9 
/*Написать запрос на вставку данных в таблицу вылеты, за 10.09.2015 и вставить следующие
данные (id – самолет – пилот - расстояние – часов в пути) (8 – 5 – 2 - 4875 – 8). Выполнится ли
данный запрос при условии, что в таблице вылеты ID – первичный ключ, а самолет и пилот –
внешние ключи
*/
/*
INSERT INTO departures 
(Id_departures, Id_airplane, Id_pilot, distance, time_departures, date_departures ) 
VALUES
(8, 5, 2, 4875, 8, '2015-09-10' )
*/
/*
Ответ:
Не сработает так как ID departures является  identity (автоматически заполняемой), а так же у нас уже есть ID = 8
так же, у нас нет самолёта с Id_airplane = 5 
*/
--10 
/*
Объяснить, почему нецелесообразно хранить данные о вылетах в прямо таблице самолетов,
зачем нужно создавать отдельную таблицу вылеты?

Ответ:
Каждый самолёт может иметь много вылетов, а значит будет дублироваться информация о самолёте
К примеру, если бы наша таблица с самолётами содержала много атрибутов, то дополнительно была бы нарушена 3-я нормальная форма
*/

