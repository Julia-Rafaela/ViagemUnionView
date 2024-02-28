CREATE DATABASE viagem_union
GO
USE viagem_union

GO
CREATE TABLE Motorista(			
Codigo				CHAR(05)		NOT NULL,	
Nome				VARCHAR(40)		NOT NULL,
Naturalidade		VARCHAR(40)		NOT NULL
PRIMARY KEY (Codigo)
)

INSERT INTO Motorista VALUES
  (12341, 'Julio Cesar', 'S�o Paulo'),
  (12342, 'Mario Carmo', 'Americana'),
  (12343, 'Lucio Castro', 'Campinas'),
  (12344, 'Andr� Figueiredo', 'S�o Paulo'),
  (12345, 'Luiz Carlos', 'S�o Paulo'),
  (12346, 'Carlos Roberto', 'Campinas'),
  (12347, 'Jo�o Paulo', 'S�o Paulo')

GO
CREATE TABLE Onibus(			
Placa			CHAR(07)			NOT NULL,
Marca			VARCHAR(15)			NOT NULL,
Ano				INT					NOT NULL,
Descricao		VARCHAR(20)			NOT NULL
PRIMARY KEY (Placa)
)


INSERT INTO	Onibus VALUES
  ('adf0965', 'Mercedes', 2009, 'Leito'),
  ('bhg7654', 'Mercedes', 2012, 'Sem Banheiro'),
  ('dtr2093', 'Mercedes', 2017, 'Ar Condicionado'),
  ('gui7625', 'Volvo', 2014, 'Ar Condicionado'),
  ('jhy9425', 'Volvo', 2018, 'Leito'),
  ('lmk7485', 'Mercedes', 2015, 'Ar Condicionado'),
  ('aqw2374', 'Volvo', 2014, 'Leito')���

GO
CREATE TABLE Viagem(					
Codigo				INT			NOT NULL,
Onibus				CHAR(7)			NOT NULL,
Motorista			CHAR(05)			NOT NULL,
Hora_Saida			INT  		NOT NULL,
Hora_Chegada		INT 		NOT NULL,
Partida             VARCHAR(40)	NOT NULL,		
Destino				VARCHAR(40)	NOT NULL
PRIMARY KEY (Codigo, Onibus, Motorista)
FOREIGN KEY (Onibus) REFERENCES Onibus(Placa),
FOREIGN KEY (Motorista) REFERENCES Motorista(Codigo)
)

INSERT INTO Viagem VALUES
(101, 'adf0965', 12343, 10, 12, 'S�o Paulo', 'Campinas'),
  (102, 'gui7625', 12341, 7, 12, 'S�o Paulo', 'Araraquara'),
  (103, 'bhg7654', 12345, 14, 22, 'S�o Paulo', 'Rio de Janeiro'),
  (104, 'dtr2093', 12344, 18, 21, 'S�o Paulo', 'Sorocaba'),
  (105, 'aqw2374', 12342, 11, 17, 'S�o Paulo', 'Ribeir�o Preto'),
  (106, 'jhy9425', 12347, 10, 19, 'S�o Paulo', 'S�o Jos� do Rio Preto'),
  (107, 'lmk7485', 12346, 13, 20, 'S�o Paulo', 'Curitiba'),
  (108, 'adf0965', 12343, 14, 16, 'Campinas', 'S�o Paulo'),
  (109, 'gui7625', 12341, 14, 19, 'Araraquara', 'S�o Paulo'),
  (110, 'bhg7654', 12345, 0, 8, 'Rio de Janeiro', 'S�o Paulo'),
  (111, 'dtr2093', 12344, 22, 1, 'Sorocaba', 'S�o Paulo'),
  (112, 'aqw2374', 12342, 19, 5, 'Ribeir�o Preto', 'S�o Paulo'),
  (113, 'jhy9425', 12347, 22, 7, 'S�o Jos� do Rio Preto', 'S�o Paulo'),
  (114, 'lmk7485', 12346, 0, 7, 'Curitiba', 'S�o Paulo')

  --Exerc�cio:															
--1) Criar um Union das tabelas Motorista e �nibus, com as colunas ID (C�digo e Placa) e Nome (Nome e Marca)		
SELECT Codigo, Nome, 'MOTORISTA' AS Tipo
FROM Motorista
UNION
SELECT Placa, Marca, 'ONIBUS' AS Tipo
FROM Onibus
													
--2) Criar uma View (Chamada v_motorista_onibus) do Union acima		
CREATE VIEW v_motorista_onibus
AS
SELECT Codigo, Nome, 'MOTORISTA' AS Tipo
FROM Motorista
UNION
SELECT Placa, Marca, 'ONIBUS' AS Tipo
FROM Onibus

SELECT * FROM v_motorista_onibus													
--3) Criar uma View (Chamada v_descricao_onibus) que mostre o C�digo da Viagem, o Nome do motorista, a placa do �nibus (Formato XXX-0000), 
--a Marca do �nibus, o Ano do �nibus e a descri��o do onibus	
CREATE VIEW  v_descricao_onibus
AS	
SELECT v.Codigo AS Cod_Viagem, m.Nome AS Nome_Motorista, CONCAT(SUBSTRING(o.Placa, 1,3),'-', SUBSTRING(o.Placa, 4,4)) AS Placa_Onibus,	
       o.Marca, o.Ano, o.Descricao
FROM Motorista	m 
INNER JOIN Viagem v ON m.Codigo = v.Motorista
INNER JOIN Onibus o ON o.placa = v.Onibus		

SELECT * FROM v_descricao_onibus						
--4) Criar uma View (Chamada v_descricao_viagem) que mostre o C�digo da viagem, a placa do �nibus(Formato XXX-0000), 
--a Hora da Sa�da da viagem (Formato HH:00), a Hora da Chegada da viagem (Formato HH:00), partida e destino															
CREATE VIEW v_descricao_viagem
AS	
SELECT v.Codigo AS Cod_Viagem, CONCAT(SUBSTRING(o.Placa, 1,3),'-', SUBSTRING(o.Placa, 4,4)) AS Placa_Onibus,	
       CONCAT(SUBSTRING(CAST(v.Hora_Saida AS VARCHAR), 1, 2), ':00') AS Hora_Saida,
       CONCAT(SUBSTRING(CAST(v.Hora_Chegada AS VARCHAR), 1, 2), ':00') AS Hora_Chegada,
       v.Partida, v.Destino
FROM Onibus o
INNER JOIN Viagem v ON o.placa = v.Onibus

SELECT * FROM v_descricao_viagem