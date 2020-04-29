-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 26-Abr-2020 às 02:33
-- Versão do servidor: 10.3.22-MariaDB
-- versão do PHP: 7.3.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `cinema`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `filmes`
--

CREATE TABLE `filmes` (
  `id_filme` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `ano` int(4) NOT NULL,
  `diretor` varchar(100) NOT NULL,
  `genero` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `filmes`
--

INSERT INTO `filmes` (`id_filme`, `titulo`, `ano`, `diretor`, `genero`) VALUES
(1, 'Limite', 1931, 'Mário Peixoto', 'Drama'),
(2, 'Deus e o Diabo na Terra do Sol', 1964, 'Glauber Rocha', 'Drama'),
(3, 'Vidas Secas', 1963, 'Nelson Pereira dos Santos', 'Drama'),
(4, 'Cabra Marcado para Morrer', 1984, 'Eduardo Coutinho', 'Documentário'),
(5, 'Terra em Transe', 1967, 'Glauber Rocha', 'Drama'),
(6, 'O Bandido da Luz Vermelha', 1968, 'Rogério Sganzerla', 'Policial'),
(7, 'São Paulo, Sociedade Anônima', 1965, 'Luís Sérgio Person', 'Drama'),
(8, 'Cidade de Deus', 2002, 'Fernando Meirelles e Kátia Lund', 'Drama, Ação'),
(9, 'O Pagador de Promessas', 1962, 'Anselmo Duarte', 'Drama'),
(10, 'Macunaíma', 1969, 'Joaquim Pedro de Andrade', 'Comédia'),
(11, 'Central do Brasil', 1998, 'Walter Salles', 'Drama'),
(12, 'Pixote, a Lei do Mais Fraco', 1981, 'Hector Babenco', 'Drama');

-- --------------------------------------------------------

--
-- Estrutura da tabela `votacao`
--

CREATE TABLE `votacao` (
  `id_voto` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_filme` int(11) NOT NULL,
  `voto` int(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `votacao`
--

INSERT INTO `votacao` (`id_voto`, `id_usuario`, `id_filme`, `voto`) VALUES
(1, 31, 2, 4),
(2, 123, 8, 5),
(3, 78, 5, 3),
(4, 31, 11, 5),
(5, 31, 7, 4),
(6, 59, 8, 5),
(7, 123, 6, 2),
(8, 86, 2, 5),
(9, 144, 7, 1);

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `filmes`
--
ALTER TABLE `filmes`
  ADD PRIMARY KEY (`id_filme`);

--
-- Índices para tabela `votacao`
--
ALTER TABLE `votacao`
  ADD PRIMARY KEY (`id_voto`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `filmes`
--
ALTER TABLE `filmes`
  MODIFY `id_filme` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `votacao`
--
ALTER TABLE `votacao`
  MODIFY `id_voto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
