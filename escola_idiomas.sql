CREATE DATABASE escola_idiomas;
USE escola_idiomas;


CREATE TABLE aluno (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    data_nasc DATE,
    email VARCHAR(100)
);

CREATE TABLE professor (
    id_prof INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE curso (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    idioma VARCHAR(50) NOT NULL,
    dificuldade VARCHAR(30)
);


CREATE TABLE turma (
    id_turma INT AUTO_INCREMENT PRIMARY KEY,
    periodo VARCHAR(20),  
    horario VARCHAR(50),
    id_curso INT,
    id_prof INT,
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
    FOREIGN KEY (id_prof) REFERENCES professor(id_prof)
);

CREATE TABLE matricula (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    data_mat DATE NOT NULL,
    status VARCHAR(20), 
    id_aluno INT,
    id_turma INT,
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    FOREIGN KEY (id_turma) REFERENCES turma(id_turma)
);

CREATE TABLE pagamento (
    id_pgto INT AUTO_INCREMENT PRIMARY KEY,
	valor VARCHAR(50) NOT NULL,    
	data_vencimento DATE NOT NULL,
    data_pgto DATE,
    desconto VARCHAR(50),
    status VARCHAR(20),               
    id_matricula INT,
    FOREIGN KEY (id_matricula) REFERENCES matricula(id_matricula)
);