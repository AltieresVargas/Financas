CREATE DATABASE  IF NOT EXISTS `financas` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `financas`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: financas
-- ------------------------------------------------------
-- Server version	5.6.51-log


--
-- Table structure for table `tb_clientes`
--

DROP TABLE IF EXISTS `tb_clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_clientes` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `str_nome` varchar(100) NOT NULL,
  `str_cpf` varchar(14) NOT NULL,
  `str_telefone` varchar(20) DEFAULT NULL,
  `dt_nascimento` date DEFAULT NULL,
  `dt_cadastro` date DEFAULT NULL,
  `dt_alterado` date DEFAULT NULL,
  `str_endereco` varchar(100) DEFAULT NULL,
  `str_num` varchar(10) DEFAULT NULL,
  `str_complemento` varchar(25) DEFAULT NULL,
  `str_cep` varchar(11) DEFAULT NULL,
  `str_bairro` varchar(45) DEFAULT NULL,
  `str_cidade` varchar(45) DEFAULT NULL,
  `str_uf` char(2) DEFAULT NULL,
  `str_obs` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_operacao_financeira`
--

DROP TABLE IF EXISTS `tb_operacao_financeira`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_operacao_financeira` (
  `id_operacao` int(11) NOT NULL AUTO_INCREMENT,
  `cli_id_cliente` int(11) NOT NULL,
  `str_tipo_operacao` varchar(45) NOT NULL,
  `str_num_doc` varchar(45) DEFAULT NULL,
  `str_descricao` varchar(100) DEFAULT NULL,
  `dt_operacao` date DEFAULT NULL,
  `dt_alterado` date DEFAULT NULL,
  `dt_cadastro` date DEFAULT NULL,
  `fl_valor` decimal(14,2) DEFAULT NULL,
  `fl_saldo` decimal(14,2) DEFAULT NULL,
  `str_obs` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_operacao`),
  UNIQUE KEY `id_deposito_UNIQUE` (`id_operacao`),
  KEY `id_Cliente_idx` (`cli_id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


-- Dump completed on 2022-12-01 12:41:06
