CREATE DATABASE Гостинница 

GO

USE Гостинница

CREATE TABLE Тип_номера
(
код_тип_номера INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
название_тип_номера VARCHAR(50) NOT NULL,
количество_комнат int NOT NULL,
количество_кроватей int NOT NULL,
площадь_номера float NOT NULL,
сейф bit NOT NULL,
бар bit NOT NULL,
душ bit NOT NULL,
тв bit NOT NULL, 
холодильник bit NOT NULL, 
кондиционер bit NOT NULL, 
стоимость_в_сутки float NOT NULL
)

CREATE TABLE Услуги
(
код_услуги INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
наименование VARCHAR(50) NOT NULL,
стоимость int NOT NULL,
длительность float NOT NULL
)



CREATE TABLE Постоялец
(
код_постояльца INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
фамилия VARCHAR(50) NOT NULL,
имя VARCHAR(50) NOT NULL,
отчество VARCHAR(50) NOT NULL
)

go

CREATE TABLE Паспортные_данные
(
код_паспортных_данных INT NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES Постоялец(код_постояльца),
паспорт_серия INT NOT NULL ,
паспорт_номер INT NOT NULL ,
кем_выдан VARCHAR(50) NOT NULL,
дата_выдачи date NOT NULL,
пол VARCHAR(50) NOT NULL,
дата_рождения date NOT NULL
)

CREATE TABLE Оказанные_услуги
(
код_оказанные_услуги INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
код_услуги int NOT NULL FOREIGN KEY REFERENCES Услуги(код_услуги),
количество_раз int NOT NULL
)

go

CREATE TABLE Постоялец_оказанная_услуга
(
код_постоялец_оказанная_услуга INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
код_постояльца int NOT NULL FOREIGN KEY REFERENCES Постоялец(код_постояльца),
код_оказанные_услуги int NOT NULL FOREIGN KEY REFERENCES Оказанные_услуги(код_оказанные_услуги)
)
go

CREATE TABLE Данные_о_номерах
(
код_номера INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
код_типа_номера int NOT NULL FOREIGN KEY REFERENCES Тип_номера(код_тип_номера),
числовой_номер_комнаты int NOT NULL,
номер_свободен bit NOT NULL
)

 go
CREATE TABLE Посещение_номера
(
код_посещение_номера INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
код_постоялец int NOT NULL FOREIGN KEY REFERENCES Постоялец(код_постояльца),
код_номера int NOT NULL FOREIGN KEY REFERENCES Данные_о_номерах(код_номера),
дата_заезда date NOT NULL,
дата_отъезда date NOT NULL
)





