-- =====================================================
-- Script de Criação do Banco de Dados
-- Projeto: Banco de Dados Cursos Profissionalizantes
-- Database: dbtechcourses
-- =====================================================

-- Remove o banco de dados se já existir (cuidado em produção!)
DROP DATABASE IF EXISTS dbtechcourses;

-- Cria o banco de dados
CREATE DATABASE dbtechcourses
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- Seleciona o banco de dados para uso
USE dbtechcourses;

-- Exibe mensagem de confirmação
SELECT 'Banco de dados dbtechcourses criado com sucesso!' AS Status;

