-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3307
-- Généré le : mer. 30 août 2023 à 12:24
-- Version du serveur : 10.6.5-MariaDB
-- Version de PHP : 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `myresi_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `agence_immobilier`
--

DROP TABLE IF EXISTS `agence_immobilier`;
CREATE TABLE IF NOT EXISTS `agence_immobilier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom_entreprise` varchar(100) NOT NULL,
  `numero_immatriculation` varchar(50) NOT NULL,
  `localisation` varchar(100) NOT NULL,
  `commune` varchar(100) NOT NULL,
  `ville` varchar(100) NOT NULL,
  `numero_telephone` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `appartement`
--

DROP TABLE IF EXISTS `appartement`;
CREATE TABLE IF NOT EXISTS `appartement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `immeuble_id` int(11) NOT NULL,
  `nombre_chambres` int(11) NOT NULL,
  `salon` int(11) NOT NULL,
  `douche` int(11) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `image` blob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `immeuble_id` (`immeuble_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `connexion`
--

DROP TABLE IF EXISTS `connexion`;
CREATE TABLE IF NOT EXISTS `connexion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `utilisateur_id` int(11) DEFAULT NULL,
  `gestionnaire_immobilier_id` int(11) DEFAULT NULL,
  `locataire_id` int(11) DEFAULT NULL,
  `administrateur_id` int(11) DEFAULT NULL,
  `agence_immobiliere_id` int(11) DEFAULT NULL,
  `nom_utilisateur` varchar(50) NOT NULL,
  `mot_de_passe` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `utilisateur_id` (`utilisateur_id`),
  KEY `gestionnaire_immobilier_id` (`gestionnaire_immobilier_id`),
  KEY `locataire_id` (`locataire_id`),
  KEY `administrateur_id` (`administrateur_id`),
  KEY `agence_immobiliere_id` (`agence_immobiliere_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `demande_renovation`
--

DROP TABLE IF EXISTS `demande_renovation`;
CREATE TABLE IF NOT EXISTS `demande_renovation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `locataire_id` int(11) NOT NULL,
  `description` varchar(500) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `locataire_id` (`locataire_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `gestionnaire_agence`
--

DROP TABLE IF EXISTS `gestionnaire_agence`;
CREATE TABLE IF NOT EXISTS `gestionnaire_agence` (
  `agence_id` int(11) NOT NULL,
  `gestionnaire_id` int(11) NOT NULL,
  PRIMARY KEY (`agence_id`,`gestionnaire_id`),
  KEY `gestionnaire_id` (`gestionnaire_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `gestionnaire_immobilier`
--

DROP TABLE IF EXISTS `gestionnaire_immobilier`;
CREATE TABLE IF NOT EXISTS `gestionnaire_immobilier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `date_naissance` date NOT NULL,
  `numero_piece_identite` varchar(50) NOT NULL,
  `photo` blob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `immeuble`
--

DROP TABLE IF EXISTS `immeuble`;
CREATE TABLE IF NOT EXISTS `immeuble` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `localisation` varchar(100) NOT NULL,
  `commune` varchar(100) NOT NULL,
  `ville` varchar(100) NOT NULL,
  `nombre_appartements` int(11) NOT NULL,
  `etat` varchar(20) NOT NULL CHECK (`etat` in ('Boucle','Chambre libre')),
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `locataire`
--

DROP TABLE IF EXISTS `locataire`;
CREATE TABLE IF NOT EXISTS `locataire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `numero_piece_identite` varchar(50) NOT NULL,
  `montant_loyer` decimal(10,2) NOT NULL,
  `date_paiement` date DEFAULT NULL,
  `type_paiement` varchar(20) NOT NULL CHECK (`type_paiement` in ('MobileMoney','Wave','Espece')),
  `nombre_mois_avance` int(11) NOT NULL,
  `etat` varchar(20) NOT NULL CHECK (`etat` in ('Present','NonPresent')),
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `paiement`
--

DROP TABLE IF EXISTS `paiement`;
CREATE TABLE IF NOT EXISTS `paiement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `locataire_id` int(11) NOT NULL,
  `gestionnaire_immobilier_id` int(11) NOT NULL,
  `montant` decimal(10,2) NOT NULL,
  `date_paiement` date NOT NULL,
  `type_paiement` varchar(20) NOT NULL CHECK (`type_paiement` in ('MobileMoney','Wave','Espece')),
  PRIMARY KEY (`id`),
  KEY `locataire_id` (`locataire_id`),
  KEY `gestionnaire_immobilier_id` (`gestionnaire_immobilier_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `proprietaire`
--

DROP TABLE IF EXISTS `proprietaire`;
CREATE TABLE IF NOT EXISTS `proprietaire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `numero_telephone` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `residence_id` int(11) NOT NULL,
  `gestionnaire_immobilier_id` int(11) NOT NULL,
  `utilisateur_id` int(11) NOT NULL,
  `prix_reservation` decimal(10,2) NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `residence_id` (`residence_id`),
  KEY `gestionnaire_immobilier_id` (`gestionnaire_immobilier_id`),
  KEY `utilisateur_id` (`utilisateur_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `residence`
--

DROP TABLE IF EXISTS `residence`;
CREATE TABLE IF NOT EXISTS `residence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gestionnaire_immobilier_id` int(11) NOT NULL,
  `nombre_chambres` int(11) NOT NULL,
  `localisation` varchar(100) NOT NULL,
  `commune` varchar(100) NOT NULL,
  `ville` varchar(100) NOT NULL,
  `salon` int(11) NOT NULL,
  `douche` int(11) NOT NULL,
  `type` varchar(20) NOT NULL CHECK (`type` in ('Villa','Appartement')),
  `etat` varchar(20) NOT NULL CHECK (`etat` in ('Libre','Occupe')),
  `description` varchar(500) NOT NULL,
  `date_disponibilite` date DEFAULT NULL,
  `prix_location` int(9) NOT NULL,
  `image` blob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `gestionnaire_immobilier_id` (`gestionnaire_immobilier_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `numero_telephone` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `statut` varchar(20) NOT NULL CHECK (`statut` in ('Utilisateur','Proprietaire','GestionnaireImmobilier')),
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
