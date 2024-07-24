CREATE TABLE instrutor(
	id SERIAL PRIMARY KEY,
	nome VARCHAR (255) NOT NULL,
	salario DECIMAL(10,2)
);

INSERT INTO instrutor (nome, salario) VALUES ('Vinicius Dias', 100);
INSERT INTO instrutor (nome, salario) VALUES ('Diogo MAscarenhas', 200);
INSERT INTO instrutor (nome, salario) VALUES ('Nico Steppat', 300);
INSERT INTO instrutor (nome, salario) VALUES ('Juliana', 400);
INSERT INTO instrutor (nome, salario) VALUES ('Priscila', 500);

CREATE FUNCTION dobro_salario_instrutor (instrutor) RETURNS DECIMAL AS $$ 
	SELECT $1.salario *2 AS dobro;
$$ LANGUAGE SQL;

SELECT nome, dobro_salario_instrutor(instrutor.*) FROM instrutor;

CREATE OR REPLACE FUNCTION criar_instrutor_falso() RETURNS instrutor AS $$
	DECLARE
		retorno instrutor;
	BEGIN
		SELECT 22, 'Nome falso', 200::DECIMAL INTO retorno;
		RETURN retorno;
		
	END;
$$ LANGUAGE plpgsql;

SELECT * FROM criar_instrutor_falso();

CREATE FUNCTION instrutores_bem_pagos(valor_salario DECIMAL) RETURNS SETOF instrutor AS $$ 
	SELECT * FROM instrutor WHERE salario > valor_salario;
$$ LANGUAGE SQL

-- OUTRA FORMA DE FAZER A FUNÇÃO USANDO RETUNS TABLE (MENOS USADO, POIS A TABELA JA POSSUI OS PARAMETROS DEFINIDOS)

CREATE FUNCTION instrutores_bem_pagos(valor_salario DECIMAL) RETURNS TABLE (id INTEGER, nome VARCHAR, salario DECIMAL) AS $$ 
	SELECT * FROM instrutor WHERE salario > valor_salario;
$$ LANGUAGE SQL

-- MAIS UMA FORMA DE FAZER , UTILIZANDO RECORD

CREATE FUNCTION instrutores_bem_pagos(valor_salario DECIMAL, OUT nome VARCHAR, OUT salario DECIMAL) RETURNS SETOF record AS $$ 
	SELECT nome, salario FROM instrutor WHERE salario > valor_salario;
$$ LANGUAGE SQL


SELECT * FROM instrutores_bem_pagos(300); 

--____________________________

DROP FUNCTION instrutores_bem_pagos;
CREATE FUNCTION instrutores_bem_pagos(valor_salario DECIMAL) RETURNS SETOF instrutor AS $$ 
	BEGIN
		RETURN QUERY SELECT * FROM instrutor WHERE salario > valor_salario;
	END;
$$ LANGUAGE plpgsql;


SELECT * FROM instrutores_bem_pagos(300); 