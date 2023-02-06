
CREATE SCHEMA IF NOT EXISTS `dart` DEFAULT CHARACTER SET utf8;
USE `dart`;

CREATE TABLE IF NOT EXISTS `dart`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `is_ativo` TINYINT NULL DEFAULT 1,
  `dt_criacao` datetime DEFAULT CURRENT_TIMESTAMP,
  `dt_atualizacao` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

INSERT INTO `dart`.`usuarios` (
  `nome`,
  `email`,
  `password`,
  `is_ativo`,
  `dt_criacao`) VALUES ('Isaque Paixão','isaquespx98@gmail.com','Ispx@1998',1,NOW())
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `dart`.`noticias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(255) NOT NULL,
  `descricao` LONGTEXT NOT NULL,
  `dt_criacao` datetime DEFAULT CURRENT_TIMESTAMP,
  `dt_atualizacao` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_usuario` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `dart`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;