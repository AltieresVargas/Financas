
-- -----------------------------------------------------
-- Table  Financas . tb_clientes 
-- -----------------------------------------------------
CREATE TABLE  tb_clientes  (
   id_cliente  INT NOT NULL ,
   str_nome  VARCHAR(100)  NOT NULL,
   str_cpf  VARCHAR(14)  NOT NULL,
   str_telefone  VARCHAR(20)  ,
   dt_nascimento  DATE  ,
   dt_cadastro  DATE  ,
   dt_alterado  DATE  ,
   str_endereco  VARCHAR(100)  ,
   str_num  VARCHAR(10)  ,
   str_complemento  VARCHAR(25)  ,
   str_cep  VARCHAR(11)  ,
   str_bairro  VARCHAR(45)  ,
   str_cidade  VARCHAR(45)  ,
   str_uf  CHAR(2)  ,
   str_obs  VARCHAR(255),
   PRIMARY KEY (id_cliente)
);


----------------------------------------------------
-- Table  Financas . tb_operacao_financeira 
-- -----------------------------------------------------
CREATE TABLE  tb_operacao_financeira  (
   id_operacao  INT NOT NULL,
   cli_id_cliente  INT NOT NULL ,
   str_tipo_operacao  VARCHAR(45)  ,
   str_num_doc   VARCHAR(45)  ,
   str_descricao  VARCHAR(100)  ,
   dt_operacao  DATE  ,
   dt_alterado  DATE  ,
   dt_cadastro  DATE  ,
   fl_valor  decimal(14,2),
   fl_saldo  decimal(14,2),
   str_obs  VARCHAR(255), 
   PRIMARY KEY (id_operacao),
   FOREIGN KEY (cli_id_cliente) REFERENCES tb_clientes (id_cliente)
);

