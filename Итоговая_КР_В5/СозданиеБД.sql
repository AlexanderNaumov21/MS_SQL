CREATE DATABASE ���������� 

GO

USE ����������

CREATE TABLE ���_������
(
���_���_������ INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
��������_���_������ VARCHAR(50) NOT NULL,
����������_������ int NOT NULL,
����������_�������� int NOT NULL,
�������_������ float NOT NULL,
���� bit NOT NULL,
��� bit NOT NULL,
��� bit NOT NULL,
�� bit NOT NULL, 
����������� bit NOT NULL, 
����������� bit NOT NULL, 
���������_�_����� float NOT NULL
)

CREATE TABLE ������
(
���_������ INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
������������ VARCHAR(50) NOT NULL,
��������� int NOT NULL,
������������ float NOT NULL
)



CREATE TABLE ���������
(
���_���������� INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
������� VARCHAR(50) NOT NULL,
��� VARCHAR(50) NOT NULL,
�������� VARCHAR(50) NOT NULL
)

go

CREATE TABLE ����������_������
(
���_����������_������ INT NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES ���������(���_����������),
�������_����� INT NOT NULL ,
�������_����� INT NOT NULL ,
���_����� VARCHAR(50) NOT NULL,
����_������ date NOT NULL,
��� VARCHAR(50) NOT NULL,
����_�������� date NOT NULL
)

CREATE TABLE ���������_������
(
���_���������_������ INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
���_������ int NOT NULL FOREIGN KEY REFERENCES ������(���_������),
����������_��� int NOT NULL
)

go

CREATE TABLE ���������_���������_������
(
���_���������_���������_������ INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
���_���������� int NOT NULL FOREIGN KEY REFERENCES ���������(���_����������),
���_���������_������ int NOT NULL FOREIGN KEY REFERENCES ���������_������(���_���������_������)
)
go

CREATE TABLE ������_�_�������
(
���_������ INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
���_����_������ int NOT NULL FOREIGN KEY REFERENCES ���_������(���_���_������),
��������_�����_������� int NOT NULL,
�����_�������� bit NOT NULL
)

 go
CREATE TABLE ���������_������
(
���_���������_������ INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
���_��������� int NOT NULL FOREIGN KEY REFERENCES ���������(���_����������),
���_������ int NOT NULL FOREIGN KEY REFERENCES ������_�_�������(���_������),
����_������ date NOT NULL,
����_������� date NOT NULL
)





