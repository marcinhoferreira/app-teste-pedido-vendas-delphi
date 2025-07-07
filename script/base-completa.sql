CREATE DATABASE teste_wk;

USE teste_wk;

CREATE TABLE clientes (
   codigo            INT UNSIGNED AUTO_INCREMENT NOT NULL,
   nome              VARCHAR(255) NOT NULL,
   cidade            VARCHAR(255) NOT NULL,
   uf                VARCHAR(2) NOT NULL,
   PRIMARY KEY (codigo)   
);

CREATE TABLE produtos (
   codigo            INT UNSIGNED AUTO_INCREMENT NOT NULL,
   descricao         VARCHAR(255) NOT NULL,
   preco_venda       DOUBLE(15, 2) NOT NULL DEFAULT 0,
   PRIMARY KEY (codigo)
);

CREATE TABLE pedidos (
   numero            INT UNSIGNED AUTO_INCREMENT NOT NULL,
   data_emissao      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
   codigo_cliente    INT UNSIGNED NOT NULL,
   valor_total       DOUBLE(15, 2) DEFAULT 0,
   PRIMARY KEY (numero),
   FOREIGN KEY (codigo_cliente) REFERENCES clientes (codigo)
);

ALTER TABLE pedidos
   ADD CONSTRAINT fk_pedidos_cliente FOREIGN KEY (codigo_cliente) REFERENCES clientes (codigo);
   
CREATE TABLE itens_pedido (
   id                INT UNSIGNED AUTO_INCREMENT NOT NULL,
   numero_pedido     INT UNSIGNED NOT NULL,
   codigo_produto    INT UNSIGNED NOT NULL,
   quantidade        INT UNSIGNED NOT NULL DEFAULT 0,
   valor_unitario    DOUBLE(15, 2) NOT NULL DEFAULT 0,
   valor_total       DOUBLE(15, 2) NOT NULL DEFAULT 0,
   PRIMARY KEY (id),
   FOREIGN KEY (codigo_produto) REFERENCES produtos (codigo)
);

ALTER TABLE itens_pedido
   ADD CONSTRAINT fk_itens_pedido_pedido FOREIGN KEY (numero_pedido) REFERENCES pedidos (numero);

ALTER TABLE itens_pedido
   ADD CONSTRAINT fk_itens_pedido_produto FOREIGN KEY (codigo_produto) REFERENCES produtos (codigo);

INSERT INTO clientes
   (nome, cidade, uf)
VALUES
   ('Ana Paula Silva', 'São Paulo', 'SP'),
   ('Carlos Henrique Souza', 'Rio de Janeiro', 'RJ'),
   ('Mariana Oliveira', 'Belo Horizonte', 'MG'),
   ('João Pedro Santos', 'Curitiba', 'PR'),
   ('Fernanda Lima', 'Porto Alegre', 'RS'),
   ('Lucas Almeida', 'Brasília', 'DF'),
   ('Juliana Rocha', 'Salvador', 'BA'),
   ('Felipe Costa', 'Fortaleza', 'CE'),
   ('Amanda Martins', 'Manaus', 'AM'),
   ('Bruno Teixeira', 'Recife', 'PE'),
   ('Patrícia Dias', 'Natal', 'RN'),
   ('Rodrigo Ramos', 'Campinas', 'SP'),
   ('Larissa Ferreira', 'Florianópolis', 'SC'),
   ('Gabriel Mendes', 'Goiânia', 'GO'),
   ('Renata Barbosa', 'João Pessoa', 'PB'),
   ('André Nogueira', 'São Luís', 'MA'),
   ('Vanessa Castro', 'Teresina', 'PI'),
   ('Eduardo Pinto', 'Campo Grande', 'MS'),
   ('Beatriz Carvalho', 'Maceió', 'AL'),
   ('Thiago Moreira', 'Aracaju', 'SE');

INSERT INTO produtos
   (descricao, preco_venda)
VALUES
   ('Arroz 5kg', 22.90),
   ('Feijão Carioca 1kg', 7.50),
   ('Macarrão Espaguete 500g', 4.20),
   ('Óleo de Soja 900ml', 6.99),
   ('Açúcar Refinado 1kg', 4.10),
   ('Sal 1kg', 2.50),
   ('Farinha de Trigo 1kg', 5.30),
   ('Café Torrado e Moído 500g', 15.80),
   ('Leite Integral 1L', 4.70),
   ('Achocolatado em Pó 400g', 8.90),
   ('Biscoito Recheado 130g', 2.99),
   ('Refrigerante 2L', 6.49),
   ('Detergente Líquido 500ml', 2.30),
   ('Sabão em Pó 1kg', 8.75),
   ('Desinfetante 1L', 4.40),
   ('Shampoo 350ml', 12.90),
   ('Sabonete 90g', 1.80),
   ('Papel Higiênico 4 rolos', 5.99),
   ('Creme Dental 90g', 3.50),
   ('Escova de Dente', 4.20);