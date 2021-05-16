-- -----------------------------------------------------
-- Schema h006_SAM
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `h006_SAM` ;

-- -----------------------------------------------------
-- Schema h006_SAM
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `h006_SAM` ;
USE `h006_SAM` ;

-- -----------------------------------------------------
-- Table `h006_SAM`.`Aluno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `h006_SAM`.`Aluno` ;

CREATE TABLE IF NOT EXISTS `h006_SAM`.`Aluno` (
  `CPF` CHAR(11) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Sobrenome` VARCHAR(80) NOT NULL,
  `Sexo` CHAR(1) NOT NULL,
  `DataNasc` DATE NULL,
  PRIMARY KEY (`CPF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `h006_SAM`.`Area`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `h006_SAM`.`Area` ;

CREATE TABLE IF NOT EXISTS `h006_SAM`.`Area` (
  `Sigla` CHAR(8) NOT NULL,
  `Nome` VARCHAR(120) NOT NULL,
  `SuperArea` CHAR(8) NULL,
  PRIMARY KEY (`Sigla`),
  INDEX `fk_Area_Area1_idx` (`SuperArea` ASC),
  CONSTRAINT `fk_Area_Area1`
    FOREIGN KEY (`SuperArea`)
    REFERENCES `h006_SAM`.`Area` (`Sigla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `h006_SAM`.`Curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `h006_SAM`.`Curso` ;

CREATE TABLE IF NOT EXISTS `h006_SAM`.`Curso` (
  `Sigla` CHAR(8) NOT NULL,
  `Nome` VARCHAR(250) NOT NULL,
  `Horas` INT NULL,
  `Custo` DECIMAL(12,2) NOT NULL,
  `Area` CHAR(8) NOT NULL,
  PRIMARY KEY (`Sigla`),
  INDEX `fk_Curso_Area1_idx` (`Area` ASC),
  CONSTRAINT `fk_Curso_Area1`
    FOREIGN KEY (`Area`)
    REFERENCES `h006_SAM`.`Area` (`Sigla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `h006_SAM`.`Modulo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `h006_SAM`.`Modulo` ;

CREATE TABLE IF NOT EXISTS `h006_SAM`.`Modulo` (
  `Sigla` CHAR(8) NOT NULL,
  `Nome` VARCHAR(250) NOT NULL,
  `Curso` CHAR(8) NOT NULL,
  PRIMARY KEY (`Sigla`),
  INDEX `fk_Modulo_Curso1_idx` (`Curso` ASC),
  CONSTRAINT `fk_Modulo_Curso1`
    FOREIGN KEY (`Curso`)
    REFERENCES `h006_SAM`.`Curso` (`Sigla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `h006_SAM`.`Topico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `h006_SAM`.`Topico` ;

CREATE TABLE IF NOT EXISTS `h006_SAM`.`Topico` (
  `Modulo` CHAR(8) NOT NULL,
  `Sigla` CHAR(3) NOT NULL,
  `Nome` VARCHAR(250) NOT NULL,
  `Horas` INT NOT NULL,
  PRIMARY KEY (`Modulo`, `Sigla`),
  INDEX `fk_Topico_Modulo1_idx` (`Modulo` ASC),
  CONSTRAINT `fk_Topico_Modulo1`
    FOREIGN KEY (`Modulo`)
    REFERENCES `h006_SAM`.`Modulo` (`Sigla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `h006_SAM`.`Matricula`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `h006_SAM`.`Matricula` ;

CREATE TABLE IF NOT EXISTS `h006_SAM`.`Matricula` (
  `Curso` CHAR(8) NOT NULL,
  `Aluno` CHAR(11) NOT NULL,
  `Date` DATE NOT NULL,
  `Pago` TINYINT NOT NULL,
  PRIMARY KEY (`Aluno`, `Curso`),
  INDEX `fk_Matricula_Aluno1_idx` (`Aluno` ASC),
  CONSTRAINT `fk_Matricula_Curso1`
    FOREIGN KEY (`Curso`)
    REFERENCES `h006_SAM`.`Curso` (`Sigla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Matricula_Aluno1`
    FOREIGN KEY (`Aluno`)
    REFERENCES `h006_SAM`.`Aluno` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `h006_SAM`.`Professor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `h006_SAM`.`Professor` ;

CREATE TABLE IF NOT EXISTS `h006_SAM`.`Professor` (
  `Curso` CHAR(8) NOT NULL,
  `CPF` CHAR(11) NOT NULL,
  `Nome` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`Curso`, `CPF`),
  INDEX `fk_Professor_Curso1_idx` (`Curso` ASC),
  CONSTRAINT `fk_Professor_Curso1`
    FOREIGN KEY (`Curso`)
    REFERENCES `h006_SAM`.`Curso` (`Sigla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


