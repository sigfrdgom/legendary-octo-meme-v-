 
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema gestor_tramites
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema gestor_tramites
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gestor_tramites` DEFAULT CHARACTER SET latin1 ;
USE `gestor_tramites` ;

-- -----------------------------------------------------
-- Table `gestor_tramites`.`proceso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestor_tramites`.`proceso` (
  `id_proceso` INT(4) UNSIGNED ZEROFILL NOT NULL,
  `nombre_proceso` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_proceso`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `gestor_tramites`.`caso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestor_tramites`.`caso` (
  `id_caso` INT(4) UNSIGNED ZEROFILL NOT NULL,
  `Proceso_id_proceso` INT(4) UNSIGNED ZEROFILL NOT NULL,
  `descripcion_caso` VARCHAR(150) NULL DEFAULT NULL,
  PRIMARY KEY (`id_caso`),
  CONSTRAINT `fk_Caso_Proceso1`
    FOREIGN KEY (`Proceso_id_proceso`)
    REFERENCES `gestor_tramites`.`proceso` (`id_proceso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Caso_Proceso1_idx` ON `gestor_tramites`.`caso` (`Proceso_id_proceso` ASC);


-- -----------------------------------------------------
-- Table `gestor_tramites`.`caso_detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestor_tramites`.`caso_detalle` (
  `id_caso_detalle` INT(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `Caso_id_caso` INT(4) UNSIGNED ZEROFILL NOT NULL,
  `fecha_inicio` DATETIME NOT NULL,
  `persona_responsable` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_caso_detalle`),
  CONSTRAINT `fk_Caso_detalle_Caso1`
    FOREIGN KEY (`Caso_id_caso`)
    REFERENCES `gestor_tramites`.`caso` (`id_caso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Caso_detalle_Caso1_idx1` ON `gestor_tramites`.`caso_detalle` (`Caso_id_caso` ASC);


-- -----------------------------------------------------
-- Table `gestor_tramites`.`tipo_paso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestor_tramites`.`tipo_paso` (
  `id_tipo_paso` INT(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `nombre_tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipo_paso`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `gestor_tramites`.`paso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestor_tramites`.`paso` (
  `id_paso` INT(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `Tipo_paso_id_tipo_paso` INT(3) UNSIGNED ZEROFILL NOT NULL,
  `nombre_paso` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_paso`),
  CONSTRAINT `fk_Paso_Tipo_paso1`
    FOREIGN KEY (`Tipo_paso_id_tipo_paso`)
    REFERENCES `gestor_tramites`.`tipo_paso` (`id_tipo_paso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Paso_Tipo_paso1_idx` ON `gestor_tramites`.`paso` (`Tipo_paso_id_tipo_paso` ASC);


-- -----------------------------------------------------
-- Table `gestor_tramites`.`tipo_requisito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestor_tramites`.`tipo_requisito` (
  `id_tipo_requisito` INT(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `nombre_tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipo_requisito`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `gestor_tramites`.`requisito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestor_tramites`.`requisito` (
  `id_requisito` INT(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `id_tipo_requisito_id_tipo_requisito` INT(3) UNSIGNED ZEROFILL NOT NULL,
  `nombre_requisito` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_requisito`),
  CONSTRAINT `fk_Requisito_id_tipo_requisito`
    FOREIGN KEY (`id_tipo_requisito_id_tipo_requisito`)
    REFERENCES `gestor_tramites`.`tipo_requisito` (`id_tipo_requisito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Requisito_id_tipo_requisito_idx` ON `gestor_tramites`.`requisito` (`id_tipo_requisito_id_tipo_requisito` ASC);


-- -----------------------------------------------------
-- Table `gestor_tramites`.`paso_requisito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestor_tramites`.`paso_requisito` (
  `id_paso_requisito` INT(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `Paso_id_paso` INT(4) UNSIGNED ZEROFILL NOT NULL,
  `Requisito_id_requisito` INT(4) UNSIGNED ZEROFILL NOT NULL,
  `comentarios` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id_paso_requisito`),
  CONSTRAINT `fk_Paso_requisito_Paso1`
    FOREIGN KEY (`Paso_id_paso`)
    REFERENCES `gestor_tramites`.`paso` (`id_paso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Paso_requisito_Requisito1`
    FOREIGN KEY (`Requisito_id_requisito`)
    REFERENCES `gestor_tramites`.`requisito` (`id_requisito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Paso_requisito_Requisito1_idx` ON `gestor_tramites`.`paso_requisito` (`Requisito_id_requisito` ASC);

CREATE INDEX `fk_Paso_requisito_Paso1_idx` ON `gestor_tramites`.`paso_requisito` (`Paso_id_paso` ASC);


-- -----------------------------------------------------
-- Table `gestor_tramites`.`caso_detalle_requisito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestor_tramites`.`caso_detalle_requisito` (
  `id_caso_detalle_requisito` INT(11) NOT NULL AUTO_INCREMENT,
  `Caso_detalle_id_caso` INT(4) UNSIGNED ZEROFILL NOT NULL,
  `paso_requisito_id_paso_requisito` INT(10) UNSIGNED ZEROFILL NOT NULL,
  `estado_aceptado_rechazado` TINYINT(1) NOT NULL,
  `fecha` DATETIME NULL,
  `comentarios` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id_caso_detalle_requisito`),
  CONSTRAINT `fk_Caso_detalle_requisito_Caso_detalle1`
    FOREIGN KEY (`Caso_detalle_id_caso`)
    REFERENCES `gestor_tramites`.`caso_detalle` (`id_caso_detalle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_caso_detalle_requisito_paso_requisito1`
    FOREIGN KEY (`paso_requisito_id_paso_requisito`)
    REFERENCES `gestor_tramites`.`paso_requisito` (`id_paso_requisito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Caso_detalle_requisito_Caso_detalle1_idx` ON `gestor_tramites`.`caso_detalle_requisito` (`Caso_detalle_id_caso` ASC);

CREATE INDEX `fk_caso_detalle_requisito_paso_requisito1_idx` ON `gestor_tramites`.`caso_detalle_requisito` (`paso_requisito_id_paso_requisito` ASC);


-- -----------------------------------------------------
-- Table `gestor_tramites`.`caso_detalle_requisito_atestado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestor_tramites`.`caso_detalle_requisito_atestado` (
  `id_caso_detalle_requisito_atestado` INT(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `Caso_detalle_requisito_id_caso_detalle_requisito` INT(11) NOT NULL,
  `comentarios` VARCHAR(150) NULL DEFAULT NULL,
  `fecha_fin` DATE NOT NULL,
  PRIMARY KEY (`id_caso_detalle_requisito_atestado`),
  CONSTRAINT `fk_Caso_detalle_requisito_atestado_Caso_detalle_requisito1`
    FOREIGN KEY (`Caso_detalle_requisito_id_caso_detalle_requisito`)
    REFERENCES `gestor_tramites`.`caso_detalle_requisito` (`id_caso_detalle_requisito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Caso_detalle_requisito_atestado_Caso_detalle_requisito1_idx` ON `gestor_tramites`.`caso_detalle_requisito_atestado` (`Caso_detalle_requisito_id_caso_detalle_requisito` ASC);


-- -----------------------------------------------------
-- Table `gestor_tramites`.`proceso_detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestor_tramites`.`proceso_detalle` (
  `id_proceso_detalle` INT(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `Proceso_id_proceso` INT(4) UNSIGNED ZEROFILL NOT NULL,
  `Paso_id_paso` INT(4) UNSIGNED ZEROFILL NOT NULL,
  `tiempoAprox` DATETIME NULL,
  PRIMARY KEY (`id_proceso_detalle`),
  CONSTRAINT `fk_Proceso_detalle_Paso1`
    FOREIGN KEY (`Paso_id_paso`)
    REFERENCES `gestor_tramites`.`paso` (`id_paso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Proceso_detalle_Proceso1`
    FOREIGN KEY (`Proceso_id_proceso`)
    REFERENCES `gestor_tramites`.`proceso` (`id_proceso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Proceso_detalle_Paso1_idx` ON `gestor_tramites`.`proceso_detalle` (`Paso_id_paso` ASC);

CREATE INDEX `fk_Proceso_detalle_Proceso1_idx` ON `gestor_tramites`.`proceso_detalle` (`Proceso_id_proceso` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
