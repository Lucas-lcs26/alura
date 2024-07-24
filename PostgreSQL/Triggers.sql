/*
* Inserir instrutores (com salários).
* Se o salário for maior do que a média, salvar um log
* Salvar outro log dizendo que fulano recebe mais do que x% da grade de instrutores. 
*/	

CREATE TABLE log_instrutores(
	id SERIAL PRIMARY KEY,
	informacao VARCHAR(255),
	momento_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
drop function cria_instrutor;
CREATE OR REPLACE FUNCTION cria_instrutor() RETURNS TRIGGER AS $$
	DECLARE
	media_salarial INTEGER;
	instrutores_recebem_menos INTEGER DEFAULT 0;
	total_instrutores INTEGER DEFAULT 0;
	salario DECIMAL;
	percentual DECIMAL (5,2);
	BEGIN
		SELECT AVG(instrutor.salario) INTO media_salarial FROM instrutor WHERE id <> NEW.id;
	
		IF NEW.salario > media_salarial THEN
			INSERT INTO log_instrutores(informacao) VALUES 	(NEW.nome || ' recebe acima da média');
		END IF;

		FOR salario IN SELECT instrutor.salario FROM instrutor WHERE id <> NEW.id LOOP
			total_instrutores := total_instrutores + 1;

			IF NEW.salario > salario THEN 
				instrutores_recebem_menos := instrutores_recebem_menos +1;
			END IF;
		END LOOP;
		
		percentual = instrutores_recebem_menos::DECIMAL / total_instrutores::DECIMAL * 100;

		INSERT INTO log_instrutores(informacao)
			VALUES(NEW.nome|| ' recebe mais do que ' || percentual || '% da grade de instrutores');
		
		RETURN NEW;
	END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER cria_log_instrutores AFTER INSERT ON instrutor
	FOR EACH ROW EXECUTE FUNCTION cria_instrutor();

SELECT * FROM instrutor;

SELECT cria_instrutor('Fulana de Tal', 1200);

SELECT * FROM log_instrutores;

INSERT INTO instrutor(nome, salario) VALUES('Outra pessoa de novo', 600);
