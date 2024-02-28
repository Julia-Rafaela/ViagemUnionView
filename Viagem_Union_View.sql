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
  (12341, 'Julio Cesar', 'São Paulo'),
  (12342, 'Mario Carmo', 'Americana'),
  (12343, 'Lucio Castro', 'Campinas'),
  (12344, 'André Figueiredo', 'São Paulo'),
  (12345, 'Luiz Carlos', 'São Paulo'),
  (12346, 'Carlos Roberto', 'Campinas'),
  (12347, 'João Paulo', 'São Paulo')

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
  ('aqw2374', 'Volvo', 2014, 'Leito')   

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
(101, 'adf0965', 12343, 10, 12, 'São Paulo', 'Campinas'),
  (102, 'gui7625', 12341, 7, 12, 'São Paulo', 'Araraquara'),
  (103, 'bhg7654', 12345, 14, 22, 'São Paulo', 'Rio de Janeiro'),
  (104, 'dtr2093', 12344, 18, 21, 'São Paulo', 'Sorocaba'),
  (105, 'aqw2374', 12342, 11, 17, 'São Paulo', 'Ribeirão Preto'),
  (106, 'jhy9425', 12347, 10, 19, 'São Paulo', 'São José do Rio Preto'),
  (107, 'lmk7485', 12346, 13, 20, 'São Paulo', 'Curitiba'),
  (108, 'adf0965', 12343, 14, 16, 'Campinas', 'São Paulo'),
  (109, 'gui7625', 12341, 14, 19, 'Araraquara', 'São Paulo'),
  (110, 'bhg7654', 12345, 0, 8, 'Rio de Janeiro', 'São Paulo'),
  (111, 'dtr2093', 12344, 22, 1, 'Sorocaba', 'São Paulo'),
  (112, 'aqw2374', 12342, 19, 5, 'Ribeirão Preto', 'São Paulo'),
  (113, 'jhy9425', 12347, 22, 7, 'São José do Rio Preto', 'São Paulo'),
  (114, 'lmk7485', 12346, 0, 7, 'Curitiba', 'São Paulo')

  --Exercício:															
--1) Criar um Union das tabelas Motorista e ônibus, com as colunas ID (Código e Placa) e Nome (Nome e Marca)		
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
--3) Criar uma View (Chamada v_descricao_onibus) que mostre o Código da Viagem, o Nome do motorista, a placa do ônibus (Formato XXX-0000), 
--a Marca do ônibus, o Ano do ônibus e a descrição do onibus	
CREATE VIEW  v_descricao_onibus
AS	
SELECT v.Codigo AS Cod_Viagem, m.Nome AS Nome_Motorista, CONCAT(SUBSTRING(o.Placa, 1,3),'-', SUBSTRING(o.Placa, 4,4)) AS Placa_Onibus,	
       o.Marca, o.Ano, o.Descricao
FROM Motorista	m 
INNER JOIN Viagem v ON m.Codigo = v.Motorista
INNER JOIN Onibus o ON o.placa = v.Onibus		

SELECT * FROM v_descricao_onibus						
--4) Criar uma View (Chamada v_descricao_viagem) que mostre o Código da viagem, a placa do ônibus(Formato XXX-0000), 
--a Hora da Saída da viagem (Formato HH:00), a Hora da Chegada da viagem (Formato HH:00), partida e destino															
CREATE VIEW v_descricao_viagem
AS	
SELECT v.Codigo AS Cod_Viagem, CONCAT(SUBSTRING(o.Placa, 1,3),'-', SUBSTRING(o.Placa, 4,4)) AS Placa_Onibus,	
       CONCAT(SUBSTRING(CAST(v.Hora_Saida AS VARCHAR), 1, 2), ':00') AS Hora_Saida,
       CONCAT(SUBSTRING(CAST(v.Hora_Chegada AS VARCHAR), 1, 2), ':00') AS Hora_Chegada,
       v.Partida, v.Destino
FROM Onibus o
INNER JOIN Viagem v ON o.placa = v.Onibus

SELECT * FROM v_descricao_viagem