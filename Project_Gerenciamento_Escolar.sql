# Criando DataBase
CREATE DATABASE gerenciamento_escolar;

USE gerenciamento_escolar;

# Criando Tabelas para  o DataBase
CREATE TABLE estudantes (
	id_estudante INT AUTO_INCREMENT PRIMARY KEY,
    nome_estudante VARCHAR(50) NOT NULL,
    data_nascimento DATE,
    sexo ENUM('M', 'F')
);

CREATE TABLE cursos (
	id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nome_curso VARCHAR(50) NOT NULL,
    ano YEAR,
    carga_horaria INT
);

CREATE TABLE estudante_assiste_curso (
	id INT AUTO_INCREMENT PRIMARY KEY,
    id_estudante INT,
    id_curso INT,
    FOREIGN KEY (id_estudante) REFERENCES estudantes(id_estudante),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

CREATE TABLE professores (
	id_professor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    id_curso INT,
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

CREATE TABLE notas (
	id_notas INT AUTO_INCREMENT PRIMARY KEY,
    nota DECIMAL(4, 2),
    id_estudante INT,
    id_curso INT,
    FOREIGN KEY (id_estudante) REFERENCES estudantes(id_estudante),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

# Inserindo dados para as tabelas
INSERT INTO cursos VALUES
	(DEFAULT, 'Introdução à Programação', 2020, 40),
	(DEFAULT, 'Desenvolvimento Web', 2021, 60),
	(DEFAULT, 'Banco de Dados', 2022, 45),
	(DEFAULT, 'Inteligência Artificial', 2023, 70),
	(DEFAULT, 'Redes de Computadores', 2020, 50);
    
INSERT INTO estudantes VALUES
	(DEFAULT, 'Ana Clara', '2000-05-15', 'F'),
	(DEFAULT, 'Bruno Silva', '1998-08-22', 'M'),
	(DEFAULT, 'Carlos Eduardo', '1999-11-10', 'M'),
	(DEFAULT, 'Daniela Pereira', '2001-01-30', 'F'),
	(DEFAULT, 'Eduardo Oliveira', '1997-07-18', 'M'),
	(DEFAULT, 'Fernanda Costa', '2000-03-05', 'F'),
	(DEFAULT, 'Gabriel Santos', '1999-09-27', 'M'),
	(DEFAULT, 'Helena Rocha', '1998-12-14', 'F'),
	(DEFAULT, 'Igor Almeida', '2000-06-02', 'M'),
	(DEFAULT, 'Julia Martins', '2001-04-23', 'F'),
	(DEFAULT, 'Lucas Mendes', '1999-10-11', 'M'),
	(DEFAULT, 'Mariana Silva', '2001-02-28', 'F'),
	(DEFAULT, 'Nicolas Ribeiro', '1998-05-07', 'M'),
	(DEFAULT, 'Olivia Fernandes', '2000-08-19', 'F'),
	(DEFAULT, 'Pedro Henrique', '1997-11-25', 'M');

INSERT INTO estudante_assiste_curso VALUES
	(DEFAULT, 1, 1),
	(DEFAULT, 1, 2),
	(DEFAULT, 2, 1),
	(DEFAULT, 3, 2),
	(DEFAULT, 3, 3),
	(DEFAULT, 4, 2),
	(DEFAULT, 5, 3),
	(DEFAULT, 6, 3),
	(DEFAULT, 7, 4),
	(DEFAULT, 8, 4),
	(DEFAULT, 8, 5),
	(DEFAULT, 9, 5),
	(DEFAULT, 10, 1),
	(DEFAULT, 11, 2),
	(DEFAULT, 12, 3),
	(DEFAULT, 13, 4),
	(DEFAULT, 14, 4),
	(DEFAULT, 15, 5),
	(DEFAULT, 15, 1);

INSERT INTO professores VALUES
	(DEFAULT, 'Rogério Santos', 1),
    (DEFAULT, 'Anna Lívia', 2),
    (DEFAULT, 'José Dantes', 3),
    (DEFAULT, 'Mário Andrade', 4),
    (DEFAULT, 'Sarah Silva', 5);

INSERT INTO notas VALUES
	(DEFAULT, 85.50, 1, 1),
	(DEFAULT, 90.00, 1, 2),
	(DEFAULT, 78.25, 2, 1),
	(DEFAULT, 88.75, 3, 2),
	(DEFAULT, 92.00, 3, 3),
	(DEFAULT, 74.50, 4, 2),
	(DEFAULT, 81.00, 5, 3),
	(DEFAULT, 79.25, 6, 3),
	(DEFAULT, 84.00, 7, 4),
	(DEFAULT, 91.50, 8, 4),
	(DEFAULT, 87.75, 8, 5),
	(DEFAULT, 69.00, 9, 5),
	(DEFAULT, 93.50, 10, 1),
	(DEFAULT, 76.25, 11, 2),
	(DEFAULT, 85.75, 12, 3),
	(DEFAULT, 88.00, 13, 4),
	(DEFAULT, 90.25, 14, 4),
	(DEFAULT, 82.50, 15, 5),
	(DEFAULT, 80.00, 15, 1);
    
#Consultas Básicas:
#-Quais são os nomes dos estudantes e suas datas de nascimento?
#-Liste todos os cursos com seus respectivos anos e cargas horárias.
#-Quais estudantes estão matriculados em mais de um curso?
#-Liste os cursos que têm uma carga horária superior a 50 horas.
#-Quais estudantes nasceram após o ano 2000?

SELECT nome_estudante, data_nascimento FROM estudantes;

SELECT nome_curso, ano, carga_horaria FROM cursos;
    
SELECT e.nome_estudante, COUNT(eac.id_estudante) FROM estudante_assiste_curso eac
JOIN estudantes e
ON eac.id_estudante = e.id_estudante
GROUP BY eac.id_estudante
ORDER BY COUNT(eac.id_estudante) DESC;

SELECT * FROM cursos
WHERE carga_horaria > 50;

SELECT * FROM estudantes
WHERE data_nascimento > '2000-01-01';
    
#Consultas sobre Notas
#-Quais são as notas de todos os estudantes no curso 'Introdução à Programação'?
#-Liste os estudantes que têm uma nota maior que 85 em qualquer curso.
#-Quais são os cursos e as respectivas notas dos estudantes com o nome 'Ana Clara'?
#-Quais são os nomes dos estudantes que têm a maior nota em cada curso?
#-Qual é a média das notas dos estudantes no curso 'Banco de Dados'?

SELECT e.nome_estudante, c.nome_curso, n.nota FROM notas n
JOIN cursos c
ON n.id_curso = c.id_curso
JOIN estudantes e
ON n.id_estudante = e.id_estudante
HAVING c.nome_curso = 'Introdução à Programação';

SELECT e.nome_estudante, c.nome_curso, n.nota FROM notas n
JOIN estudantes e
ON n.id_estudante = e.id_estudante
JOIN cursos c
ON n.id_curso = c.id_curso
HAVING n.nota > 85;

SELECT e.id_estudante, e.nome_estudante, c.nome_curso, n.nota FROM estudantes e
JOIN notas n
ON e.id_estudante = n.id_estudante
JOIN cursos c
ON n.id_curso = c.id_curso
HAVING e.nome_estudante = 'Ana Clara';

SELECT e.nome_estudante, c.nome_curso, n.nota FROM estudantes e
JOIN notas n
ON e.id_estudante = n.id_estudante
JOIN cursos c
ON n.id_curso = c.id_curso
ORDER BY c.nome_curso, n.nota DESC;

SELECT c.nome_curso, AVG(n.nota) FROM cursos c
JOIN notas n
ON c.id_curso = n.id_curso
GROUP BY c.nome_curso
HAVING c.nome_curso = 'Banco de dados';

#Outras consultas
#-Qual é a nota média de cada estudante em todos os cursos que ele está matriculado?
#-Quais são os cursos que têm a maior média de notas?
#-Quais são os estudantes que têm todas as notas acima de 80?
#-Quais são os estudantes que têm a menor nota em cada curso e quais são essas notas?
#-Liste os professores, os cursos que eles lecionam e a média das notas dos estudantes nesses cursos.

SELECT e.nome_estudante, AVG(n.nota) from notas n
JOIN estudantes e
ON n.id_estudante = e.id_estudante
GROUP BY e.nome_estudante;

SELECT c.nome_curso, AVG(n.nota) FROM notas n
JOIN cursos c
ON n.id_curso = c.id_curso
GROUP BY c.nome_curso
ORDER BY AVG(n.nota) DESC;

SELECT e.nome_estudante, n.nota FROM notas n
JOIN estudantes e
ON n.id_estudante = e.id_estudante
HAVING n.nota > 80;

SELECT e.nome_estudante, c.nome_curso, n.nota
FROM (
    SELECT id_curso, MIN(nota) AS menor_nota
    FROM notas
    GROUP BY id_curso
) min_notas
JOIN notas n ON min_notas.id_curso = n.id_curso AND min_notas.menor_nota = n.nota
JOIN estudantes e ON n.id_estudante = e.id_estudante
JOIN cursos c ON n.id_curso = c.id_curso;

SELECT p.nome, c.nome_curso, AVG(n.nota) AS media_notas
FROM professores p
JOIN cursos c ON p.id_curso = c.id_curso
JOIN notas n ON c.id_curso = n.id_curso
GROUP BY p.nome, c.nome_curso;
