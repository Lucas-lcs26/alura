-- CRIAR UMA FUNÇÃO QUE RECEBE PARAMETROS E JA DEFINE A SAIDA COM 'OUT' ... NÃO PRECISA USAR O RETURNS
CREATE FUNCTION soma_e_produto(numero_1 INTEGER, numero_2 INTEGER,OUT soma INTEGER, OUT produto INTEGER) AS $$
    SELECT numero_1 + numero_2 AS soma, numero_1 * numero_2 AS produto;
$$ LANGUAGE SQL

-- UMA OUTRA FORMA DE FAZER, UTILIZANDO O RETURNS, MAS PRECISA CRIAR UM TYPE:

CREATE TYPE dois_valores AS (soma INTEGER, produto INTEGER);

CREATE FUNCTION soma_e_produto(numero_1 INTEGER, numero_2 INTEGER) RETURNS dois_valores AS $$
    SELECT numero_1 + numero_2 AS soma, numero_1 * numero_2 AS produto;
$$ LANGUAGE SQL

drop function soma_e_produto;

SELECT * FROM soma_e_produto(3,3);