-- ========================================================
-- SCRIPT DE CRIAÇÃO E MANIPULAÇÃO - ALVEJO SHOP
-- Autor: Davi Alves Araujo
-- Disciplina: Banco de Dados
-- ========================================================

-- 1. CRIAÇÃO DAS TABELAS (DDL)
-- ========================================================

CREATE TABLE CLIENTE (
    ID_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(14) NOT NULL UNIQUE,
    Email VARCHAR(100),
    Telefone VARCHAR(20)
);

CREATE TABLE CATEGORIA (
    ID_Categoria INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Categoria VARCHAR(50) NOT NULL
);

CREATE TABLE PRODUTO (
    ID_Produto INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Preco DECIMAL(10,2) NOT NULL,
    ID_Categoria INT,
    FOREIGN KEY (ID_Categoria) REFERENCES CATEGORIA(ID_Categoria)
);

CREATE TABLE PEDIDO (
    ID_Pedido INT PRIMARY KEY AUTO_INCREMENT,
    Data_Pedido DATE NOT NULL,
    Valor_Total DECIMAL(10,2),
    ID_Cliente INT,
    FOREIGN KEY (ID_Cliente) REFERENCES CLIENTE(ID_Cliente)
);

CREATE TABLE ITEM_PEDIDO (
    ID_Pedido INT,
    ID_Produto INT,
    Quantidade INT NOT NULL,
    PRIMARY KEY (ID_Pedido, ID_Produto),
    FOREIGN KEY (ID_Pedido) REFERENCES PEDIDO(ID_Pedido),
    FOREIGN KEY (ID_Produto) REFERENCES PRODUTO(ID_Produto)
);

-- ========================================================
-- 2. INSERÇÃO DE DADOS (INSERT)
-- ========================================================

-- Inserindo Clientes
INSERT INTO CLIENTE (Nome, CPF, Email, Telefone) VALUES 
('Davi Alves', '123.456.789-00', 'davi@alvejoshop.com', '(11) 99999-0001'),
('Lucas Socio', '987.654.321-11', 'lucas@alvejoshop.com', '(11) 99999-0002'),
('Cliente Teste', '111.222.333-44', 'teste@email.com', '(21) 98888-7777');

-- Inserindo Categorias
INSERT INTO CATEGORIA (Nome_Categoria) VALUES 
('Ferramentas'), 
('Eletronicos'), 
('Jardim'),
('Acessorios');

-- Inserindo Produtos (Lavadoras, Fones, etc.)
INSERT INTO PRODUTO (Nome, Preco, ID_Categoria) VALUES 
('Lavadora Alta Pressão', 899.90, 1),
('Furadeira Impacto', 250.00, 1),
('Fone de Ouvido Bluetooth', 150.00, 2),
('Mangueira Reforçada', 75.50, 3),
('Suporte de Celular', 25.00, 4);

-- Inserindo Pedidos
INSERT INTO PEDIDO (Data_Pedido, Valor_Total, ID_Cliente) VALUES 
('2025-11-01', 1149.90, 1), -- Pedido do Davi
('2025-11-05', 150.00, 2),  -- Pedido do Lucas
('2025-11-10', 75.50, 3);   -- Pedido do Cliente Teste

-- Inserindo Itens dos Pedidos (O que cada um comprou)
INSERT INTO ITEM_PEDIDO (ID_Pedido, ID_Produto, Quantidade) VALUES 
(1, 1, 1), -- Davi comprou 1 Lavadora
(1, 2, 1), -- Davi comprou 1 Furadeira
(2, 3, 1), -- Lucas comprou 1 Fone
(3, 4, 1); -- Cliente Teste comprou 1 Mangueira

-- ========================================================
-- 3. CONSULTAS (SELECT)
-- ========================================================

-- Consulta 1: Listar todos os produtos e suas categorias (JOIN)
SELECT p.Nome AS Produto, p.Preco, c.Nome_Categoria 
FROM PRODUTO p
JOIN CATEGORIA c ON p.ID_Categoria = c.ID_Categoria;

-- Consulta 2: Listar pedidos feitos pelo cliente "Davi Alves" (WHERE + JOIN)
SELECT pd.ID_Pedido, pd.Data_Pedido, pd.Valor_Total
FROM PEDIDO pd
JOIN CLIENTE cl ON pd.ID_Cliente = cl.ID_Cliente
WHERE cl.Nome LIKE 'Davi%';

-- Consulta 3: Listar produtos mais caros que R$ 200,00 (WHERE + ORDER BY)
SELECT Nome, Preco 
FROM PRODUTO 
WHERE Preco > 200.00 
ORDER BY Preco DESC;

-- ========================================================
-- 4. ATUALIZAÇÃO E EXCLUSÃO (UPDATE e DELETE)
-- ========================================================

-- UPDATE 1: Aumentar o preço da Furadeira em 10%
UPDATE PRODUTO SET Preco = Preco * 1.10 WHERE ID_Produto = 2;

-- UPDATE 2: Corrigir o telefone do Lucas
UPDATE CLIENTE SET Telefone = '(11) 97777-6666' WHERE Nome = 'Lucas Socio';

-- UPDATE 3: Atualizar a data de um pedido específico
UPDATE PEDIDO SET Data_Pedido = '2025-11-02' WHERE ID_Pedido = 1;

-- DELETE 1: Remover o produto "Suporte de Celular" (que não foi vendido ainda)
DELETE FROM PRODUTO WHERE Nome = 'Suporte de Celular';

-- DELETE 2: Remover a categoria "Acessorios" (que agora está vazia)
DELETE FROM CATEGORIA WHERE Nome_Categoria = 'Acessorios';

-- DELETE 3: Remover o pedido do "Cliente Teste" (Primeiro remove os itens, depois o pedido)
DELETE FROM ITEM_PEDIDO WHERE ID_Pedido = 3;
DELETE FROM PEDIDO WHERE ID_Pedido = 3;
