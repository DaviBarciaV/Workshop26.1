# 1) criando schema e o usando (pode ser aberto dando double click no nome em "schemas")

create schema if not exists concessionaria_velozcar;
use concessionaria_velozcar;

# 2) criando tabelas - DDL

CREATE TABLE IF NOT EXISTS Categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    qtd_passageiro INT NOT NULL,
    cambio VARCHAR(20)  NOT NULL,
    combustivel VARCHAR(20) NOT NULL,
    camera_re TINYINT(1) NOT NULL DEFAULT 0,
    ar_condicionado TINYINT(1) NOT NULL DEFAULT 1,
    portas INT NOT NULL
);
 
CREATE TABLE IF NOT EXISTS Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(20) NOT NULL DEFAULT 'disponivel',
    placa VARCHAR(10) NOT NULL UNIQUE,
    valor_diaria DECIMAL(10,2) NOT NULL,
    n_chassi VARCHAR(17) NOT NULL UNIQUE,
    modelo VARCHAR(50) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    cor VARCHAR(30) NOT NULL,
    ano YEAR NOT NULL,
    id_categoria INT NOT NULL,
	CONSTRAINT fk_veiculo_categoria FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)

);
 
CREATE TABLE IF NOT EXISTS Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    telefone VARCHAR(15) NOT NULL,
    n_cnh VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    endereco VARCHAR(200) NOT NULL,
    data_cadastro DATE NOT NULL
);
 
CREATE TABLE IF NOT EXISTS Funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    telefone VARCHAR(15) NOT NULL
);
 
CREATE TABLE IF NOT EXISTS Locacao (
    id_locacao INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_funcionario INT NOT NULL,
    id_veiculo INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'ativa',
    km_inicial INT NOT NULL,
    km_final  INT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NULL,
    CONSTRAINT fk_locacao_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_locacao_funcionario FOREIGN KEY (id_funcionario) REFERENCES Funcionario(id_funcionario),
    CONSTRAINT fk_locacao_veiculo FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo)
);
 
CREATE TABLE IF NOT EXISTS Pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_locacao INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_pgto DATE NOT NULL,
    metodo VARCHAR(30) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'pendente',
    codigo_transacao VARCHAR(50) NULL,
    observacao TEXT NULL,
    CONSTRAINT fk_pagamento_locacao FOREIGN KEY (id_locacao) REFERENCES Locacao(id_locacao)
);
 
CREATE TABLE IF NOT EXISTS Manutencao (
    id_manutencao INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    id_funcionario INT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'em andamento',
    relatorio TEXT NULL,
    tipo VARCHAR(50)  NOT NULL,
    custo DECIMAL(10,2) NOT NULL,
    data_fim  DATE NULL,
    data_inicio DATE NOT NULL,
    CONSTRAINT fk_manutencao_veiculo FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    CONSTRAINT fk_manutencao_funcionario FOREIGN KEY (id_funcionario) REFERENCES Funcionario(id_funcionario)
);

# 3) inserindo os dados de cada tabela - DML

INSERT INTO Categoria (nome, qtd_passageiro, cambio, combustivel, camera_re, ar_condicionado, portas) VALUES
('Econômico',      5, 'Manual',     'Flex',     0, 1, 4),
('Intermediário',  5, 'Automático', 'Flex',     1, 1, 4),
('SUV Compacto',   5, 'Automático', 'Flex',     1, 1, 4),
('SUV Premium',    7, 'Automático', 'Gasolina', 1, 1, 4),
('Pickup',         5, 'Automático', 'Diesel',   1, 1, 4),
('Minivan',        7, 'Automático', 'Flex',     1, 1, 4),
('Esportivo',      4, 'Automático', 'Gasolina', 0, 1, 2),
('Luxo',           5, 'Automático', 'Gasolina', 1, 1, 4),
('Elétrico',       5, 'Automático', 'Elétrico', 1, 1, 4),
('Compacto',       5, 'Manual',     'Flex',     0, 1, 4);
 
INSERT INTO Veiculo (status, placa, valor_diaria, n_chassi, modelo, marca, cor, ano, id_categoria) VALUES
('disponivel',   'ABC1D23', 120.00, '9BWZZZ377VT004251', 'HB20',        'Hyundai',    'Prata',    2022, 1),
('disponivel',   'DEF2E34', 180.00, '9BWZZZ377VT004252', 'Virtus',      'Volkswagen', 'Branco',   2023, 2),
('alugado',      'GHI3F45', 220.00, '9BWZZZ377VT004253', 'Creta',       'Hyundai',    'Preto',    2023, 3),
('disponivel',   'JKL4G56', 350.00, '9BWZZZ377VT004254', 'Compass',     'Jeep',       'Cinza',    2023, 4),
('manutencao',   'MNO5H67', 280.00, '9BWZZZ377VT004255', 'Hilux',       'Toyota',     'Branco',   2022, 5),
('disponivel',   'PQR6I78', 260.00, '9BWZZZ377VT004256', 'Spin',        'Chevrolet',  'Prata',    2021, 6),
('disponivel',   'STU7J89', 420.00, '9BWZZZ377VT004257', 'GR86',        'Toyota',     'Vermelho', 2023, 7),
('alugado',      'VWX8K90', 480.00, '9BWZZZ377VT004258', 'Corolla XRS', 'Toyota',     'Preto',    2023, 8),
('disponivel',   'YZA9L01', 380.00, '9BWZZZ377VT004259', 'BYD Dolphin', 'BYD',        'Azul',     2024, 9),
('disponivel',   'BCD0M12', 110.00, '9BWZZZ377VT004260', 'Mobi',        'Fiat',       'Vermelho', 2021, 10),
('alugado',      'EFG1N23', 195.00, '9BWZZZ377VT004261', 'Polo',        'Volkswagen', 'Cinza',    2022, 2),
('disponivel',   'HIJ2O34', 310.00, '9BWZZZ377VT004262', 'Renegade',    'Jeep',       'Verde',    2022, 3),
('disponivel',   'KLM3P45', 140.00, '9BWZZZ377VT004263', 'Kwid',        'Renault',    'Branco',   2023, 1),
('manutencao',   'NOP4Q56', 450.00, '9BWZZZ377VT004264', 'X1',          'BMW',        'Preto',    2023, 8),
('disponivel',   'QRS5R67', 240.00, '9BWZZZ377VT004265', 'Tracker',     'Chevrolet',  'Prata',    2023, 3);
 
INSERT INTO Cliente (nome, cpf, telefone, n_cnh, email, endereco, data_cadastro) VALUES
('Ana Paula Ferreira',      '12345678901', '83991110001', '12345678901', 'ana.paula@email.com',      'Rua das Flores, 10, João Pessoa-PB',   '2022-03-15'),
('Carlos Eduardo Lima',     '23456789012', '83991110002', '23456789012', 'carlos.lima@email.com',    'Av. Epitácio Pessoa, 200, JP-PB',      '2022-05-20'),
('Mariana Costa Silva',     '34567890123', '83991110003', '34567890123', 'mariana.cs@email.com',     'Rua João Suassuna, 5, Campina Grande-PB','2022-07-10'),
('Roberto Alves Santos',    '45678901234', '83991110004', '45678901234', 'roberto.as@email.com',     'Rua Floriano Peixoto, 300, Recife-PE', '2022-09-01'),
('Juliana Martins Rocha',   '56789012345', '83991110005', '56789012345', 'juliana.mr@email.com',     'Av. Beira Rio, 45, João Pessoa-PB',    '2023-01-12'),
('Fernando Souza Pereira',  '67890123456', '83991110006', '67890123456', 'fernando.sp@email.com',    'Rua do Sol, 88, Natal-RN',             '2023-02-28'),
('Patricia Oliveira Nunes', '78901234567', '83991110007', '78901234567', 'patricia.on@email.com',    'Rua Sete de Setembro, 12, Fortaleza-CE','2023-04-05'),
('Lucas Mendes Barbosa',    '89012345678', '83991110008', '89012345678', 'lucas.mb@email.com',       'Rua da Aurora, 67, João Pessoa-PB',    '2023-06-18'),
('Camila Torres Dias',      '90123456789', '83991110009', '90123456789', 'camila.td@email.com',      'Av. Cruz das Armas, 130, JP-PB',       '2023-08-22'),
('Thiago Ramos Cavalcante', '01234567890', '83991110010', '01234567890', 'thiago.rc@email.com',      'Rua Nova, 55, Maceió-AL',              '2023-10-30'),
('Beatriz Lima Gonçalves',  '11223344556', '83991110011', '11223344556', 'beatriz.lg@email.com',     'Rua do Parque, 77, João Pessoa-PB',    '2024-01-07'),
('Rafael Andrade Costa',    '22334455667', '83991110012', '22334455667', 'rafael.ac@email.com',      'Rua Presidente Médici, 9, JP-PB',      '2024-02-14'),
('Fernanda Lopes Vieira',   '33445566778', '83991110013', '33445566778', 'fernanda.lv@email.com',    'Av. Cabo Branco, 400, João Pessoa-PB', '2024-03-19'),
('Eduardo Carvalho Braga',  '44556677889', '83991110014', '44556677889', 'eduardo.cb@email.com',     'Rua Mangabeira, 200, João Pessoa-PB',  '2024-05-05'),
('Isabela Freitas Pinto',   '55667788990', '83991110015', '55667788990', 'isabela.fp@email.com',     'Rua dos Ipês, 33, João Pessoa-PB',     '2024-06-21');
 
INSERT INTO Funcionario (nome, cpf, email, salario, cargo, telefone) VALUES
('João Paulo Neto',         '98765432100', 'joao.neto@locadora.com',     3500.00, 'Atendente',      '83981110001'),
('Silvia Regina Moura',     '87654321099', 'silvia.moura@locadora.com',  3500.00, 'Atendente',      '83981110002'),
('Marcos Vinícius Cunha',   '76543210988', 'marcos.cunha@locadora.com',  5000.00, 'Supervisor',     '83981110003'),
('Tereza Cristina Borges',  '65432109877', 'tereza.b@locadora.com',      2800.00, 'Mecânico',       '83981110004'),
('André Luis Farias',       '54321098766', 'andre.farias@locadora.com',  2800.00, 'Mecânico',       '83981110005'),
('Priscila Fontes Melo',    '43210987655', 'priscila.m@locadora.com',    8000.00, 'Gerente',        '83981110006'),
('Rodrigo Albuquerque',     '32109876544', 'rodrigo.a@locadora.com',     3500.00, 'Atendente',      '83981110007'),
('Clarice Esteves Lima',    '21098765433', 'clarice.e@locadora.com',     4200.00, 'Analista TI',    '83981110008'),
('Henrique Dias Matos',     '10987654322', 'henrique.d@locadora.com',    2800.00, 'Mecânico',       '83981110009'),
('Vanessa Queiroz Prado',   '09876543211', 'vanessa.qp@locadora.com',    3500.00, 'Atendente',      '83981110010'),
('Wellington Cruz Pires',   '08765432100', 'wellington.cp@locadora.com', 3500.00, 'Atendente',      '83981110011'),
('Daniela Sampaio Luz',     '07654321099', 'daniela.sl@locadora.com',    6500.00, 'Coordenadora',   '83981110012');
 
INSERT INTO Locacao (id_cliente, id_funcionario, id_veiculo, valor, status, km_inicial, km_final, data_inicio, data_fim) VALUES
(1,  1, 1,  360.00,  'concluida', 15200, 15590,  '2024-01-05', '2024-01-08'),
(2,  2, 2,  540.00,  'concluida', 32000, 32450,  '2024-01-10', '2024-01-13'),
(3,  1, 3,  660.00,  'concluida', 8000,  8450,   '2024-02-01', '2024-02-04'),
(4,  7, 4,  1050.00, 'concluida', 5100,  5680,   '2024-02-14', '2024-02-17'),
(5,  2, 6,  780.00,  'concluida', 21000, 21520,  '2024-03-01', '2024-03-04'),
(6,  1, 7,  840.00,  'concluida', 12000, 12320,  '2024-03-10', '2024-03-12'),
(7,  7, 8,  960.00,  'concluida', 7500,  8100,   '2024-04-05', '2024-04-07'),
(8,  2, 10, 330.00,  'concluida', 41000, 41310,  '2024-04-20', '2024-04-23'),
(9,  1, 11, 585.00,  'concluida', 19000, 19420,  '2024-05-02', '2024-05-05'),
(10, 7, 12, 930.00,  'concluida', 6000,  6600,   '2024-05-18', '2024-05-21'),
(11, 1, 13, 280.00,  'concluida', 3000,  3220,   '2024-06-01', '2024-06-03'),
(12, 2, 2,  900.00,  'concluida', 32450, 33050,  '2024-06-10', '2024-06-15'),
(13, 7, 9,  1140.00, 'concluida', 500,   1120,   '2024-07-01', '2024-07-04'),
(14, 1, 4,  700.00,  'concluida', 5680,  6100,   '2024-07-15', '2024-07-17'),
(15, 2, 3,  440.00,  'ativa',     8450,  NULL,   '2024-08-01', NULL),
(1,  7, 8,  480.00,  'ativa',     8100,  NULL,   '2024-08-05', NULL),
(3,  1, 11, 390.00,  'ativa',     19420, NULL,   '2024-08-10', NULL);
 
INSERT INTO Pagamento (id_locacao, valor, data_pgto, metodo, status, codigo_transacao, observacao) VALUES
(1,  360.00,  '2024-01-08', 'Cartão de Crédito', 'aprovado',  'TXN001', NULL),
(2,  540.00,  '2024-01-13', 'PIX',                'aprovado',  'TXN002', NULL),
(3,  660.00,  '2024-02-04', 'Cartão de Débito',   'aprovado',  'TXN003', NULL),
(4,  1050.00, '2024-02-17', 'Cartão de Crédito', 'aprovado',  'TXN004', 'Parcelado em 2x'),
(5,  780.00,  '2024-03-04', 'PIX',                'aprovado',  'TXN005', NULL),
(6,  840.00,  '2024-03-12', 'Cartão de Crédito', 'aprovado',  'TXN006', NULL),
(7,  960.00,  '2024-04-07', 'Cartão de Crédito', 'aprovado',  'TXN007', NULL),
(8,  330.00,  '2024-04-23', 'Dinheiro',           'aprovado',  'TXN008', NULL),
(9,  585.00,  '2024-05-05', 'PIX',                'aprovado',  'TXN009', NULL),
(10, 930.00,  '2024-05-21', 'Cartão de Crédito', 'aprovado',  'TXN010', NULL),
(11, 280.00,  '2024-06-03', 'PIX',                'aprovado',  'TXN011', NULL),
(12, 900.00,  '2024-06-15', 'Cartão de Débito',   'aprovado',  'TXN012', NULL),
(13, 1140.00, '2024-07-04', 'Cartão de Crédito', 'aprovado',  'TXN013', 'Cliente Premium'),
(14, 700.00,  '2024-07-17', 'PIX',                'aprovado',  'TXN014', NULL);
 
INSERT INTO Manutencao (id_veiculo, id_funcionario, status, relatorio, tipo, custo, data_inicio, data_fim) VALUES
(5,  4, 'concluida', 'Troca de óleo e filtros realizada.',                           'Preventiva',  350.00, '2024-01-20', '2024-01-21'),
(14, 5, 'concluida', 'Revisão geral dos 20.000 km.',                                 'Revisão',     800.00, '2024-02-05', '2024-02-07'),
(1,  9, 'concluida', 'Balanceamento e alinhamento corrigidos.',                       'Corretiva',   250.00, '2024-02-18', '2024-02-18'),
(5,  4, 'concluida', 'Troca de pastilhas de freio dianteiras.',                      'Corretiva',   420.00, '2024-03-15', '2024-03-16'),
(7,  5, 'concluida', 'Revisão dos 10.000 km realizada.',                              'Preventiva',  500.00, '2024-04-01', '2024-04-02'),
(10, 9, 'concluida', 'Troca de pneus traseiros.',                                    'Corretiva',   680.00, '2024-04-25', '2024-04-26'),
(14, 4, 'concluida', 'Suspensão dianteira revisada e amortecedores trocados.',       'Corretiva',   1200.00,'2024-05-10', '2024-05-12'),
(2,  5, 'concluida', 'Limpeza do sistema de injeção eletrônica.',                    'Preventiva',  300.00, '2024-06-03', '2024-06-03'),
(6,  9, 'concluida', 'Troca de correia dentada conforme programação.',               'Preventiva',  750.00, '2024-06-20', '2024-06-21'),
(5,  4, 'em andamento', 'Diagnóstico em andamento. Possível problema no alternador.','Corretiva',   600.00, '2024-07-30', NULL),
(14, 5, 'em andamento', 'Aguardando peça para substituição da bomba de combustível.','Corretiva',   950.00, '2024-08-02', NULL),
(3,  9, 'concluida', 'Revisão pré-locação realizada com sucesso.',                   'Preventiva',  200.00, '2024-07-25', '2024-07-25');

# 4) updates relevantes

# atualiza o status e km_final das locações ativas para concluídas (simulação de devolução)
UPDATE Locacao
SET status   = 'concluida',
    km_final = 8750,
    data_fim = '2024-08-05'
WHERE id_locacao = 15;
 
# atualiza o salário dos mecânicos com aumento de 10%
SET SQL_SAFE_UPDATES = 0;
UPDATE Funcionario
SET salario = salario * 1.10
WHERE cargo = 'Mecânico';
SET SQL_SAFE_UPDATES = 1;

# 5) consultas de agregação e agrupamento - DQL
 
# 5.1) categoria
# quantidade de veículos por categoria e valor diário médio 
SELECT
    c.nome AS categoria,
    COUNT(v.id_veiculo) AS total_veiculos,
    ROUND(AVG(v.valor_diaria), 2) AS media_diaria
FROM Categoria c
LEFT JOIN Veiculo v ON v.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.nome
ORDER BY total_veiculos DESC;
 
# categorias com mais de 1 veículo e maior valor médio diário
SELECT
    c.nome AS categoria,
    c.combustivel,
    COUNT(v.id_veiculo) AS total_veiculos,
    MAX(v.valor_diaria) AS maior_diaria,
    MIN(v.valor_diaria) AS menor_diaria
FROM Categoria c
INNER JOIN Veiculo v ON v.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.nome, c.combustivel
HAVING COUNT(v.id_veiculo) > 1
ORDER BY maior_diaria DESC;
 
# 5.2) veículo
# total e percentual de veículos por status
SELECT
    status,
    COUNT(*) AS quantidade,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Veiculo), 1) AS percentual
FROM Veiculo
GROUP BY status
ORDER BY quantidade DESC;

# quilometragem rodada por veículo nas locações concluídas
SELECT
    v.placa, v.modelo, v.marca,COUNT(l.id_locacao) AS total_locacoes,
    SUM(l.km_final - l.km_inicial) AS km_total_rodado,
    ROUND(AVG(l.km_final - l.km_inicial), 0) AS media_km_por_locacao
FROM Veiculo v
INNER JOIN Locacao l ON l.id_veiculo = v.id_veiculo
WHERE l.status = 'concluida' AND l.km_final IS NOT NULL
GROUP BY v.id_veiculo, v.placa, v.modelo, v.marca
ORDER BY km_total_rodado DESC;
 
# 5.3) cliente
# clientes com maior valor total gasto em locações
SELECT
    c.nome, c.email,
    COUNT(l.id_locacao) AS total_locacoes,
    SUM(l.valor) AS total_gasto,
    ROUND(AVG(l.valor), 2) AS ticket_medio
FROM Cliente c
INNER JOIN Locacao l ON l.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nome, c.email
ORDER BY total_gasto DESC
LIMIT 10;
 
# clientes cadastrados por ano
SELECT
    YEAR(data_cadastro) AS ano_cadastro,
    COUNT(*) AS novos_clientes
FROM Cliente
GROUP BY YEAR(data_cadastro)
ORDER BY ano_cadastro;

# 5.4) funcionario 
# salário médio, mínimo e máximo por cargo
SELECT
    cargo,
    COUNT(*) AS total_funcionarios,
    ROUND(AVG(salario), 2) AS salario_medio,
    MIN(salario) AS salario_minimo,
    MAX(salario) AS salario_maximo
FROM Funcionario
GROUP BY cargo
ORDER BY salario_medio DESC;
 
# funcionários com maior número de locações atendidas
SELECT
    f.nome, f.cargo,
    COUNT(l.id_locacao) AS locacoes_atendidas,
    SUM(l.valor) AS receita_gerada
FROM Funcionario f
INNER JOIN Locacao l ON l.id_funcionario = f.id_funcionario
GROUP BY f.id_funcionario, f.nome, f.cargo
ORDER BY locacoes_atendidas DESC;
 
# 5.5) locação 
# receita total e média por mês de início
SELECT
    DATE_FORMAT(data_inicio, '%Y-%m') AS mes,
    COUNT(*) AS total_locacoes,
    SUM(valor) AS receita_total,
    ROUND(AVG(valor), 2) AS ticket_medio
FROM Locacao
GROUP BY DATE_FORMAT(data_inicio, '%Y-%m')
ORDER BY mes;
 
# duração média das locações e receita por status
SELECT
    status,
    COUNT(*) AS total,
    ROUND(AVG(DATEDIFF(COALESCE(data_fim, CURDATE()), data_inicio)), 1) AS duracao_media_dias,
    SUM(valor) AS receita_total
FROM Locacao
GROUP BY status;

# 5.6) pagamento
# total arrecadado e número de transações por método de pagamento
SELECT
    metodo,
    COUNT(*) AS total_transacoes,
    SUM(valor) AS total_arrecadado,
    ROUND(AVG(valor), 2) AS ticket_medio
FROM Pagamento
GROUP BY metodo
ORDER BY total_arrecadado DESC;
 
# receita total aprovada por mês
SELECT
    DATE_FORMAT(data_pgto, '%Y-%m') AS mes,
    COUNT(*) AS pagamentos_aprovados,
    SUM(valor) AS receita_aprovada
FROM Pagamento
WHERE status = 'aprovado'
GROUP BY DATE_FORMAT(data_pgto, '%Y-%m')
ORDER BY mes;

# 5.7) manutenção 
# custo total e médio de manutenção por tipo
SELECT
    tipo,
    COUNT(*) AS total_manutencoes,
    SUM(custo) AS custo_total,
    ROUND(AVG(custo), 2) AS custo_medio,
    MAX(custo) AS maior_custo
FROM Manutencao
GROUP BY tipo
ORDER BY custo_total DESC;
 
# veículos com maior custo acumulado de manutenção
SELECT
    v.placa, v.modelo, v.marca,
    COUNT(m.id_manutencao) AS total_manutencoes,
    SUM(m.custo) AS custo_total_manutencao
FROM Veiculo v
INNER JOIN Manutencao m ON m.id_veiculo = v.id_veiculo
GROUP BY v.id_veiculo, v.placa, v.modelo, v.marca
ORDER BY custo_total_manutencao DESC;

# 6) fazendo join - DQL
# detalhamento completo das locações com dados de cliente, funcionário e veículo
SELECT
    l.id_locacao, l.data_inicio, l.data_fim, 
    l.status AS status_locacao,
    c.nome AS cliente,
    f.nome AS atendente,
    v.placa,
    CONCAT(v.marca, ' ', v.modelo) AS veiculo,
    l.valor AS valor_locacao,
    p.status AS status_pagamento,
    p.metodo
FROM Locacao l
INNER JOIN Cliente c ON c.id_cliente = l.id_cliente
INNER JOIN Funcionario f ON f.id_funcionario = l.id_funcionario
INNER JOIN Veiculo v ON v.id_veiculo = l.id_veiculo
LEFT  JOIN Pagamento p ON p.id_locacao = l.id_locacao
ORDER BY l.data_inicio;

# histórico de manutenção com responsável
SELECT
    v.placa,
    CONCAT(v.marca, ' ', v.modelo)  AS veiculo,
    m.tipo, m.custo, m.data_inicio,
    m.status AS status_manutencao,
    f.nome AS mecanico_responsavel
FROM Funcionario f
RIGHT JOIN Manutencao m ON m.id_funcionario = f.id_funcionario
INNER JOIN Veiculo v ON v.id_veiculo = m.id_veiculo
ORDER BY m.data_inicio DESC;

# pagamentos com dados completos da locação e do cliente
SELECT
    p.id_pagamento,
    p.data_pgto,
    p.metodo,
    p.valor                         AS valor_pago,
    p.status                        AS status_pagamento,
    c.nome                          AS cliente,
    c.cpf,
    l.data_inicio,
    l.data_fim,
    CONCAT(v.marca, ' ', v.modelo)  AS veiculo
FROM Pagamento p
INNER JOIN Locacao  l ON l.id_locacao  = p.id_locacao
INNER JOIN Cliente  c ON c.id_cliente  = l.id_cliente
INNER JOIN Veiculo  v ON v.id_veiculo  = l.id_veiculo
ORDER BY p.data_pgto;

# manutenções com dados do veículo, categoria e funcionário responsável
SELECT
    m.id_manutencao,
    m.data_inicio,
    m.data_fim,
    m.tipo,
    m.status                        AS status_manutencao,
    m.custo,
    CONCAT(v.marca, ' ', v.modelo)  AS veiculo,
    v.placa,
    v.ano,
    cat.nome                        AS categoria,
    f.nome                          AS responsavel,
    f.cargo
FROM Manutencao m
INNER JOIN Veiculo    v   ON v.id_veiculo    = m.id_veiculo
INNER JOIN Categoria  cat ON cat.id_categoria = v.id_categoria
INNER JOIN Funcionario f  ON f.id_funcionario = m.id_funcionario
ORDER BY m.data_inicio DESC;


