CREATE SCHEMA teste;

CREATE TABLE teste.curso_programacao (
	id_curso INTEGER PRIMARY KEY,
	nome_curso VARCHAR(255) NOT NULL
);

INSERT INTO teste.curso_programacao 
Select academico.curso.id,
	   academico.curso.nome
FROM academico.curso
WHERE categoria_id = 2

SELECT * FROM teste.curso_programacao;

UPDATE teste.curso_programacao SET nome_curso = nome
  FROM academico.curso WHERE teste.curso_programacao.id_curso = academico.curso.id
   AND academico.curso.id < 10;
 
BEGIN;
DELETE FROM teste.curso_programacao 

ROLLBACK

BEGIN;
DELETE FROM teste.curso_programacao WHERE id_curso = 60;
COMMIT;
SELECT * FROM teste.curso_programacao;

SELECT * FROM academico.curso ORDER BY 1;

UPDATE academico.curso SET nome = 'C++ Básico' WHERE id = 6

