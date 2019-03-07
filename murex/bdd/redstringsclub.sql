-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  ven. 08 mars 2019 à 00:13
-- Version du serveur :  10.1.38-MariaDB
-- Version de PHP :  7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `redstringsclub`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `closeAdventure` ()  NO SQL
    DETERMINISTIC
BEGIN
    UPDATE launchadventure SET inProgress = 0 WHERE inProgress = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllQuestions` ()  NO SQL
    DETERMINISTIC
BEGIN
    SELECT libelle, 
(SELECT libelle FROM answer where num_choice = (SELECT num_choice FROM event WHERE nb_vote = (SELECT MAX(nb_vote) FROM event WHERE l.id_launch)) and id_question = l.id_question) as libelleAnswer, 



(SELECT MAX(nb_vote) FROM event natural join launch WHERE id_launch = l.id_launch) as nb_vote FROM launch l natural join question WHERE inProgress = 0 AND id_launchAdventure = (Select id_launchAdventure FROM launchadventure WHERE inProgress = 1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getResultsVote` (IN `_id` INT)  NO SQL
    DETERMINISTIC
BEGIN
    SELECT * FROM event WHERE id_launch = _id;
END$$

--
-- Fonctions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `isAdventure` () RETURNS TINYINT(1) NO SQL
    DETERMINISTIC
BEGIN
    DECLARE lvl integer(1);
    SELECT IF(inProgress = 1,1,0) inProgress INTO lvl FROM launchadventure WHERE inProgress = 1;
 
 RETURN (lvl);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `isQuestion` () RETURNS TINYINT(1) NO SQL
BEGIN
    DECLARE lvl integer(1);
    SELECT IF(inProgress = 1,1,0) inProgress INTO lvl FROM launch;
 
 RETURN (lvl);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `startAdventure` (`_id` INT) RETURNS INT(11) BEGIN
    DECLARE lvl integer(11);
    INSERT INTO launchadventure SET id_adventure = _id;
 	SET lvl = LAST_INSERT_ID();
 
 RETURN (lvl);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `startQuestion` (`_idA` INT, `_idQ` INT) RETURNS INT(11) BEGIN
    DECLARE lvl integer(11);
    INSERT INTO launch SET id_launchAdventure = _idA, id_question = _idQ;
 	SET lvl = LAST_INSERT_ID();
 
 RETURN (lvl);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `adventure`
--

CREATE TABLE `adventure` (
  `id_adventure` int(11) NOT NULL,
  `libelle` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `adventure`
--

INSERT INTO `adventure` (`id_adventure`, `libelle`) VALUES
(1, 'toucher');

-- --------------------------------------------------------

--
-- Structure de la table `answer`
--

CREATE TABLE `answer` (
  `id_question` int(11) NOT NULL DEFAULT '0',
  `num_choice` int(11) NOT NULL DEFAULT '0',
  `libelle` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `answer`
--

INSERT INTO `answer` (`id_question`, `num_choice`, `libelle`) VALUES
(1, 1, 'Lièvre'),
(1, 2, 'Tortue'),
(2, 1, 'reponse test 1'),
(2, 2, 'reponse test 2');

-- --------------------------------------------------------

--
-- Structure de la table `event`
--

CREATE TABLE `event` (
  `id_event` int(11) NOT NULL,
  `id_launch` int(11) NOT NULL,
  `num_choice` int(11) NOT NULL,
  `nb_vote` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `event`
--

INSERT INTO `event` (`id_event`, `id_launch`, `num_choice`, `nb_vote`) VALUES
(3, 1, 1, 37),
(4, 1, 2, 32),
(6, 3, 1, 20),
(7, 3, 2, 10);

-- --------------------------------------------------------

--
-- Structure de la table `launch`
--

CREATE TABLE `launch` (
  `id_launch` int(11) NOT NULL,
  `id_launchAdventure` int(11) NOT NULL,
  `id_question` int(11) NOT NULL,
  `dt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `inProgress` int(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `launch`
--

INSERT INTO `launch` (`id_launch`, `id_launchAdventure`, `id_question`, `dt`, `inProgress`) VALUES
(1, 1, 1, '2019-02-20 22:12:23', 0),
(3, 1, 2, '2019-03-03 18:27:46', 0);

-- --------------------------------------------------------

--
-- Structure de la table `launchadventure`
--

CREATE TABLE `launchadventure` (
  `id_launchAdventure` int(11) NOT NULL,
  `id_adventure` int(11) NOT NULL,
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `inProgress` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `launchadventure`
--

INSERT INTO `launchadventure` (`id_launchAdventure`, `id_adventure`, `dt`, `inProgress`) VALUES
(1, 1, '2019-03-02 18:06:58', 1);

-- --------------------------------------------------------

--
-- Structure de la table `question`
--

CREATE TABLE `question` (
  `id_question` int(11) NOT NULL,
  `id_adventure` int(11) NOT NULL,
  `libelle` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `question`
--

INSERT INTO `question` (`id_question`, `id_adventure`, `libelle`) VALUES
(1, 1, 'Rien ne sert de courir, il faut partir à point. Et vous ? Êtes-vous plutôt'),
(2, 1, 'Question test');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `adventure`
--
ALTER TABLE `adventure`
  ADD PRIMARY KEY (`id_adventure`);

--
-- Index pour la table `answer`
--
ALTER TABLE `answer`
  ADD PRIMARY KEY (`id_question`,`num_choice`);

--
-- Index pour la table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`id_event`),
  ADD KEY `fk_event_launch` (`id_launch`);

--
-- Index pour la table `launch`
--
ALTER TABLE `launch`
  ADD PRIMARY KEY (`id_launch`),
  ADD KEY `fk_launch_question` (`id_question`),
  ADD KEY `fk_launch_launchadventure` (`id_launchAdventure`);

--
-- Index pour la table `launchadventure`
--
ALTER TABLE `launchadventure`
  ADD PRIMARY KEY (`id_launchAdventure`),
  ADD KEY `fk_launchAdventure_adventure` (`id_adventure`);

--
-- Index pour la table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`id_question`),
  ADD KEY `fk_adventure_question` (`id_adventure`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `adventure`
--
ALTER TABLE `adventure`
  MODIFY `id_adventure` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `event`
--
ALTER TABLE `event`
  MODIFY `id_event` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `launch`
--
ALTER TABLE `launch`
  MODIFY `id_launch` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `launchadventure`
--
ALTER TABLE `launchadventure`
  MODIFY `id_launchAdventure` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `question`
--
ALTER TABLE `question`
  MODIFY `id_question` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `answer`
--
ALTER TABLE `answer`
  ADD CONSTRAINT `fk_foreign_answer_question` FOREIGN KEY (`id_question`) REFERENCES `question` (`id_question`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `event`
--
ALTER TABLE `event`
  ADD CONSTRAINT `fk_event_launch` FOREIGN KEY (`id_launch`) REFERENCES `launch` (`id_launch`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `launch`
--
ALTER TABLE `launch`
  ADD CONSTRAINT `fk_launch_launchadventure` FOREIGN KEY (`id_launchAdventure`) REFERENCES `launchadventure` (`id_launchAdventure`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_launch_question` FOREIGN KEY (`id_question`) REFERENCES `question` (`id_question`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `launchadventure`
--
ALTER TABLE `launchadventure`
  ADD CONSTRAINT `fk_launchAdventure_adventure` FOREIGN KEY (`id_adventure`) REFERENCES `adventure` (`id_adventure`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `question`
--
ALTER TABLE `question`
  ADD CONSTRAINT `fk_adventure_question` FOREIGN KEY (`id_adventure`) REFERENCES `adventure` (`id_adventure`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
