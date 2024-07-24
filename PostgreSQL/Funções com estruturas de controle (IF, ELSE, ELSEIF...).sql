CREATE FUNCTION salario_ok(instrutor instrutor) RETURNS VARCHAR AS $$
	BEGIN
		-- se o salário do instrutor for mair que 200, está ok, pode aumentar
		IF instrutor.salario >200 THEN
			RETURN 'salário ok';
		ELSE 
			RETURN 'salário pode aumentar';
		END IF;
	END;
$$ LANGUAGE plpgsql;

-- outra forma de fazer 

drop function salario_ok;
CREATE FUNCTION salario_ok(id_instrutor INTEGER) RETURNS VARCHAR AS $$
	DECLARE
			instrutor instrutor;
	BEGIN
		SELECT * FROM instrutor WHERE id = id_instrutor INTO  instrutor;
		
		-- se o salário do instrutor for mair que 200, está ok, pode aumentar
		IF instrutor.salario >200 THEN
			RETURN 'salário ok';
		ELSE 
			RETURN 'salário pode aumentar';
		END IF;
	END;
$$ LANGUAGE plpgsql;

SELECT nome, salario_ok(instrutor.id) FROM  instrutor;

-- qual forma é mais rápida?? a primeira é mais performatica pois possui menos comandos. Percebe-se que na segunda temos uma consulta dentro da função criada e atribui essa consulta a uma variavel. Enquanto na primeira há apenas não há esses comandos. 

--_________________________________________________

CREATE OR REPLACE FUNCTION salario_ok(id_instrutor INTEGER) RETURNS VARCHAR AS $$
	DECLARE
			instrutor instrutor;
	BEGIN
		SELECT * FROM instrutor WHERE id = id_instrutor INTO  instrutor;
		
		-- se o salário do instrutor for mair que 200, está ok, pode aumentar
		IF instrutor.salario >300 THEN
			RETURN 'salário ok';
		ELSEIF instrutor.salario = 300 THEN
			RETURN 'Salário pode aumentar';
		ELSE
			RETURN 'Salário está defasado';
		END IF;
		CASE
			WHEN instrutor.salario = 100 THEN
				RETURN 'Salário muito baixo';
			WHEN instrutor.salario = 200 THEN
				RETURN 'Salário baixo';
			WHEN instrutor.salario = 300 THEN
				RETURN 'Salário ok';		
			ELSE 
				RETURN 'Salário ótimo';
		END CASE;
	END;
$$ LANGUAGE plpgsql;

-- QUANDO TEMOS MUITOS IFs COMO FAZER???

CREATE OR REPLACE FUNCTION salario_ok(id_instrutor INTEGER) RETURNS VARCHAR AS $$
	DECLARE
			instrutor instrutor;
	BEGIN
		SELECT * FROM instrutor WHERE id = id_instrutor INTO  instrutor;
		
		-- se o salário do instrutor for mair que 200, está ok, pode aumentar
		/*IF instrutor.salario >300 THEN
			RETURN 'salário ok';
		ELSEIF instrutor.salario = 300 THEN
			RETURN 'Salário pode aumentar';
		ELSE
			RETURN 'Salário está defasado';
		END IF; */
		CASE
			WHEN instrutor.salario = 100 THEN
				RETURN 'Salário muito baixo';
			WHEN instrutor.salario = 200 THEN
				RETURN 'Salário baixo';
			WHEN instrutor.salario = 300 THEN
				RETURN 'Salário ok';		
			ELSE 
				RETURN 'Salário ótimo';
		END CASE;
	END;
$$ LANGUAGE plpgsql;

-- uma forma mais limpa

CREATE OR REPLACE FUNCTION salario_ok(id_instrutor INTEGER) RETURNS VARCHAR AS $$
	DECLARE
			instrutor instrutor;
	BEGIN
		SELECT * FROM instrutor WHERE id = id_instrutor INTO  instrutor;
		
		CASE instrutor.salario 
			WHEN 100 THEN
				RETURN 'Salário muito baixo';
			WHEN 200 THEN
				RETURN 'Salário baixo';
			WHEN 300 THEN
				RETURN 'Salário ok';		
			ELSE 
				RETURN 'Salário ótimo';
		END CASE;
	END;
$$ LANGUAGE plpgsql;

SELECT nome, salario_ok(instrutor.id) FROM  instrutor;

-- ESTRUTURAS DE REPETIÇÃO
drop function tabuada
CREATE OR REPLACE FUNCTION tabuada(numero INTEGER) RETURNS SETOF VARCHAR AS $$
	DECLARE
		multiplicador INTEGER DEFAULT 1;
	BEGIN
		-- multiplicador que começa com 1 e vai ate <10
		--número * muçtiplicador
		-- multiplicador := multiplicador +1
		LOOP
			RETURN NEXT numero || ' x ' || multiplicador || ' = ' || numero * multiplicador;
			multiplicador := multiplicador +1;
			EXIT WHEN multiplicador = 10;
		END LOOP;
	END;
$$ LANGUAGE plpgsql;

-- USANDO WHILE ANTES DO LOOP, PARA SAIR DO LOOP

CREATE OR REPLACE FUNCTION tabuada(numero INTEGER) RETURNS SETOF VARCHAR AS $$
	DECLARE
		multiplicador INTEGER DEFAULT 1;
	BEGIN
		WHILE multiplicador < 10 LOOP
			RETURN NEXT numero || ' x ' || multiplicador || ' = ' || numero * multiplicador;
			multiplicador := multiplicador +1;
		END LOOP;
	END;
$$ LANGUAGE plpgsql;

-- USANDO O FOR , FICA MUITO MAIS SIMPLES

CREATE OR REPLACE FUNCTION tabuada(numero INTEGER) RETURNS SETOF VARCHAR AS $$
	BEGIN
		FOR multiplicador in 1..9 LOOP
			RETURN NEXT numero || ' x ' || multiplicador || ' = ' || numero * multiplicador;
			multiplicador := multiplicador +1;
		END LOOP;
	END;
$$ LANGUAGE plpgsql;

SELECT tabuada(9);

CREATE OR REPLACE FUNCTION instrutor_com_salario(OUT nome VARCHAR, OUT salario_ok VARCHAR) RETURNS SETOF record AS $$
	DECLARE
		instrutor instrutor;
	BEGIN
		FOR instrutor IN SELECT * FROM instrutor LOOP
			nome := instrutor.nome;
			salario_ok := salario_ok(instrutor.id);
			RETURN NEXT;

		END LOOP;
	END
$$ LANGUAGE plpgsql;

SELECT * FROM instrutor_com_salario();

