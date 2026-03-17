create schema DESAFIO;

CREATE TABLE proprietarios (
    id_proprietario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cpf INT NOT NULL,
    cidade VARCHAR(50) NOT NULL
);

ALTER TABLE proprietarios MODIFY COLUMN cpf CHAR(11) NOT NULL;

CREATE TABLE motos (
    id_moto INT AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(30) NOT NULL,
    placa VARCHAR(7) NOT NULL,
    renavam VARCHAR (15) NOT NULL,
    chassi VARCHAR (20) NOT NULL,
    modelo VARCHAR(30) NOT NULL,
    consumo DECIMAL(5,2) NOT NULL,
    cor VARCHAR (30) NOT NULL,
    id_proprietario INT NOT NULL,
    FOREIGN KEY (id_proprietario) REFERENCES proprietarios(id_proprietario)
);

ALTER TABLE motos 
DROP COLUMN placa, 
DROP COLUMN renavam,
DROP COLUMN cor,
DROP COLUMN chassi;

INSERT INTO proprietarios (nome, cpf, cidade) VALUES
('Davi', '12345678901', 'João Pessoa'),
('Ana', '98765432109', 'Cabedelo'),
('Carlos', '45678912300', 'Campina Grande'),
('Beatriz', '32165498711', 'João Pessoa'),
('Lucas', '65432178922', 'Patos'),
('Mariana', '15975346833', 'Santa Rita'),
('Pedro', '75315948644', 'João Pessoa'),
('Fernanda', '95135724655', 'Bayeux'),
('Marcos', '35715924666', 'Sousa'),
('Juliana', '48625915777', 'Cabedelo');

INSERT INTO motos (marca, modelo, consumo, id_proprietario) 
VALUES
('Honda', 'CBR 1000RR-R', 15.50, 1),
('Yamaha', 'YZF-R1', 14.20, 2),
('Ducati', 'Panigale V4', 13.50, 3),
('Aprilia', 'RSV4', 14.00, 4),
('KTM', 'RC 8C', 15.00, 5),
('Suzuki', 'GSX-R1000', 16.50, 6),
('BMW', 'S 1000 RR', 15.80, 7),
('Kawasaki', 'Ninja ZX-10R', 14.80, 8),
('Honda', 'CB 500F', 26.50, 9),
('Yamaha', 'MT-09', 18.50, 10);

UPDATE motos SET consumo = 16.00 WHERE id_moto = 1;

SELECT p.nome, m.marca, m.modelo
FROM proprietarios p
INNER JOIN motos m ON p.id_proprietario = m.id_proprietario;

SELECT p.cidade, COUNT(m.id_moto) AS total_motos
FROM proprietarios p
INNER JOIN motos m ON p.id_proprietario = m.id_proprietario
GROUP BY p.cidade;

SELECT marca, AVG(consumo) AS media_consumo, MAX(consumo) AS maior_consumo
FROM motos
GROUP BY marca;