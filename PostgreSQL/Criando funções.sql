CREATE FUNCTION primeira_funcao() RETURNS INTEGER AS '
    SELECT (5-3) * 2
' LANGUAGE SQL;

SELECT primeira_funcao() AS numero;

CREATE FUNCTION soma_dois_numeros(numero_1 INTEGER, numero_2 INTEGER) RETURNS INTEGER AS '
	SELECT numero_1 + numero_2;
' LANGUAGE SQL;

DROP FUNCTION soma_dois_numeros

CREATE FUNCTION soma_dois_numeros(INTEGER, INTEGER) RETURNS INTEGER AS '
	SELECT $1 + $2;
' LANGUAGE SQL;

SELECT soma_dois_numeros(3, 17);

CREATE TABLE a (nome VARCHAR(255) NOT NULL)
CREATE OR REPLACE FUNCTION cria_a(nome VARCHAR) RETURNS VARCHAR AS '
	INSERT INTO a (nome) VALUES (cria_a.nome);
	SELECT nome;
'LANGUAGE SQL;

SELECT cria_a('Vinicius Dias')


DROP FUNCTION cria_a;
CREATE OR REPLACE FUNCTION cria_a(nome VARCHAR) RETURNS void AS $$
	BEGIN
		INSERT INTO a (nome) VALUES ('Patrícia');
		END
$$ LANGUAGE plpgsql;

SELECT cria_a('Vinicius Dias');

SELECT * FROM a;


