-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-02-2023 a las 16:44:37
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_sisevid_015224`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_REGISTRAREVIDENCIA` (`param_fechacreacion` DATETIME, `param_descripcion` VARCHAR(4000), `param_nomarchivo` VARCHAR(1000), `param_linkarchivo` VARCHAR(4000), `param_observacion` VARCHAR(4000), `param_fkidtipoevidencia` INT, `param_fkidarticulo` VARCHAR(10), `param_fkidliteral` VARCHAR(10), `param_fkidnumeral` VARCHAR(10), `param_fkidsubnumeral` VARCHAR(10), `param_fkidsub_subnumeral` VARCHAR(10), `param_fkidusuario` VARCHAR(50))   BEGIN
		DECLARE param_fkidevidencia int(11);
        DECLARE EXIT HANDLER for sqlexception
          BEGIN
            -- ERROR
			SELECT 'Se presentó una excepción. Revisar los datos enviados';
          ROLLBACK;
        END;
        DECLARE EXIT HANDLER for sqlwarning
         BEGIN
            -- WARNING
			SELECT 'Se presentó un warning. Revisar los datos enviados';
         ROLLBACK;
    END;
    START TRANSACTION;

		INSERT INTO tblevidencia(fecharegistro,fechacreacion,descripcion,nomarchivo,linkarchivo,observacion,fkidtipoevidencia,fkidarticulo,fkidliteral,fkidnumeral,fkidsubnumeral,fkidsub_subnumeral) 
		VALUES(sysdate(),param_fechacreacion,param_descripcion,param_nomarchivo,param_linkarchivo,param_observacion,param_fkidtipoevidencia,param_fkidarticulo,param_fkidliteral,param_fkidnumeral,param_fkidsubnumeral,param_fkidsub_subnumeral);

		SET param_fkidevidencia := LAST_INSERT_ID();

		INSERT INTO tblevidenciaestado(fkidevidencia,fkidestado,fkidusuario,fecha) 
		VALUES (param_fkidevidencia,'1',param_fkidusuario,sysdate());

    COMMIT;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evidencia_indicador`
--

CREATE TABLE `evidencia_indicador` (
  `id` int(11) NOT NULL,
  `fkidindicador` int(11) NOT NULL,
  `fkidevidencia` int(11) NOT NULL,
  `fechaasignacion` int(11) NOT NULL,
  `fknomusuario` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `frecuencia`
--

CREATE TABLE `frecuencia` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fuente`
--

CREATE TABLE `fuente` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fuente_indicador`
--

CREATE TABLE `fuente_indicador` (
  `fkidfuente` int(11) NOT NULL,
  `fkidindicador` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `indicador`
--

CREATE TABLE `indicador` (
  `id` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `objetivo` varchar(1000) NOT NULL,
  `alcance` varchar(1000) NOT NULL,
  `formula` varchar(1000) NOT NULL,
  `fkidtipoindicador` int(11) NOT NULL,
  `fkidunidadmedicion` int(11) NOT NULL,
  `meta` varchar(1000) NOT NULL,
  `fkidsentido` int(11) NOT NULL,
  `fkidfrecuencia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `represenvisual`
--

CREATE TABLE `represenvisual` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `represenvisual_indicador`
--

CREATE TABLE `represenvisual_indicador` (
  `fkidindicador` int(11) NOT NULL,
  `fkidrepresenvisual` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `responsable`
--

CREATE TABLE `responsable` (
  `cedula` varchar(50) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `responsable_indicador`
--

CREATE TABLE `responsable_indicador` (
  `fkidresponsable` varchar(50) NOT NULL,
  `fkidindicador` int(11) NOT NULL,
  `fechaasignacion` datetime NOT NULL,
  `fknomusuario` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resultadoindicador`
--

CREATE TABLE `resultadoindicador` (
  `id` int(11) NOT NULL,
  `resultado` double NOT NULL,
  `fechacalculo` datetime NOT NULL,
  `fkidindicador` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sentido`
--

CREATE TABLE `sentido` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblarticulo`
--

CREATE TABLE `tblarticulo` (
  `id` varchar(10) NOT NULL,
  `nombre` varchar(1000) NOT NULL,
  `descripcion` varchar(4000) NOT NULL,
  `fkidtitulo` varchar(10) NOT NULL,
  `fkidcapitulo` varchar(10) NOT NULL,
  `fkidseccion` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblarticulo`
--

INSERT INTO `tblarticulo` (`id`, `nombre`, `descripcion`, `fkidtitulo`, `fkidcapitulo`, `fkidseccion`) VALUES
('1', 'Objeto', 'La presente resolución tiene como objeto establecer los parámetros de autoevaluación, verificación y evaluación de cada Una de las condiciones institucionales definidas en el Decreto 1075 de 2015, modificado por el Decreto 1330 de 2019, las cuales deben ser demostradas integralmente en el marco de los procesos de solicitud y renovación del registro calificado de programas \r\nacadémicos de educación superior.', '1', '0', '0'),
('10', 'Información cualitativa y cuantitativa para mejorar el bienestar, la permanencia y graduación de los estudiantes.', 'La institución deberá conocer de los estudiantes que son admitidos el rendimiento académico, el desempeño en el Examen de Estado de la Educación Media, ICFES - SABER 11”, aspectos socioeconómicos y demás aspectos culturales que puedan incidir en el mejoramiento del bienestar, en el acompañamiento del proceso formativo, en la permanencia y en la graduación oportuna.', '2', '1', '1'),
('11', 'Evaluación, seguimiento y retroalimentación de los estudiantes', 'La institución deberá contar con políticas para la evaluación, el seguimiento y la retroalimentación a los estudiantes, en coherencia con el proceso formativo, los niveles y las modalidades en los que se ofrecen los programas académicos. Esto implica que las unidades académicas, o lo que haga sus veces, al igual que las empresas, entidades, organizaciones y demás entes que estén involucrados en las actividades académicas y en el proceso formativo, adopten dichas políticas y sean responsables de la evaluación, seguimiento y retroalimentación de los estudiantes.', '2', '1', '1'),
('12', 'Comunicación con estudiantes.', 'La institución deberá demostrar la existencia de medios de comunicación de fácil acceso a los estudiantes, en los cuales esté disponible la información necesaria para desarrollar las actividades académicas del proceso formativo. Además, deberá garantizar que la información que se le brinde a quien aspira a ser admitido en la institución sea clara y contenga, por lo menos: ', '2', '1', '1'),
('13', 'Evidencias e indicadores de los mecanismos que soportan la selección y evaluación de estudiantes.', 'Teniendo en cuenta los artículos precedentes de esta sección, la institución deberá presentar para el proceso formativo, por lo menos: ', '2', '1', '1'),
('14', 'Mecanismos que soportan la selección y evaluación de profesores.', 'La institución deberá proporcionar los criterios y argumentos que indiquen la forma en que los mecanismos de selección y evaluación de profesores son coherentes con la naturaleza jurídica, tipología, identidad y misión institucional. Dichos mecanismos deberán estar incorporados en la normativa institucional  vigente en el momento en que la institución inicie la etapa de Pre radicación de solicitud de registro calificado y deberán estar aprobados por las instancias del  gobiemo institucional correspondientes. ', '2', '1', '2'),
('15', 'Características del grupo institucional de profesores.', 'La institución \r\ndeberá describir el grupo de profesores con el que cuenta, grupo que, por su dedicación, vinculación y disponibilidad, deberá cubrir, de manera consistente y armónica con su naturaleza jurídica, tipología, identidad y misión institucional, todas las labores académicas, formativas, docentes, cientificas, culturales y de extensión que desarrolle la institución,definidas en su proyecto educativo institucional, O lo que haga sus veces. Dicha descripción deberá incluir, por lo menos: ', '2', '1', '2'),
('16', 'Reglamento profesoral o su equivalente.', 'El reglamento profesoral o su equivalente y los demás documentos debidamente aprobados por las autoridades o instancias competentes de la institución deberán considerar los niveles de formación, las modalidades y los lugares diferentes a la institución donde se realicen las actividades propias del desarrollo como profesor. En coherencia y consistencia con la naturaleza jurídica, tipología, identidad y misión, el reglamento deberá ser claro y expreso, y contemplar por lo menos:', '2', '1', '2'),
('17', 'Mecanismos para la implementación de los planes institucionales \r\ny el desarrollo de actividades académicas.', 'La institución deberá contar, por lo menos, con los siguientes mecanismos que faciliten la implementación de los planes institucionales y el desarrollo de las actividades académicas: ', '2', '1', '2'),
('18', 'Evidencias e indicadores de los mecanismos que soportan la selección y evaluación de profesores.', 'Teniendo en cuenta los artículos precedentes de esta sección, la institución deberá presentar, por lo menos: ', '2', '1', '2'),
('19', 'Gobierno institucional y rendición de cuentas.', 'La institución deberá proporcionar los criterios y argumentos que indican la forma en que el gobierno institucional y la rendición de cuentas son coherentes con la naturaleza jurídica, tipología, identidad y misión institucional. Dichos mecanismos deberán estar incorporados en la normativa institucional vigente al momento en que la institución inicie la etapa de Pre radicación y deberán estar aprobados por las instancias de gobiemo correspondientes.', '2', '2', '0'),
('2', 'Ámbito de aplicación', 'La presente resolución aplica al Ministerio de Educación Nacional, a la Comisión Nacional Intersectorial de Aseguramiento de la Calidad de la Educación Superior - Conaces, a los pares académicos que participan en los procesos de registro calificado, a las instituciones de educación superior y aquellas habilitadas por la ley para ofrecer y desarrollar programas académicos de educación superior.', '1', '0', '0'),
('20', 'Gobierno institucional.', 'La institución deberá establecer y demostrar la existencia de un gobierno institucional atendiendo su naturaleza jurídica, identidad, tipología y misión. Para ello, la institución deberá, por lo menos: ', '2', '2', '0'),
('21', 'Rendición de cuentas institucional.', 'La institución deberá establecer sus mecanismos de rendición de cuentas atendiendo su naturaleza jurídica, identidad, tipología y misión. Para ello, deberá indicar, a quiénes rendirá cuentas sobre el desempeño institucional, la periodicidad y los medios de difusión a utilizar, entre otros aspectos, teniendo en cuenta lo previsto en el Acuerdo 02 de 2017 del Consejo Nacional de Educación Superior - CESU.', '2', '2', '0'),
('22', 'Participación de la comunidad académica en procesos de toma de decisiones. ', 'Desde su autonomía y modelo de gobierno, y en coherencia con la naturaleza jurídica, tipología, identidad, misión, estatutos y demás reglamentos, la institución deberá demostrar los espacios de participación de la comunidad académica en los procesos de toma de decisiones. ', '2', '2', '0'),
('23', 'Políticas institucionales.', 'Hace referencia al marco normativo complementario a los estatutos. La institución deberá exponer las instancias competentes y los procedimientos institucionales que se deben adelantar para la formulación, aprobación, comunicación y actualización de los reglamentos intemos, así como el seguimiento a su cumplimiento y los medios dispuestos para que la comunidad académica tenga claridad de dichas instancias y procedimientos.', '2', '2', '0'),
('24', 'Políticas académicas asociadas a currículo, resultados de aprendizaje, créditos y actividades.', 'Teniendo en cuenta los distintos niveles formativos y modalidades ofrecidas por la institución, y en coherencia con su naturaleza jurídica, identidad, tipología y misión, las políticas académicas deberán, por lo menos: ', '2', '2', '0'),
('25', 'Políticas de gestión institucional y bienestar.', 'Teniendo en cuenta los distintos niveles formativos y modalidades ofrecidas por la institución, en coherencia con su naturaleza jurídica, identidad, tipología y misión, las políticas de gestión institucional y bienestar deberán, orientar como mínimo los siguientes aspectos: ', '2', '2', '0'),
('26', 'Políticas de investigación, innovación, creación artística y cultural.', 'Teniendo en cuenta los distintos niveles formativos y modalidades ofrecidas por la institución, en coherencia con su naturaleza jurídica, identidad, tipología y misión, las políticas de investigación, innovación, creación artística y cultural estarán encaminadas a fomentar, fortalecer y desarrollar la ciencia, tecnología e innovación, contribuyendo así a la transformación social del país. En consecuencia, la institución deberá, por lo menos, indicar:', '2', '2', '0'),
('27', 'Gestión de la información.', 'La institución deberá contar con información que le permita a la comunidad institucional conocer, apropiar, proceder y tomar decisiones, basada en datos y análisis de los mismos, de tal forma que se sustenten en las políticas, normas, procesos de planeación y resultados de gestión, para lo cual deberá presentar, por lo menos: ', '2', '2', '0'),
('28', 'Arquitectura institucional.', 'La institución deberá articular sus procesos con la organización y las funciones de los cargos para garantizar el cumplimiento de las labores formativas, académicas, docentes, científicas, Culturales y de extensión, que sean coherentes con su naturaleza jurídica, tipología, identidad y misión. Para ello, la institución deberá presentar, por lo menos: ', '2', '2', '0'),
('29', ' Evidencias e indicadores de la estructura administrativa y académica.', 'Teniendo en cuenta los artículos precedentes de este capítulo, la institución deberá presentar, por lo menos: ', '2', '2', '0'),
('3', 'Condiciones institucionales de calidad.', 'De conformidad con las disposiciones de la Ley 1188 de 2008 y del Decreto 1075 de 2015, modificado por el Decreto 1330 de 2019, las condiciones de calidad institucionales establecidas para la obtención y renovación del registro calificado son:', '1', '0', '0'),
('30', 'Cultura de la autoevaluación.', 'De acuerdo con su naturaleza jurídica, tipología, identidad y misión, la institución deberá establecer y promover su compromiso con la calidad mediante la adopción de, por lo menos: ', '2', '3', '0'),
('31', 'Sistema interno de aseguramiento de la calidad.', 'La institución deberá contar con un sistema intemo de aseguramiento de la calidad que prevea los momentos de planeación, implementación, seguimiento, evaluación y mejoramiento de las labores académicas, formativas, docentes, culturales, científicas y de extensión, y el desempeño de los estudiantes, egresados, profesores y demás integrantes de la comunidad institucional, de tal forma que, al menos, dé cuenta de lo que señala el artículo 2.5.3.2.3.1.4 del Decreto 1075 de 2015, modificado por el Decreto 1330 de 2019.', '2', '3', '0'),
('32', 'Evidencias e indicadores de la cultura de la autoevaluación.', 'Teniendo en cuenta los artículos precedentes de este capítulo, la institución deberá presentar, por lo menos: ', '2', '3', '0'),
('33', 'Seguimiento a la actividad profesional de los egresados.', 'La institución deberá promover la interacción mutua entre los egresados y la institución. Para ello, deberá contar por lo menos, con:', '2', '4', '0'),
('34', 'Aprendizaje del egresado a lo largo de la vida.', 'La institución deberá establecer mecanismos que propendan por la oferta de programas de formación en diferentes dimensiones del desarrollo personal y profesional para la actualización de sus egresados, de acuerdo con las necesidades del entorno.', '2', '4', '0'),
('35', 'Experiencia del egresado en la dinámica institucional.', 'La institución deberá contar con: ', '2', '4', '0'),
('36', 'Evidencias e indicadores de seguimiento al programa de egresados.', 'Teniendo en cuenta los artículos precedentes de este capítulo, la institución deberá presentar, por lo menos:', '2', '4', '0'),
('37', 'Modelo de bienestar.', 'La institución deberá describir el modelo de bienestar, el cual deberá incluir a todos los miembros que hacen parte de la comunidad institucional y reconocer la diversidad que se da en el contexto de las modalidades y los niveles de formación ofrecidos, la naturaleza jurídica, tipología, identidad y misión. Dicho modelo deberá contar, por lo menos con: ', '2', '5', '0'),
('38', 'Programas orientados a la prevención de la deserción y a la promoción de la graduación de los estudiantes.', 'En función del desarrollo de los estudiantes y apoyados en la información cualitativa y cuantitativa para mejorar su permanencia y graduación, la institución deberá contar con mecanismos de divulgación e implementación de programas orientados a la prevención de la deserción y a la promoción de la graduación de los estudiantes, que contemplen, por lo menos: ', '2', '5', '0'),
('39', 'Evidencias e indicadores del modelo de binestar.', 'Teniendo en cuenta los artículos precedentes de este capítulo, la institución deberá presentar: ', '2', '5', '0'),
('4', 'Evidencias', 'Cada una de las condiciones institucionales que se \r\ndesarrolla en esta resolución, comprende un conjunto de evidencias que son el respaldo para la verificación y evaluación de las instituciones en el proceso de obtención y renovación del registro calificado, sirviendo así para el cumplimiento de las funciones de los pares académicos y de la Comisión Nacional Intersectorial de Aseguramiento de la Calidad de la Educación Superior - Conaces.', '1', '0', '0'),
('40', 'Definición de la misión, propósitos y objetivos institucionales.', 'La institución, en coherencia con las modalidades, los niveles de formación, su naturaleza jurídica, identidad y tipología, deberá: ', '2', '6', '0'),
('41', 'Gestión del talento humano.', 'Para la gestión del talento humano, la institución deberá establecer, por lo menos: ', '2', '6', '0'),
('42', 'Disponibilidad de recursos físicos y tecnológicos.', 'La institución deberá contar y tener disponible, en el lugar de desarrollo, una infraestructura física y tecnológica para el cumplimiento de las labores formativas, académicas, docentes, científicas, culturales, de extensión, de bienestar y de apoyo a la comunidad institucional, para lo cual, deberá tener en cuenta, por lo menos: ', '2', '6', '0'),
('43', 'Descripción de la infraestructura física y tecnológica.', '\r\nLa intitución deberá incluir en la descripción de los espacios físicos y tecnológicos para el soporte del desarrollo de su misión y el cumplimiento de sus propósitos y objetivos institucionales, acorde con la cifra proyectada de estudiantes, profesores y el personal administrativo, la capacidad, disponibilidad, acceso y uso de estos. Para tales efectos, deberá especificar: ', '2', '6', '0'),
('44', 'Políticas de actualización y renovación de la infraestructura física y tecnológica.', 'La institución deberá contar con procesos para la actualización, renovación y mantenimiento de la infraestructura física y tecnológica, de tal forma que se prevea el desarrollo institucional y la obsolescencia de los recursos disponibles. Para tales efectos, deberá demostrar, por lo menos: ', '2', '6', '0'),
('45', 'Apoyo tecnológico y sistemas de información.', 'Para el desarrollo de las labores formativas, académicas, docentes, cientificas, culturales, de extensión y administrativas, la institución deberá contar, por lo menos con: ', '2', '6', '0'),
('46', ' Recursos financieros.', 'La institución, en coherencia con su naturaleza jurídica, tipología e identidad institucional, deberá contar, por lo menos con: ', '2', '6', '0'),
('47', 'Evidencias de recursos suficientes para el cumplimiento de las metas.', 'Teniendo en cuenta los artículos precedentes de este capítulo, la institución deberá presentar: ', '2', '6', '0'),
('48', 'Renovación de las condiciones institucionales.', 'La institución deberá evidenciar ante el Ministerio de Educación Nacional el mejoramiento de las condiciones institucionales evaluadas en el proceso anterior, en el que se haya emitido o renovado el concepto favorable de condiciones institucionales. \r\nPara ello, la institución, en el marco de la implementación de los procesos de su sistema interno de aseguramiento de la calidad, deberá presentar, en uno o varios informes de autoevaluación, por lo menos', '3', '0', '0'),
('49', 'Evidencias e indicadores de los mecanismos que soportan la selección y evaluación de estudiantes en la renovación de condiciones institucionales.', 'Teniendo en cuenta los artículos 6 al 12 de la presente resolución, la institución deberá presentar, en uno o varios informes de autoevaluación, por lo menos:', '3', '1', '1'),
('5', 'Autoevaluación', 'En los trámites asociados con el registro calificado, las instituciones deberán desarrollar, en el marco de su sistema interno de aseguramiento de la calidad, las estrategias que proporcionen los instrumentos, la información y los espacios de interacción con la comunidad académica, necesarios para soportar el cumplimiento de las condiciones institucionales y de programa', '1', '0', '0'),
('50', 'Evidencias e indicadores de los mecanismos que soportan la selección y evaluación de profesores en la renovación de condiciones institucionales.', 'Teniendo en cuenta los artículos 6 y 14 al 17 de la presente resolución, la institución deberá presentar, en uno o varios informes de autoevaluación, por lo menos: ', '3', '1', '2'),
('51', 'Evidencias e indicadores de la estructura administrativa y académica en la renovación de condiciones institucionales.', 'Teniendo en cuenta los artículos 19 al 28 de la presente resolución, la institución deberá presentar, en uno o varios informes de autoevaluación, por lo menos: ', '3', '2', '0'),
('52', 'Evidencias e indicadores de la cultura de la autoevaluación en la renovación de condiciones institucionales.', 'Teniendo en cuenta los artículos 30 y 31 de la presente resolución, la institución deberá presentar, en uno o varios informes de autoevaluación, por lo menos: ', '3', '3', '0'),
('53', 'Evidencias e indicadores del seguimiento al programa de egresados en la renovación de condiciones institucionales.', 'Teniendo en cuenta los artículos 33 al 35 de la presente resolución, la institución deberá presentar, en uno o varios informes de autoevaluación, por lo menos: ', '3', '4', '0'),
('54', 'Evidencias e indicadores del modelo de bienestar en la renovación de condiciones institucionales.', 'Teniendo en cuenta los artículos 37 y 38 de la presente resolución, la institución deberá presentar, acorde con su modelo de bienestar, en uno o varios informes de autoevaluación: ', '3', '5', '0'),
('55', 'Evidencias e indicadores de los recursos suficientes para garantizar el cumplimiento de las metas en la renovación de condiciones institucionales.', 'Teniendo en cuenta el artículo 40 de la presente resolución, la institución deberá presentar, en uno o varios informes de autoevaluación, por lo menos: ', '3', '6', '0'),
('56', 'Evidencias e indicadores de la gestión del talento humano en la renovación de condiciones institucionales.', 'Teniendo en cuenta el artículo 41 de la presente resolución, la institución deberá presentar, en uno o varios informes de autoevaluación, por lo menos: ', '3', '6', '0'),
('57', 'Evidencias e indicadores de los recursos físicos y tocnológicos en la renovación de condiciones institucionales.', 'Teniendo en cuenta los artículos 42 al 45 de la presente resolución, la institución deberá presentar, en uno o varios informes de autoevaluación, por lo menos: ', '3', '6', '0'),
('58', 'EVIDENCIAS E INDICADORES DE LOS RECURSOS FINANCIEROS EN LA RENOVACIÓN DE CONDICIONES INSTITUCIONALES.', 'Teniendo en cuenta el artículo 46 de la presente resolución, la institución deberá presentar, en uno o varios informes de autoevaluación, por lo menos: ', '3', '6', '0'),
('59', 'VIGENCIA.', 'La presente resolución rige a partir de la fecha de su publicación.', '3', '6', '0'),
('6', 'Mecanismos de selección y evaluación de estudiantes y profesores', 'De acuerdo con su naturaleza jurídica, tipología, identidad y misión, la institución deberá contar con políticas, normas, procesos, medios y demás componentes que considere necesarios para la selección y evaluación de estudiantes y profesores', '2', '1', '0'),
('7', 'Mecanismos de selección y evaluación de estudiantes', 'La institución deberá proporcionar los criterios y argumentos que indiquen la forma en que los mecanismos de selección y evaluación de estudiantes son coherentes con la naturaleza jurídica, tipología, identidad y misión institucional. Dichos mecanismos deberán estar incorporados en la normativa institucional vigente en el momento en que la institución inicie la etapa de Pre radicación de solicitud de registro calificado y deberán estar aprobados por las instancias de gobierno correspondientes', '2', '1', '1'),
('8', 'Reglamento estudiantil o su equivalente', 'El reglamento estudiantil o su equivalente deberá considerar los niveles de formación y las modalidades en las que oferta sus programas. En coherencia y consistencia con la naturaleza jurídica, misión, identidad y tipología, el reglamento deberá ser claro y expreso, y contemplar por lo menos: ', '2', '1', '1'),
('9', 'Políticas para mejorar el bienestar, la permanencia y graduación de los estudiantes.', 'La institución deberá definir las políticas para mejorar el bienestar, la permanencia y graduación de los estudiantes, demostrando que están articuladas a los medios, procesos y acciones requeridos para tal fin.', '2', '1', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblautor`
--

CREATE TABLE `tblautor` (
  `id` int(11) NOT NULL,
  `ident` varchar(50) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcapitulo`
--

CREATE TABLE `tblcapitulo` (
  `id` varchar(10) NOT NULL,
  `condicion` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblcapitulo`
--

INSERT INTO `tblcapitulo` (`id`, `condicion`) VALUES
('0', 'NA'),
('1', 'MECANISMOS DE SELECCIÓN Y EVALUACIÓN DE ESTUDIANTES Y PROFESORES'),
('2', 'ESTRUCTURA ADMINISTRATIVA Y ACADÉMICA'),
('3', 'CULTURA DE LA AUTOEVALUACIÓN'),
('4', 'PROGRAMA DE EGRESADOS'),
('5', 'MODELO DE BIENESTAR'),
('6', 'RECURSOS SUFICIENTES PARA GARANTIZAR EL CUMPLIMIENTO DE LAS METAS');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblestado`
--

CREATE TABLE `tblestado` (
  `id` varchar(1) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblestado`
--

INSERT INTO `tblestado` (`id`, `nombre`) VALUES
('1', 'Registrada'),
('2', 'Verificada'),
('3', 'Validada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblevidencia`
--

CREATE TABLE `tblevidencia` (
  `id` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  `fechacreacion` datetime DEFAULT NULL,
  `descripcion` varchar(4000) NOT NULL,
  `nomarchivo` varchar(200) DEFAULT NULL,
  `linkarchivo` varchar(4000) DEFAULT NULL CHECK (`nomarchivo` is not null or `linkarchivo` is not null),
  `observacion` varchar(4000) DEFAULT NULL,
  `ylatitud` double DEFAULT NULL,
  `xlongitud` double DEFAULT NULL,
  `fkidtipoevidencia` int(11) NOT NULL,
  `fkidarticulo` varchar(10) NOT NULL,
  `fkidliteral` varchar(10) DEFAULT NULL,
  `fkidnumeral` varchar(10) DEFAULT NULL,
  `fkidsubnumeral` varchar(10) DEFAULT NULL,
  `fkidsub_subnumeral` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblevidencia`
--

INSERT INTO `tblevidencia` (`id`, `fecharegistro`, `fechacreacion`, `descripcion`, `nomarchivo`, `linkarchivo`, `observacion`, `ylatitud`, `xlongitud`, `fkidtipoevidencia`, `fkidarticulo`, `fkidliteral`, `fkidnumeral`, `fkidsubnumeral`, `fkidsub_subnumeral`) VALUES
(1, '2022-12-02 21:13:57', '2022-12-03 15:14:00', 'DESCRIPCIÓN', 'imagen.jpg', NULL, 'Observación', NULL, NULL, 1, '13', NULL, NULL, NULL, NULL),
(2, '2022-12-02 00:00:00', '2022-12-02 00:00:00', 'Descripción de la evidencia', 'imagen.jpg', NULL, 'Observación de la evidencia', NULL, NULL, 1, '13', NULL, NULL, NULL, NULL),
(3, '2022-12-02 15:31:43', '2021-12-02 00:00:00', 'Descripción de la evidencia', 'imagen.jpg', NULL, 'Observación de la evidencia', NULL, NULL, 1, '13', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblevidenciaautor`
--

CREATE TABLE `tblevidenciaautor` (
  `id` int(11) NOT NULL,
  `fkidevidencia` int(11) NOT NULL,
  `fkiautor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblevidenciaestado`
--

CREATE TABLE `tblevidenciaestado` (
  `id` int(11) NOT NULL,
  `fkidevidencia` int(11) NOT NULL,
  `fkidestado` varchar(1) NOT NULL,
  `fkidusuario` varchar(50) NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblevidenciaestado`
--

INSERT INTO `tblevidenciaestado` (`id`, `fkidevidencia`, `fkidestado`, `fkidusuario`, `fecha`) VALUES
(1, 1, '1', 'USUARIO3', '2022-12-02 21:16:53'),
(2, 2, '1', 'USUARIO3', '2022-12-02 00:00:00'),
(3, 3, '1', 'USUARIO3', '2022-12-02 15:31:43');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblliteral`
--

CREATE TABLE `tblliteral` (
  `id` varchar(10) NOT NULL,
  `descripcion` varchar(1000) NOT NULL,
  `fkidarticulo` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblliteral`
--

INSERT INTO `tblliteral` (`id`, `descripcion`, `fkidarticulo`) VALUES
('a12', 'Deberes y derechos de los estudiantes.', '12'),
('a13', 'Documento(s) con los criterios y argumentos que identifican la forma en que los mecanismos de selección y evaluación de estudiantes son coherentes con la naturaleza jurídica, tipología, identidad y misión institucional.', '13'),
('a15', ' Los procesos institucionales para definir, evaluar y actualizar los perfiles institucionales de los profesores, acorde con los programas académicos, niveles y modalidades ofrecidos, y todas las labores académicas, docentes, formativas, científicas, culturales y de extensión.', '15'),
('a16', 'Derechos, deberes y obligaciones de los profesores.', '16'),
('a17', 'Estrategias para la comunicación clara y oportuna sobre la forma de contratación, las condiciones de la vinculación(naturaleza y el plazo inicial) y la dedicación de los profesores y, cuando corresponda, las consideraciones institucionales que podrían impedir o limitar las vinculaciones futuras, acorde con lo establecido en la ley.', '17'),
('a18', 'Documento(s) con los criterios y argumentos que indican la forma en que los mecanismos de selección y evaluación de profesores son coherentes con la naturaleza jurídica, tipología, identidad y misión institucional.', '18'),
('a20', 'Definir el modelo de gobierno institucional, que incluya:', '20'),
('a24', 'En cuanto al currículo: establecer las directrices que respondan a la misión institucional en las que señale, al menos: los principios básicos de diseño del contenido curricular y de las actividades académicas relacionadas con la formación integral; la forma en cómo, a partir del contenido curricular y de las actividades académicas, se procurará la interdisciplinariedad; y los componentes que la institución considere necesarios para cumplir con los resultados de aprendizaje previstos.', '24'),
('a25', 'La gestión de la comunidad institucional.', '25'),
('a26', 'La declaración institucional expresa de su énfasis de investigación, iinovación o creación artística y cultural, y su relación con sus labores formativas, académicas, docentes, científicas, culturales y de extensión.', '26'),
('a27', 'Marco normativo institucional para cumplir con las regulaciones, estándares y políticas aplicables con respecto al acceso, uso, divulgación, retención, actualización y/o eliminación de información y comunicaciones intemas, conforme con la ley de protección de datos.', '27'),
('a28', 'Los procesos necesarios que soporien el desarrollo de la institución bajo crienos de efectividad, flexibilidad y transparencia.', '28'),
('a29', 'Respecto al gobierno institucional y rendición de cuentas: ', '29'),
('a3', 'Mecanismos de selección y evaluación de estudiantes y profesores', '3'),
('a30', 'Políticas internas que promuevan los procesos de autoevaluación, autorregulación y mejoramiento.', '30'),
('a32', 'Respecto a la cultura de la autoevaluación:', '32'),
('a33', 'Políticas que promuevan el seguimiento a la actividad profesional de los egresados.', '33'),
('a35', 'Mecanismos para integrar los resultados de las percepciones y experiencias de la actividad profesional de sus egresados, a la reflexión sobre el mejoramiento de las labores formativas, académicas, docentes, cientificas, culturales y de extensión. ', '35'),
('a36', 'Políticas que promuevan el seguimiento a la actividad profesional de los egresados.', '36'),
('a37', 'Política de bienestar para la comunidad institucional articulada con lo previsto en los Acuerdos 03 de 1995 y 03 de 2013 del Consejo Nacional de Educación Superior — CESU.', '37'),
('a38', 'Alertas tempranas ante las posibilidades de deserción, de acuerdo con la información cualitativa y cuantitativa de los estudiantes para mejorar su ermanencia y graduación.', '38'),
('a39', 'Descripción del modelo de bienestar que incluya, por lo menos: ', '39'),
('a40', 'Contar con misión, propósitos y objetivos institucionales, y establecer los mecanismos para su correspondiente actualización cuando ello sea requerido.', '40'),
('a41', 'Para la gestión del talento humano, la institución deberá establecer, por lo menos: ', '41'),
('a42', 'Proyección de la población que conforma la comunidad institucional.', '42'),
('a43', 'Espacios construidos, diferenciando áreas cubiertas de áreas descubiertas o dedicadas a circulaciones, áreas verdes y espacios deportivos y culturales al aire libre, cuando la institución ofrezca programas académicos que por su modalidad requieren presencialidad.', '43'),
('a44', 'Políticas de mantenimiento, renovación y actualización de la infraestructura.', '44'),
('a45', 'Mecanismos de asistencia técnica, orientación y/o tutoría, en el uso de todas \r\nlas tecnologías utilizadas en el proceso formativo a profesores y estudiantes.', '45'),
('a46', 'Políticas y mecanismos para la obtención, planificación, gestión y control de recursos financieros que aseguren la sostenibilidad de la institución y el desarrollo de las labores formativas, académicas, docentes, científicas, culturales y de extensión.', '46'),
('a47', 'Respecto a la definición de la misión, propósitos y objetivos institucionales: ', '47'),
('a48', 'Todas aquellas decisiones relevantes tomadas y acciones realizadas durante la vigencia del concepto favorable de condiciones institucionales.', '48'),
('a49', 'Documento(s) con los criterios y argumentos que identifican la forma en que los mecanismos de selección y evaluación de estudiantes son coherentes con la naturaleza jurídica, tipología, identidad y misión institucional.', '49'),
('a50', 'Criterios y argumentos que indican la forma en que los mecanismos de selección y evaluación de profesores son coherentes con la naturaleza jurídica, tipología, identidad y misión institucional.', '50'),
('a51', 'Respecto al gobierno institucional y rendición de cuentas: ', '51'),
('a52', 'Respecto a la cultura de la autoevaluación: ', '52'),
('a53', 'Evidencia de la divulgación y actualización de las políticas que promuevan el seguimiento a la actividad profesional de los egresados.', '53'),
('a54', 'Resultados del modelo de bienestar que incluya, por lo menos: ', '54'),
('a55', 'Descripción de la ejecución y resultados de los instrumentos de planeación que han hecho posible la materialización de la misión, los propósitos y los objetivos institucionales en los últimos 7 años, comparada con los instrumentos que la  institución tenía proyectados para el mismo periodo, con la respectiva justificación en las diferencias significativas.', '55'),
('a56', 'Resultados de los procesos institucionales para atraer, vincular, retener y desvincular el talento humano acorde con su misión.', '56'),
('a57', 'Descripción y valoración cuantitativa y cualitativa de la infraestructura física y tecnológica, actualizadas a las dinámicas de la nueva vigencia de condiciones institucionales con la respectiva justificación.', '57'),
('a58', 'Evidencia de la divulgación de las políticas financieras.', '58'),
('a8', 'Derechos y deberes de los estudiantes', '8'),
('b12', 'Costos asociados al proceso formativo que incluyan: el valor de la matrícula y los demás derechos pecuniarios que por razones académicas puedan ser cobrados por la institución.', '12'),
('b13', 'Reglamento estudiantil o su equivalente. ', '13'),
('b15', 'El plan vigente de vinculación y dedicación institucional de los profesores, soportado en los recursos financieros requeridos, de acuerdo con el desarrollo institucional previsto en términos de la cifra proyectada de estudiantes y planes institucionales a realizar, que incluya perfiles, tipo de vinculación, dedicación y duración de los contratos.', '15'),
('b16', 'Criterios, requisitos y procesos para la selección, vinculación, otorgamiento de distinciones y estímulos, evaluación de desempeño y desvinculación de los profesores, orientados bajo principios de transparencia, mérito y objetividad.', '16'),
('b17', 'Procesos para la inducción de los profesores a las labores académicas, docentes, formativas, científicas, culturales y de extensión, en coherencia con la naturaleza jurídica, tipología, identidad y misión institucional.', '17'),
('b18', 'Descripción de los procesos institucionales para definir, evaluar y actualizar los perfiles profesorales.', '18'),
('b20', 'Formular el proyecto educativo institucional o el que haga sus veces.', '20'),
('b24', 'En cuanto a resultados de aprendizaje: establecer las definiciones conceptuales y los procesos de validación y aprobación de los mismos, en donde se indique por lo menos, la forma en que la institución establecerá, desarrollará y evaluará los resultados de aprendizaje y que serán coherentes con el perfil del egresado definido por la institución y el programa académico. Dichos resultados de aprendizaje deberán reflejar la síntesis del proceso formativo y, por lo tanto, corresponderán a un conjunto limitado en número y contenido, de tal forma que sea evaluable y verificable su logro.', '24'),
('b25', 'El alcance de los conceptos de equidad, diversidad e inclusión.', '25'),
('b26', 'Las directrices para la promoción de la ética de la investigación, innovación, o creación artística y cultural y su práctica responsable.', '26'),
('b27', 'Descripción de los mecanismos y sistemas para la gestión de la información que faciliten la planeación, el monitoreo y la evaluación de las actividades institucionales y la toma de decisiones relacionadas con las labores formativas, académicas, docentes, cientificas, culturales y de extensión, garantizando que la información sea veraz, oportuna, precisa, completa y confiable.', '27'),
('b28', 'La estructura organizacional que atienda los procesos y soporte las decisiones que se toman en las instancias de gobiemo; las labores académicas, docentes, formativas, Gentíficas, culturales y de extensión; y la gestión de recursos humanos, físicos, tecnológicos y financieros, en coherencia con los niveles de formación, las modalidades ofrecidas y la naturaleza jurídica, tipología, identidad y misión institucional.', '28'),
('b29', 'Respecto a las políticas institucionales: ', '29'),
('b3', 'Estructura administrativa y académica', '3'),
('b30', 'Mecanismos para la articulación de los procesos de evaluación institucional y de la comunidad académica. ', '30'),
('b32', 'Respecto al sistema interno de aseguramiento de la calidad: ', '32'),
('b33', 'Mecanismos que faciliten ta formulación, divulgación y actualización de las políticas indicadas en el literal anteñor.', '33'),
('b35', 'Mecanismos para promover la participación de los egresados en los procesos de autoevaluación y mejoramiento institucional.', '35'),
('b36', 'Evidencia de la divulgación y actualización de las políticas que promuevan el seguimiento a la actividad profesional de los egresados.', '36'),
('b37', 'Articulación de procesos organizacionales y cargos para soportar el modelo de bienestar.', '37'),
('b38', 'Proyección de actividades y recursos humanos, físicos y financieros requeridos para la prevención de la deserción y la promoción de la graduación de los estudiantes.', '38'),
('b39', 'Descripción de los programas orientados a la prevención de la deserción y a la promoción de la graduación de los estudiantes, y los avances relacionados, que incluya, por lo menos: ', '39'),
('b40', 'Proyectar los instrumentos de planeación que hacen posible la materialización de la misión, los propósitos y los objetivos institucionales. Dichos instrumentos deberán presentar las actividades y los recursos previstos (financieros, físicos y humanos) para su desarrollo.', '40'),
('b41', 'Procesos para la inducción de su talento humano, en coherencia con su naturaleza jurídica, tipología, identidad y misión institucional.', '41'),
('b42', 'Proyección de los requerimientos de infraestructura física y tecnológica para atender la dinámica cambiante de las labores formativas, académicas, docentes, científicas, culturales y de extensión.', '42'),
('b43', 'Espacios o ambientes físicos o virtuales (aulas, interacción tecnológica, espacios para el aprendizaje los que hacen parte de las unidades académicas particulares o su equivalente (facultades, escuelas, centros, institutos, ente otros actividades de aprendizaje, investigación, extensi de todas las facultades, entre otros).', '43'),
('b44', 'Estrategias, programas, planes y proyectos de gestión, operación, mantenimiento, renovación y actualización de la infraestructura física y tecnológica, acorde con la cifra proyectada de estudiantes, profesores y personal administrativo, y el cumplimiento de sus propósitos y objetivos institucionales. Dichos programas, planes y proyectos deben presentar las actividades y los recursos previstos (financieros, físicos y humanos) para su desarrollo.', '44'),
('b45', 'Mecanismos de acceso por parte de profesores y estudiantes a los materiales requeridos en el proceso formativo en formato impreso y/o digital, de acuerdo con el diseño curricular.', '45'),
('b46', 'Políticas y mecanismos para la formulación, ejecución, seguimiento y control de presupuestos anuales, construidos a partir de la información suministrada por las diferentes unidades que aseguran el desarrollo de las labores formativas, académicas, docentes, científicas, culturales, de extensión y administrativas.', '46'),
('b47', 'Respecto a la gestión del talento humano:', '47'),
('b48', 'Los ajustes o modificaciones realizados a la información que fue presentada el trámite anterior de Pre radicación de solicitud de registro calificado.', '48'),
('b49', 'Evidencia del cumplimiento del reglamento estudiantil o su equivalente, respecto a: ', '49'),
('b50', 'Perfiles institucionales de los profesores actualizados a las dinámicas de la nueva vigencia de condiciones institucionales y justificación correspondiente. ', '50'),
('b51', 'Respecto a las políticas institucionales:', '51'),
('b52', 'Respecto al sistema interno de aseguramiento de la calidad: ', '52'),
('b53', 'Evolución del modelo de gestión de la información de los egresados que refleje la actualización de la misma.', '53'),
('b54', 'Resultados de los programas orientados a la prevención de la deserción y a la promoción de la graduación de los estudiantes que incluya por lo menos: ', '54'),
('b55', ' Proyección para los próximos 7 años de los instrumentos de planeación que hacen posible la materialización de la misión, los propósitos y los objetivos institucionales. Dichos instrumentos deberán presentar las actividades y los recursos previstos (financieros, físicos y humanos) para su desarrollo.', '55'),
('b56', 'Evidencia de los procesos para la inducción del talento humano.', '56'),
('b57', 'Descripción cuantitativa del uso, apropiación, desarrollo, gestión, operación, mantenimiento, renovación y actualización de la infraestructura física y tecnológica en los últimos 7 años, de acuerdo con el crecimiento o decrecimiento de la población, comparada con la planeación que se tenía proyectada para el mismo periodo, con la respectiva justificación en las diferencias significativas.', '57'),
('b58', 'Resultados de las políticas y mecanismos de obtención, gestión y control de recursos financieros.', '58'),
('b8', 'Condiciones para obtener distinciones e incentivos', '8'),
('c12', 'Las políticas sobre reingresos, retiros, cambios de programas u otros que impliquen alguna decisión institucional al respecto.', '12'),
('c13', 'Evidencia del cumplimiento del reglamento estudiantil o su equivalente, respecto a: ', '13'),
('c16', 'Criterios para establecer la dedicación, disponibilidad y permanencia de los profesores que desarrollen las labores formativas, académicas, docentes, científicas, culturales y de extensión, y para aquellos que desarrollen actividades relacionadas con procesos administrativos.', '16'),
('c17', 'Procesos de seguimiento al análisis y valoración periódica de la asignación de las actividades de los profesores a nivel institucional, con la posibilidad de poder ajustarlas a medida que cambien las condiciones institucionales.', '17'),
('c18', 'Perfiles institucionales de los profesores.', '18'),
('c20', 'Contar con procesos para la aprobación de cambios que tengan implicaciones en la identidad, tipología y misión institucional.', '20'),
('c24', 'En cuanto a créditos y actividades académicas: establecer las directrices a nivel institucional para la definición de la relación entre las horas de interacción con el profesor y las horas de trabajo independiente; la definición de actividades académicas, incluyendo el desarrollo de las que se materializan en actividades de laboratorio, pasantías, prácticas y otras que se requieran para el desarrollo de los programas académicos y el logro de los resultados de aprendizaje.', '24'),
('c25', 'La gestión y asignación de los recursos institucionales para el desarrollo de políticas de bienestar.', '25'),
('c26', 'Las directrices para la promoción de un ambiente para el desarrollo de la ciencia, la tecnología, la innovación o la creación artística y cultural', '26'),
('c27', 'Procedimientos para el registro de información actualizada, en los sistemas de información que administren el Ministerio de Educación Nacional y el Ministerio de Ciencia y Tecnología e Innovación, de acuerdo con los requerimientos de los mismos en cuanto a periodicidad y tiempos de suministro.', '27'),
('c28', 'La definición de cargos en número y funciones en coherencia con los procesos y la estructura organizacional definida, de tal forma que permita la evaluación del logro de los objetivos para los cuales fueron creados.', '28'),
('c29', 'Respecto a la gestión de información: ', '29'),
('c3', 'Cultura de la autoevaluación', '3'),
('c33', 'Modelo de gestión que incluya un sistema de información para administrar los datos que permiten soportar la interacción con los egresados y hacer seguimiento a su actividad profesional, desempeño laboral y/o emprendimientos, y todo aquello que dé cuenta d isió identi vd q e la misión e identidad institucional.', '33'),
('c36', 'Descripción del modelo de gestión de la información de los egresados incluyendo los mecanismos de actualización de la información.', '36'),
('c37', 'El conjunto de servicios de bienestar en procura del desarrollo integral y la convivencia de la comunidad institucional.', '37'),
('c38', 'Apoyo financiero a estudiantes cuando así se requiera y cuando la institución disponga de los recursos para dar alcance a los programas propuestos.', '38'),
('c40', 'Acoger en su misión institucional las necesidades de la sociedad e identificar a los estudiantes, profesores y la comunidad a la que espera servir. Lo anterior, en coherencia con su proyecto educativo institucional, o lo que haga sus veces.', '40'),
('c41', 'Procesos para la inducción de su talento humano, en coherencia con su naturaleza jurídica, tipología, identidad y misión institucional.', '41'),
('c42', 'Proyecciones de los requerimientos para atender el desarrollo de las actividades de bienestar, de acuerdo con la naturaleza jurídica, identidad, tipología y misión institucional, que prevea la proyección de la población.', '42'),
('c43', 'Espacios físicos o virtuales de apoyo a las labores formativas, académicas, docentes, científicas, culturales y de extensión (centros de recursos de aprendizaje, bibliotecas, espacios de cómputo, oficinas para la docencia (profesores, monitores, investigadores) entre otros.', '43'),
('c44', 'Estrategias y mecanismos para avanzar gradualmente en las condiciones de accesibilidad de la comunidad educativa, de acuerdo con la normatividad vigente en Colombia.', '44'),
('c45', 'Los recursos necesarios en los ambientes de aprendizaje para facilitar las actividades de formación deseadas.', '45'),
('c46', 'Criterios para la asignación y ejecución de recursos financieros a las diferentes unidades, los cuales deberán promover las condiciones de calidad institucional y de programa.', '46'),
('c47', 'Respecto a los recursos físicos y tecnológicos:', '47'),
('c48', 'La actualización de planes, proyectos y programas para los siguientes 7 años incluyendo recursos humanos, físicos y financieros que se estiman utilizar', '48'),
('c49', 'Evidencia de los requisitos y criterios para los procesos de inscripción, admisión, ingreso, matrícula, evaluación y graduación de estudiantes.', '49'),
('c50', 'Descripción del grupo profesoral vigente que incluya información de su composición respecto a dedicación, vinculación y disponibilidad.', '50'),
('c51', 'Respecto a la gestión de la información:', '51'),
('c53', 'Descripción cuantitativa de la ejecución y resultados de los planes o programas para el seguimiento a la actividad profesional de los egresados en los últimos 7 años, comparada con los planes o programas que se tenían proyectados para el mismo periodo, con la respectiva justificación en las diferencias significativas.', '53'),
('c56', 'Resultados de los procesos para la evaluación periódica de las contrataciones, los nombramientos, el desempeño y la retención del talento humano.', '56'),
('c57', 'Evaluación y ajuste de la planeación de los últimos 7 años y proyección para los próximos 7 años, del uso, apropiación, desarrollo, gestión, operación, mantenimiento, renovación y actualización de la infraestructura física y tecnológica para atender las labores formalivas, académicas, docentes, científicas, culturales y de extensión, así como para atender las actividades de bienestar desarrolladas por la población que hace parte de la comunidad institucional, y que prevea los recursos (financieros, físicos y humanos) para su desarrollo.', '57'),
('c58', 'Evaluación y ajustes a los procesos de la planeación financiera de corto, mediano y largo plazo.', '58'),
('c8', 'Políticas, criterios, requisitos y procesos de inscripción, admisión, ingreso, reingreso, transferencias, matrícula y evaluación', '8'),
('d12', 'Trabajo académico autónomo del estudiante y de interacción con el profesor, representado en créditos académicos.', '12'),
('d13', 'Políticas para mejorar el bienestar, la permanencia y graduación de los estudiantes', '13'),
('d16', 'Condiciones para apropiar y desplegar la cultura de la autoevaluación.', '16'),
('d17', 'Programas de desarrollo de competencias pedagógicas, tecnológicas y de investigación, innovación y/o creación artística y cultural, de acuerdo con los niveles de formación y las modalidades ofertadas, en coherencia con la naturaleza jurídica, tipología, identidad y misión institucional.', '17'),
('d18', 'Descripción del grupo profesoral vigente que incluya información de su composición respecto a dedicación, vinculación y disponibilidad.', '18'),
('d20', 'Contar con procesos para soportar el sistema interno de aseguramiento de la calidad y planeación institucional.', '20'),
('d25', 'El desarrollo de actividades culturales, deportivas, de salud mental y física, y demás dirigidas a toda la comunidad académica e institucional.', '25'),
('d26', 'Las directrices para la disposición de recursos humanos, tecnológicos y financieros en el dosarrollo de la investigación, innovación o la creación artística y cultural, en coherencia con los programas y las modalidades que ofrece.', '26'),
('d28', 'Los mecanismos para la evaluación y actualización de procesos, estructura organizacional y cargos.', '28'),
('d29', 'Respecto a la arquitectura institucional: ', '29'),
('d3', 'Programa de egresados', '3'),
('d33', 'Mecanismos para la actualización de la información de los egresados.', '33'),
('d36', 'Descripción de los planes y programas para el seguimiento a la actividad profesional de los egresados.', '36'),
('d37', 'Mecanismos de comunicación y de difusión de los servicios disponibles a la comunidad institucional.', '37'),
('d38', 'Acompañamiento de manera efectiva que atienda las necesidades de cada de los estudiantes.', '38'),
('d40', 'Considerar en sus objetivos, cuando ofrezca programas académicos en más de una modalidad y en más de un lugar de desarrollo, las particularidades que esto genera a la dinámica institucional.', '40'),
('d42', 'Permisos de autorización expresa de la autoridad competente para el uso del suelo y de la infraestructura que dispondrá la institución para el desarrollo de sus actividades administrativas y académicas.', '42'),
('d43', 'Espacios para los servicios institucionales (cafeterías, espacios comerciales, entre otros).', '43'),
('d46', 'Mecanismos de divulgación de las políticas relacionadas en los anteriores literales del presente artículo.', '46'),
('d47', 'Respecto a los recursos financieros: ', '47'),
('d48', 'Las evidencias e indicadores que se señalan en el presente título.', '48'),
('d49', 'Resultados de la implementación de los procesos de acompañamiento de estudiantes, en donde se vea el impacto en su permanencia y graduación, y se entienda la composición de la población estudiantil en términos de las variables establecidas por la institución, según la información cualitativa y cuantitativa  recogida en los procesos de admisión.', '49'),
('d50', 'Descripción cuantitativa de la ejecución anual del plan de vinculación y dedicación institucional de los profesores en los últimos 7 años, comparada con el plan que se tenía proyectado para el mismo periodo con la respectiva justificación en las diferencias significativas.', '50'),
('d51', 'Respecto a la arquitectura institucional:', '51'),
('d53', 'Proyecciones para los próximos 7 años de los planes o programas para el seguimiento a la actividad profesional de los egresados.', '53'),
('d57', 'Permisos de autorización expresa de la autoridad competente para el uso del suelo y de la infraestructura con la que disponga la institución para el desarrollo de sus actividades administrativas y académicas.', '57'),
('d58', 'Ejecución de la planeación financiera en los últimos siete años comparada con la planeación financiera que se tenía proyectada para el mismo período con la respectiva justificación en las diferencias significativas.', '58'),
('d8', 'Régimen disciplinario', '8'),
('e12', 'Políticas o lo que haga sus veces, sobre evaluación y permanencia.', '12'),
('e13', 'Evidencia de los requisitos y criterios para los procesos de inscripción, admisión, \r\ningreso, matrícula, evaluación y graduación de estudiantes.', '13'),
('e16', 'Trayectoria profesoral, o lo que haga sus veces, indicando los criterios para la vinculación, promoción, definición de categorías, retiro y demás situaciones administrativas.', '16'),
('e17', 'Sistema de seguimiento, evaluación y retroalimentación a los profesores, en coherencia con las labores formativas, docentes, académicas, científicas, culturales y de extensión, y con el nivel y las modalidades en las que se ofrezcan los programas académicos.', '17'),
('e18', 'Proyecciones, para los próximos 7 años, del plan de vinculación y dedicación institucional de los profesores.', '18'),
('e25', 'El desarrollo de actividades de gestión necesarias para cumplir los propósitos institucionales. ', '25'),
('e26', 'La realamentación de propiedad intelectual.', '26'),
('e3', 'Modelo de bienestar', '3'),
('e33', 'F lanes 2 programas para el seguimiento a la actividad profesional de los egresados que especifiquen las actividades y recursos (financieros, humanos y fisicos) previstos para el desarrollo de estos.', '33'),
('e36', 'Resultados de los planes o programas para el seguimiento a la actividad profesional de los egresados, en caso que la institución cuente con egresados.', '36'),
('e37', 'Mecanismos para evaluar los servicios de bienestar por parte de la comunidad \r\ninstitucional.', '37'),
('e38', 'Interacción sistemática entre estudiantes y entre profesores y estudiantes.', '38'),
('e43', 'Espacios de bienestar para la comunidad institucional, sean cubiertos (áreas deportivas, culturales, entre otros) o descubiertos (canchas, zonas verdes, entre otros).', '43'),
('e46', 'Mecanismos para la obtención de recursos financieros.', '46'),
('e49', 'Retroalimentación a los estudiantes e implementación de acciones basadas en \r\nlas evaluaciones establecidas.', '49'),
('e50', 'Proyecciones para los próximos 7 años del plan de vinculación y dedicación de profesores para el periodo objeto de la renovación.', '50'),
('e53', 'Resultados de la oferta de programas de formación en diferentes dimensiones del desarrollo personal y profesional de los egresados.', '53'),
('e57', 'Evidencias que demuestren que la institución cumple con la normatividad vigente relacionada con regulaciones ambientales, de seguridad de sismorresistencia y de accesibilidad, y con condiciones físicas como ventilación, iluminación y mobiliario, de acuerdo con el tamaño y características de la población que está vinculada a la institución.', '57'),
('e58', 'Proyección para el año en curso y los próximos 7 años de la planeación financiera de acuerdo con la naturaleza jurídica de la institución.', '58'),
('e8', 'Homologación y reconocimiento de aprendizajes entre programas de la misma institución o de otras instituciones (nacionales y/o extranjeras)', '8'),
('f12', 'Requisitos de grado.', '12'),
('f13', 'Información cualitativa y cuantitativa para mejorar el bienestar, la permanencia \r\ny la graduación de los estudiantes en la institución.', '13'),
('f16', 'Impedimentos, inhabilidades, incompatibilidades, conflicto de intereses y \r\nrégimen disciplinario.', '16'),
('f18', 'Reglamento profesoral o su equivalente.', '18'),
('f26', 'La roquiación de convenios y asociaciones relacionadas con el desarrollo de la investigación, innovación o creación artística y cultural.', '26'),
('f3', 'Recursos suficientes para garantizar el cumplimiento de las metas', '3'),
('f33', 'Planes o programas para fomentar la red colaborativa de egresados y de estos con la sociedad.', '33'),
('f36', 'Descripción de la oferta de programas de formación en diferentes dimensiones del desarrollo personal y profesional de sus egresados.', '36'),
('f37', 'Mecanismos de gestión de peticiones, quejas y reclamos de la comunidad institucional.', '37'),
('f43', 'Otros espacios o ambientes, físicos o virtuales, que atiendan las particularidades de la institución y que no hayan sido descritos anteriormente.', '43'),
('f49', 'Resultados de las acciones frente a la deserción por cohorte y por periodo.', '49'),
('f50', 'Evidencia del cumplimiento de las directrices del reglamento profesoral o su equivalente, respecto a: ', '50'),
('f53', 'Evidencia del uso de medios de comunicación de la oferta formativa en cuanto a cursos de educación continua o programas de educación superior que sean pertinentes para los egresados de la institución.', '53'),
('f57', 'Descripción cualitativa y cuantitativa de la ejecución de las estrategias, programas, planes y proyectos de gestión, operación, mantenimiento, renovación y actualización de la infraestructura física y tecnológica en los últimos 7 años, comparada con las estrategias, programas, planes y proyectos que tenía proyectados la institución para el mismo periodo, con la respectiva justificación en las diferencias significativas', '57'),
('f58', 'Resultados comparativos de la formulación y la ejecución del presupuesto tanto de funcionamiento como inversión discriminados por rubro y por función misional de al menos los últimos 7 años.', '58'),
('f8', 'Requisitos de grado', '8'),
('g12', 'Estrategias de acompañamiento en su proceso formativo que involucre temas académicos u otros que la institución provea para el desarrollo de los estudiantes.', '12'),
('g13', 'Retroalimentación a los estudiantes e implementación de acciones basadas en \r\nlas evaluaciones establecidas.', '13'),
('g16', 'Todo aquello que, desde la naturaleza jurídica, tipología, identidad y misión \r\ninstitucional, tenga implicaciones en el desarrollo profesoral.', '16'),
('g18', 'Descripción de los procesos de selección, vinculación, desarrollo y desvinculación de los profesores.', '18'),
('g26', 'Las directrices generales para el registro de publicaciones y resultados de investigación, innovación o creación artistica y cultural, en los sistemas de información institucional, nacional e internacional.', '26'),
('g36', 'Descripción de los medios de comunicación de la oferta formativa en cuanto a cursos de educación continua o programas académicos de educación superior que sean pertinentes para los egresados de la institución.', '36'),
('g49', 'Evidencia de la implementación de los procesos para garantizar que la información entregada y publicada, es veraz, confiable, accesible y oportuna.', '49'),
('g50', 'Evidencia de uso de medios de comunicación con los profesores que les permita conocer todos sus deberes y derechos.', '50'),
('g53', 'Resultados de la integración de las percepciones y experiencias de la actividad profesional de sus egresados a la reflexión acerca del desarrollo institucional.', '53'),
('g57', ' Indicadores relacionados con el cumplimiento de las estrategias, programas, planes y proyectos de gestión, operación, mantenimiento, renovación y actualización de la infraestructura física y tecnológica.', '57'),
('g58', 'Presupuesto institucional del año en curso y proyectado para los siguientes 7 años con sus respectivos mecanismos de control tanto en funcionamiento como inversión discriminados por rubro y por función misional de acuerdo con la naturaleza jurídica de la institución.', '58'),
('h12', 'Servicios de apoyo al estudiante, en coherencia con los niveles y las modalidades ofrecidas, y otros que promuevan su permanencia y graduación.', '12'),
('h13', 'Estudios que permitan implementar acciones frente a la deserción por cohorte \r\ny por periodo.', '13'),
('h18', 'Evidencia del cumplimiento de las directrices del reglamento profesoral o su equivalente y los demás documentos debidamente aprobados por las autoridades o instancias competentes de la institución, respecto a: ', '18'),
('h36', 'Descripción de mecanismos para integrar los resultados de las percepciones y experiencias de la actividad profesional de sus egresados a la reflexión acerca del desarrollo institucional.', '36'),
('h49', 'Seguimiento a los resultados de los procesos de inscripción, admisión, ingreso, matrícula, evaluación y graduación de estudiantes y análisis de los mismos a la luz de la naturaleza jurídica, tipología, identidad y misión institucional.', '49'),
('h50', 'Seguimiento a indicadores anuales para los últimos 7 años asociados a la selección, vinculación, desarrollo y desvinculación de los profesores.', '50'),
('h53', 'Resultados de la participación de los egresados en los procesos de autoevaluación y mejoramiento.', '53'),
('h57', 'Proyección para los próximos 7 años de estrategias, programas, planes y proyectos de gestión, operación, mantenimiento, renovación y actualización de la infraestructura física y tecnológica, que incluyan actividades y recursos previstos para su desarrollo.', '57'),
('h58', 'Evidencia de que la institución reporta la información financiera que reposa en sus documentos oficiales a los sistemas nacionales de información.', '58'),
('i13', 'Descripción de los procesos para garantizar que la información entregada y \r\npublicada sea veraz, confiable, accesible y oportuna.', '13'),
('i18', 'Evidencia del uso de medios de comunicación con los profesores que les permita conocer sus deberes y derechos.', '18'),
('i36', 'Descripción de mecanismos para promover la participación de los egresados en los procesos de autoevaluación y mejoramiento.', '36'),
('i49', 'Evidencia de la implementación de los mecanismos que permitan verificar y asegurar que la identidad de quien cursa el programa corresponde a la del estudiante matriculado.', '49'),
('i50', 'Evidencias de la implementación de los procesos de inducción profesoral.', '50'),
('i53', 'Descripción cuantitativa de la ejecución y resultados de los planes o programas para fomentar la red colaborativa de egresados y de estos con la sociedad en los últimos 7 años, comparada con los planes o programas que se tenían proyectados para el mismo periodo.', '53'),
('i57', 'Evidencias e indicadores relacionados con el cumplimiento de estrategias y mecanismos para avanzar gradualmente en las condiciones de accesibilidad de la comunidad educativa, de acuerdo con la normatividad vigente. ', '57'),
('i58', 'Evidencia del cumplimiento de los criterios para la asignación y ejecución de recursos financieros a las diferentes unidades. ', '58'),
('j13', 'Seguimiento a los resultados de los procesos de inscripción, admisión, ingreso, matrícula, evaluación y graduación de estudiantes, y análisis de los mismos a la luz de la naturaleza jurídica, tipología, identidad y misión institucional.', '13'),
('j18', 'Descripción de los procesos de inducción profesoral.', '18'),
('j36', 'Descripción de los planes o programas para fomentar la red colaborativa de egresados y de estos con la sociedad.', '36'),
('j50', 'Resultados de la implementación de los procesos de seguimiento al análisis y valoración periódica de la asignación de actividades a los profesores.', '50'),
('j57', 'Evidencias e indicadores relacionados con el cumplimiento de los procesos de asignación de la infraestructura física y tecnológica a la comunidad para su uso, de manera que se garantice su disponibilidad.', '57'),
('k13', 'Descripción de los mecanismos que permitan verificar y asegurar que la identidad de quien cursa el programa corresponda a la del estudiante matriculado.', '13'),
('k18', 'Descripción de los procesos de seguimiento al análisis y valoración periódica de la asignación a las actividades de los profesores.', '18'),
('k50', 'Resultados de la implementación de los programas de desarrollo profesoral.', '50'),
('k57', 'Evidencias e indicadores acerca del uso de la infraestructura física y tecnológica.', '57'),
('l18', 'Descripción de los programas de desarrollo de competencias pedagógicas, tecnológicas y de investigación, innovación y/o creación artística y cultural.', '18'),
('l50', 'Resultados de la implementación del sistema de seguimiento, evaluación y retroalimentación a los profesores.', '50'),
('l57', 'Evidencias que demuestren que la institución cuenta con las licencias para uso de los recursos, conforme a la normatividad vigente sobre propiedad intelectual.', '57'),
('m18', 'Resultados de la implementación de los programas de desarrollo profesoral.', '18'),
('m57', 'Cuando aplique, evidencia del cumplimiento de los acuerdos de voluntades, convenios o contratos presentados para demostrar la disponibilidad de la infraestructura física y tecnológica en la última solicitud o renovación de condiciones institucionales.', '57'),
('n18', 'Descripción del sistema de seguimiento, evaluación y retroalimentación a los profesores', '18'),
('n57', 'Cuando aplique, los acuerdos de voluntades, convenios o contratos utilizados para demostrar la disponibilidad de la infraestructura física y tecnológica deberán incluir en sus cláusulas los alcances de la disponibilidad de esta infraestructura en términos de horarios y capacidad, por lo menos, durante la vigencia del concepto favorable de las condiciones institucionales.', '57'),
('o18', 'Resultado de la última evaluación y retroalimentación realizada a los profesores.', '18'),
('o57', 'Resultados de la implementación de los mecanismos de acceso por parte de profesores y estudiantes a los materiales requeridos en el proceso formativo.', '57'),
('p57', 'Indicadores relacionados con la utilización de recursos necesarios en los ambientes de aprendizaje para facilitar las actividades de formación deseadas.', '57'),
('q57', 'Proyección para los próximos 7 años de los recursos necesarios en los ambientes de aprendizaje, para facilitar las actividades de formación deseadas.', '57');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblnumeral`
--

CREATE TABLE `tblnumeral` (
  `id` varchar(10) NOT NULL,
  `descripcion` varchar(1000) NOT NULL,
  `fkidliteral` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblnumeral`
--

INSERT INTO `tblnumeral` (`id`, `descripcion`, `fkidliteral`) VALUES
('10a39', 'Descripción de las estrategias de acceso de estudiantes a los servicios de bienestar en la institución y en las empresas, organizaciones u otros entes que hagan parte del proceso formativo, cuando se trate de modalidad dual O cuando los programas contengan actividades como prácticas académicas o pasantías en lugares diferentes a la institución.', 'a39'),
('10b32', 'Plan de mejoramiento institucional actualizado o instrumento equivalente.', 'b32'),
('10c47', 'Descripción de los mecanismos de acceso por parte de profesores y estudiantes a los materiales requeridos en el proceso formativo.', 'c47'),
('11a39', ' Descripción de la articulación de los procesos organizacionales y cargos para soportar el modelo de bienestar.', 'a39'),
('11b32', ' Resultados de la articulación de los planes de mejoramiento con los procesos de planeación de largo, mediano y corto plazo, y el presupuesto general de la institución.', 'b32'),
('11c47', 'Descripción de los recursos necesarios en los ambientes de aprendizaje para facilitar las actividades de formación e interacción.', 'c47'),
('12c47', 'Proyección, para los próximos 7 años, de los recursos necesarios en los ambientes de aprendizaje para facilitar las actividades de formación e interacción.', 'c47'),
('1a20', 'Definición de los órganos de gobierno y sus respectivas funciones.', 'a20'),
('1a29', 'Definición del modelo de gobierno institucional.', 'a29'),
('1a32', 'Políticas que promuevan los procesos de autoevaluación, autorregulación y mejoramiento.', 'a32'),
('1a39', 'Política de bienestar para la comunidad institucional.', 'a39'),
('1a47', 'Misión, propósitos y objetivos institucionales, y mecanismos para su correspondiente actualización.', 'a47'),
('1a51', 'Evidencias del cumplimiento de las directrices del modelo de gobierno institucional respecto a: ', 'a51'),
('1a52', 'Resultados de la implementación de las políticas y estrategias que promuevan los procesos de autoevaluación, autorregulación y mejoramiento.', 'a52'),
('1a54', 'Descripción de los servicios de bienestar que ofrece a la comunidad institucional, actualizada a las dinámicas de la nueva vigencia de condiciones institucionales.', 'a54'),
('1b29', 'Descripción y resultados de los procedimientos institucionales para la formulación, aprobación, comunicación y actualización de los reglamentos internos.', 'b29'),
('1b32', 'Descripción general del sistema interno de aseguramiento de la calidad.', 'b32'),
('1b39', 'Evolución y análisis de tendencias de la deserción institucional, teniendo en cuenta las definiciones de deserción en los sistemas de información de la educación superior.', 'b39'),
('1b47', 'Políticas y descripción de los procesos para atraer, vincular, desarrollar, \r\nevaluar, retener y desvincular el talento humano.', 'b47'),
('1b49', 'Derechos y deberes de los estudiantes.', 'b49'),
('1b51', 'Resultados de los procedimientos institucionales para la formulación, aprobación, comunicación y actualización de los reglamentos internos.', 'b51'),
('1b52', 'Resultados de la implementación del sistema interno de aseguramiento de la calidad, en términos de: ', 'b52'),
('1b54', 'Evolución y análisis de las tendencias de deserción institucional de al menos los últimos 7 años, teniendo como referente los sistemas nacionales de información y las definiciones establecidas por el Ministerio de Educación Nacional.', 'b54'),
('1c13', 'Derechos y deberes de los estudiantes.', 'c13'),
('1c29', 'Marco normativo institucional comunicaciones internas.', 'c29'),
('1c47', 'Descripción y valoración cuantitativa y cualitativa de la infraestructura \r\nfísica y tecnológica.', 'c47'),
('1c51', 'Evidencias del cumplimiento del marco normativo institucional para la gestión de información y las comunicaciones internas. ', 'c51'),
('1d29', 'Descripción general de los procesos que soportan el desarrollo de la institución.', 'd29'),
('1d47', 'Políticas, y mecanismos para la obtención, planificación, gestión y control de recursos financieros.', 'd47'),
('1d51', 'Descripción general de los procesos que soportan el desarrollo de la institución, actualizados a las dinámicas de la nueva vigencia de condiciones institucionales.', 'd51'),
('1f50', 'Deberes, derechos y obligaciones.', 'f50'),
('1h18', 'Deberes, derechos y obligaciones.', 'h18'),
('2a20', 'Definición de los demás órganos colegiados y sus atribuciones.', 'a20'),
('2a29', 'Proyecto educativo institucional o el que haga sus veces.', 'a29'),
('2a32', 'Resultados de la implementación de las políticas y estrategias que promuevan los procesos de autoevaluación, autorregulación y mejoramiento.', 'a32'),
('2a39', 'Descripción de los servicios de bienestar que ofrece a la comunidad institucional.', 'a39'),
('2a47', 'Proyección anual de los instrumentos de planeación que hacen posible la materialización de la misión, los propósitos y los objetivos institucionales, en el proceso de planeación previsto.', 'a47'),
('2a51', 'Resultados de la implementación de procesos de aprobación de cambios \r\nque tengan implicaciones en la identidad, tipología y misión institucional.', 'a51'),
('2a52', 'Resultados de la implementación de los mecanismos para la articulación de los procesos de evaluación institucional y los de cada uno de los integrantes que hacen parte de la comunidad institucional.', 'a52'),
('2a54', 'Indicadores del uso de los servicios de bienestar ofrecidos a la comunidad institucional.', 'a54'),
('2b29', 'Resultados del seguimiento al cumplimiento de los procedimientos institucionales para la formulación, aprobación, comunicación y actualización de los reglamentos internos a través de las instancias competentes.', 'b29'),
('2b32', 'Descripción de la sistematización, gestión y uso de la información para desarrollar medidas de mejoramiento, que incorpore  la información registrada en los sistemas de información de las diferentes entidades estatales.', 'b32'),
('2b39', 'Análisis de las causas de la deserción institucional, teniendo como referente los sistemas nacionales de información y las definiciones \r\nestablecidas por el Ministerio de Educación Nacional.', 'b39'),
('2b47', 'Descripción de los procesos para la inducción del talento humano.', 'b47'),
('2b49', 'Condiciones para obtener distinciones e incentivos.', 'b49'),
('2b51', 'Resultados del seguimiento al cumplimiento de los procedimientos internos para la formulación, aprobación, comunicación y actualización de los reglamentos intemos a través de las instancias competentes.', 'b51'),
('2b52', 'Resultados de la articulación de los planes de mejoramiento con los procesos de planeación de largo, mediano y corto plazo, y con el presupuesto general de la institución.', 'b52'),
('2b54', 'Análisis de las causas de deserción institucional con énfasis en los últimos 7 años.', 'b54'),
('2c13', 'Condiciones para obtener distinciones e incentivos.', 'c13'),
('2c29', 'Descripción de los mecanismos y sistemas para la gestión de la información.', 'c29'),
('2c47', 'Planeación, para los próximos 7 años, del uso, apropiación, desarrollo, gestión, operación, mantenimiento, renovación y actualización de la infraestructura física y tecnológica, para atender las labores formativas, académicas, docentes, científicas, culturales y de extensión, así como para atender las actividades de bienestar desarrolladas por la población que hace parte de la comunidad institucional, que prevea los recursos (financieros, físicos y humanos) para su desarrollo.', 'c47'),
('2c51', 'Evidencias de la implementación de mecanismos y sistemas para la gestión de la información.', 'c51'),
('2d29', 'Descripción de la estructura organizacional aprobada.', 'd29'),
('2d47', 'Descripción de los mecanismos de divulgación de las políticas financieras.', 'd47'),
('2d51', 'Resultados de la evaluación de procesos, cargos y funciones.', 'd51'),
('2f50', 'Criterios, requisitos y procesos para la selección, vinculación, otorgamiento de distinciones y estímulos, evaluación de desempeño y desvinculación.', 'f50'),
('2h18', 'Criterios, requisitos y procesos para la selección, vinculación, otorgamiento de distinciones y estímulos, evaluación de desempeño y desvinculación.', 'h18'),
('3a20', 'Definición del quorum en los órganos decisorios.', 'a20'),
('3a29', 'Descripción de los procesos para la aprobación de cambios que tengan implicaciones en la identidad, tipología y misión institucional.', 'a29'),
('3a32', 'Descripción de mecanismos para la articulación de los procesos de evaluación institucional y de la comunidad académica.', 'a32'),
('3a39', 'Indicadores del uso de los servicios de bienestar ofrecidos a la comunidad Institucional.', 'a39'),
('3a51', 'Evidencia de la implementación de los procesos que soportan el sistema \r\nde aseguramiento interno de la calidad y la planeación institucional.', 'a51'),
('3a54', 'Evidencia de la implementación de los mecanismos de comunicación y de difusión de los servicios disponibles para la comunidad institucional.', 'a54'),
('3b29', 'Evidencias de la utilización de los medios dispuestos para que la comunidad académica tenga claridad de las instancias competentes y los procedimientos para la formulación, aprobación, comunicación y actualización de los reglamentos internos.', 'b29'),
('3b32', 'Definición de los criterios de calidad frente a los cuales se puede determinar el logro de los propósitos establecidos.', 'b32'),
('3b39', 'Descripción de las estrategias que fueron consideradas para reducir la deserción.', 'b39'),
('3b47', 'Descripción de los procesos para la evaluación regular de las contrataciones, los nombramientos, el desempeño y la retención del talento humano.', 'b47'),
('3b49', 'Políticas, criterios, requisitos y procesos de inscripción, admisión, ingreso, reingreso, transferencias, matrícula y evaluación.', 'b49'),
('3b51', 'Evidencias de la utilización de los medios dispuestos para que la comunidad académica tenga claridad de las instancias competentes y los procedimientos para la formulación, aprobación, comunicación y actualización de los reglamentos internos.', 'b51'),
('3b54', 'Descripción cualitativa y cuantitativa de la ejecución y resultados de las actividades y recursos para la prevención de la deserción y la promoción de la graduación de los estudiantes en los últimos 7 años, comparada con las actividades y recursos que se tenían proyectadas para el mismo periodo, con la respectiva justificación de las diferencias significativas.', 'b54'),
('3c13', 'Políticas, criterios, requisitos y procesos de inscripción, admisión, ingreso, reingreso, transferencias, matrícula y evaluación.', 'c13'),
('3c29', 'Procedimientos para el suministro periódico y actualizado de la información a los sistemas nacionales de información.', 'c29'),
('3c47', 'Permisos y autorizaciones expresas de la autoridad competente para el uso de la infraestructura y del suelo, que deberá disponer la institución para el desarrollo de sus actividades administrativas y académicas (ocupación y altura).', 'c47'),
('3c51', 'Indicadores que demuestren que la información que facilite la planeación, monitoreo y evaluación de las actividades institucionales y la toma decisiones, es veraz, oportuna, precisa, completa y confiable.', 'c51'),
('3d29', 'Definición de cargos en número y funciones.', 'd29'),
('3d47', 'Indicadores relacionados con la ejecución de la planeación financiera, gestión y control de recursos.', 'd47'),
('3f50', 'Criterios de dedicación, disponibilidad y permanencia.', 'f50'),
('3h18', 'Criterios de dedicación, disponibilidad y permanencia.', 'h18'),
('4a20', 'Definición de las funciones, periodo y forma de elección del rector o rectores y vicerrectores, o los cargos equivalentes. ', 'a20'),
('4a29', 'Descripción de los procesos para soportar el sistema interno de aseguramiento de la calidad y la planeación institucional. ', 'a29'),
('4a39', 'Descripción de los mecanismos de comunicación y de difusión de los servicios disponibles para la comunidad institucional.', 'a39'),
('4a51', 'Evidencia de la presentación de informes de rendición de cuentas.', 'a51'),
('4a54', 'Evolución de los resultados de los procesos de evaluación de los servicios de bienestar por parte de la comunidad institucional, que brinden información de la manera en que se realizó la evaluación.', 'a54'),
('4b29', 'Políticas académicas asociadas a currículo, resultados de aprendizaje, créditos y actividades.', 'b29'),
('4b32', 'Doscripción de los mecanismos para evidenciar la evolución del cumplimiento de las condiciones de calidad de los resultados académicos.', 'b32'),
('4b39', 'Proyección semestral o anual, para los próximos 7 años, de actividades y recursos requeridos para la prevención de la deserción y la promoción de la graduación de los estudiantes.', 'b39'),
('4b47', 'Resultado de la última evaluación y retroalimentación realizada al desempeño del talento humano.', 'b47'),
('4b49', 'Régimen disciplinario. ', 'b49'),
('4b51', 'Evidencia de la implementación de las políticas académicas asociadas a currículo, resultados de aprendizaje, créditos y actividades, que incluya: ', 'b51'),
('4b54', 'Proyecciones para los próximos 7 años de actividades y recursos para la prevención de la deserción y la promoción de la graduación de los estudiantes.', 'b54'),
('4c13', 'Régimen disciplinario.', 'c13'),
('4c29', 'Evidencia de información actualizada en los sistemas nacionales de información y Suministrada en los tiempos requeridos por los entes respectivos.', 'c29'),
('4c47', 'Evidencias que demuestren que la institución cumple con la normatividad vigente relacionada con regulaciones ambientales, de seguridad, de sismo resistencia y de accesibilidad, y con condiciones físicas como ventilación, iluminación y mobiliario, de acuerdo con el tamaño y características de la población que está vinculada a la institución.', 'c47'),
('4c51', 'Evidencia de información actualizada en los sistemas nacionales de información y suministrada en los tiempos requeridos por los entes respectivos.', 'c51'),
('4d29', 'Descripción de los mecanismos para la evaluación y actualización de procesos, organización y cargos.', 'd29'),
('4d47', 'Proyección, para los próximos 7 años, de la planeación financiera, de acuerdo con la naturaleza jurídica de la institución.', 'd47'),
('4f50', 'Participación en procesos de autoevaluación.', 'f50'),
('4h18', 'Participación en procesos de autoevaluación.', 'h18'),
('5a20', 'Delegaciones de funciones directivas, cuando aplique.', 'a20'),
('5a29', 'Descripción de los mecanismos de rendición de cuentas.', 'a29'),
('5a39', 'Evidencia de la implementación de los mecanismos de comunicación y de difusión de los servicios disponibles para la comunidad institucional.', 'a39'),
('5a51', 'Resultados de la implementación de los mecanismos de rendición de \r\ncuentas.', 'a51'),
('5a54', 'Resultados de los procesos de gestión de peticiones, quejas y reclamos de la comunidad institucional.', 'a54'),
('5b29', 'Políticas de gestión institucional y bienestar.', 'b29'),
('5b32', 'Desenpción de los mecanismos que recojan la apreciación de la comunidad académica y de los diferentes grupos de interés y forma de sistematización de sus apreciaciones.', 'b32'),
('5b39', ' Descripción de los procesos asociados a la identificación de alertas tempranas ante las posibilidades de deserción, de acuerdo con la información cualitativa y cuantitativa de los estudiantes para mejorar su permanencia y graduación.', 'b39'),
('5b49', 'Homologación y reconocimiento de aprendizajes entre programas de la misma institución o de otras instituciones (nacionales y/o extranjeras).', 'b49'),
('5b51', 'Evidencia de la implementación de las políticas de gestión institucional y bienestar, que incluya: ', 'b51'),
('5b54', 'Resultados de los procesos asociados a la identificación de alertas tempranas ante las posibilidades de deserción de acuerdo con la información cualitativa y cuantitativa para mejorar el bienestar, la permanencia y la graduación de los estudiantes en la institución.', 'b54'),
('5c13', 'Homologación y reconocimiento de aprendizajes entre programas de misma institución o de otras instituciones (nacionales y/o extranjeras).', 'c13'),
('5c29', 'Descripción de las medidas de seguridad electrónica para la protección de datos para evitar su adulteración, pérdida, consulta, uso o acceso no autorizado o fraudulento.', 'c29'),
('5c47', 'Descripción de estrategias y mecanismos para avanzar gradualmente en las condiciones de accesibilidad de la comunidad institucional, de acuerdo con la normatividad vigente.', 'c47'),
('5c51', 'Evidencia del cumplimiento de las medidas de seguridad electrónica para la protección de datos y para evitar su adulteración, pérdida, consulta, uso o acceso no autorizado o fraudulento.', 'c51'),
('5d47', 'Resultados comparativos de la formulación y ejecución del presupuesto tanto de funcionamiento como de inversión discriminados por rubro or función misional, de al menos los últimos 2 años.', 'd47'),
('5f50', 'Trayectoria profesoral, o lo que haga sus veces.', 'f50'),
('5h18', 'Trayectoria profesoral, o lo que haga sus veces.', 'h18'),
('6a29', 'Descripción de los espacios de participación de la comunidad académica.', 'a29'),
('6a39', 'Descripción de los procesos de evaluación de los servicios de bienestar por parte de la comunidad institucional.', 'a39'),
('6a51', 'Evidencias de participación de la comunidad institucional en los diferentes espacios, al menos en el último año.', 'a51'),
('6a54', 'Evidencia de la implementación de apoyos tecnológicos y acompañamientos disponibles de manera ininterrumpida, para abordar las preguntas y los problemas de carácter técnico de los estudiantes, cuando aplique.', 'a54'),
('6b29', 'Políticas de investigación, innovación y/o creación artística y cultural, según corresponda.', 'b29'),
('6b32', 'Últimos resultados de apreciación institucional de la comunidad académica y de los diferentes grupos de interés, y evolución de los mismos, en caso de contar con la información para más de un periodo.', 'b32'),
('6b39', 'Descripción de los mecanismos de apoyo financiero a los estudiantes cuando así se requiera y cuando la institución disponga de los recursos.', 'b39'),
('6b49', 'Requisitos de grado.', 'b49'),
('6b51', 'Evidencia de la implementación de las políticas de investigación, innovación, creación artística y cultural, que incluya, por lo menos: ', 'b51'),
('6b54', 'Resultados de la ejecución de mecanismos de apoyo financiero a estudiantes, cuando así se requiera.', 'b54'),
('6c13', 'Requisitos de grado.', 'c13'),
('6c47', 'Descripción de los procesos de asignación de la infraestructura física y tecnológica a la comunidad, para su uso, de manera que se garantice su disponibilidad.', 'c47'),
('6d47', 'Presupuesto institucional del año en curso y proyectado, con sus respectivos mecanismos de control para los siguientes 7 años, tanto de funcionamiento como de inversión, discriminados por rubro y por función misional, de acuerdo con la naturaleza jurídica de la institución.', 'd47'),
('6f50', 'impedimentos, inhabilidades, incompatibilidades y conflicto de intereses.', 'f50'),
('6h18', 'impedimentos, inhabilidades, incompatibilidades y conflicto de intereses.', 'h18'),
('7a39', 'Resultados de los procesos de evaluación de los servicios de bienestar por parte de la comunidad institucional.', 'a39'),
('7a54', 'Evidencia del acceso de estudiantes a los servicios de bienestar en los escenarios práctica o espacios formativos asociados a la modalidad dual, cuando aplique.', 'a54'),
('7b32', 'Descripción del último proceso de autoevaluación y autorregulación institucional.', 'b32'),
('7b39', 'Descripción de los mecanismos de acompañamiento que atienden las necesidades de cada uno de los estudiantes de manera efectiva.', 'b39'),
('7b54', 'Evidencia de la implementación de mecanismos de interacción sistemática entre estudiantes y entre profesores y estudiantes.', 'b54'),
('7c47', 'Evidencias e indicadores acerca del uso de la infraestructura física y tecnológica.', 'c47'),
('7d47', 'Evidencia de que la institución reporta la información financiera que reposa en sus documentos oficiales, a los sistemas nacionales de información.', 'd47'),
('7f50', 'Régimen disciplinario.', 'f50'),
('7h18', 'Régimen disciplinario.', 'h18'),
('8a39', 'Descripción de los procesos de gestión de peticiones, quejas y reclamos de la comunidad institucional.', 'a39'),
('8b32', 'Descripción de los mecanismos que permiten procesos continuos de autoevaluación y autorregulación.', 'b32'),
('8b39', 'Descripción de los mecanismos de interacción sistemática entre estudiantes y entre profesores y estudiantes.', 'b39'),
('8c47', 'Evidencias que demuestren que la institución cuenta con las licencias para uso de los recursos, conforme a la normatividad vigente sobre propiedad intelectual.', 'c47'),
('9a39', 'Descripción de los apoyos tecnológicos y acompañamientos, disponibles de manera ininterrumpida para abordar las preguntas y los problemas de carácter técnico de los estudiantes, cuando aplique.', 'a39'),
('9b32', 'Ultimo informe de autoevaluación, autorregulación institucional o lo que haga sus veces, de acuerdo con su sistema intemo de aseguramiento de la calidad.', 'b32'),
('9c47', 'Cuando aplique, los acuerdos de voluntades, convenios o contratos, utilizados para demostrar la disponibilidad de la infraestructura física y tecnológica, deberán incluir en sus cláusulas, los alcances de la disponibilidad de esta infraestructura en términos de horarios y capacidad, por lo menos, durante la vigencia del concepto favorable de las condiciones institucionales.', 'c47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblparagrafo`
--

CREATE TABLE `tblparagrafo` (
  `id` varchar(10) NOT NULL,
  `descripcion` varchar(4000) NOT NULL,
  `fkidarticulo` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblparagrafo`
--

INSERT INTO `tblparagrafo` (`id`, `descripcion`, `fkidarticulo`) VALUES
('110', 'La institución deberá establecer procesos y medios orientados a la mejora del desempeño académico y la formación integral del estudiante, que le permita el tránsito de la educación secundaria o media a la educación superior, tomando como insumo la información cualitativa y cuantitativa de los estudiantes.', '10'),
('111', 'La institución deberá contar con mecanismos que permitan verificar y asegurar que la identidad de quien cursa el programa corresponda a la del estudiante matriculado.', '11'),
('113', 'Las evidencias indicadas en los literales c), e), f), 9), h), y j) del presente artículo solo deberán ser presentadas por las instituciones que estén ofreciendo al menos un programa al momento de comenzar la etapa de Pre radicación de solicitud de registro calificado.', '13'),
('117', 'Cuando la modalidad del programa implique el desarrollo de actividades académicas, formativas y docentes a cargo de empresas, entidades, organizaciones u otros entes que se vinculan al proceso formativo, la institución eberá especificar la forma de seguimiento y evaluación de sus actividades.', '17'),
('118', 'Las evidencias indicadas en los literales d), g), i), m) y o) del presente artículo solo deberán ser presentadas por las instituciones que estén ofreciendo al menos un un programa académico al momento de iniciar la etapa de Pre radicación de solicitud de registro calificado.', '18'),
('12', 'Para todos los efectos de la presente resolución, se entiende por “institución” o “instituciones”, las instituciones de educación superior y aquellas habilitadas por la ley para la oferta y desarrollo de programas académicos de educación superior. ', '2'),
('124', 'Para la definición de la relación entre las horas de interacción con el profesor y las horas de trabajo independiente, la institución deberá considerar los niveles de formación, las modalidades de ofrecimiento y las semanas con las que cuentan los periodos académicos con el fin de establecer la equivalencia y cumplir las 48 horas establecidas en el artículo 2.5.3.2.4.1 del Decreto 1075 de 2015, modificado por el Decreto 1330 de 2019.', '24'),
('127', 'La institución deberá contar con las medidas de seguridad electrónica para la protección de datos y todo lo que se necesite para evitar su adulteración, pérdida, consulta, uso o acceso no autorizado o fraudulento. ', '27'),
('128', 'Cuando la institución cuente con más de un lugar de desarrollo, modalidad y/o niveles de formación, los procesos, la estructura organizacional y los cargos deberán ser coherentes con ello.', '28'),
('129', 'Las evidencias indicadas de los numerales 2 al 4 del literal b) y el numeral 4 del literal c) del presente artículo, solo deberán ser presentadas por las  instituciones que estén ofreciendo al menos un programa académico al momento de iniciar la etapa de Pre radicación de solicitud de registro calificado. ', '29'),
('132', 'Las evidencias indicadas en el numeral 2 del literal a) y en los numerales 6, 7 y 9 al 12 dol literal b) del presente artículo solo deberán ser presentadas por las instituciones que estén ofreciendo al menos un programa académico al momento de iniciar la etapa de Pre radicación de solicitud de registro calificado.', '32'),
('136', 'Las evidencias indicadas en los literales b) y e) del presente artículo solo deberán ser presentadas por las instituciones que estén ofreciendo al menos un programa al momento de comenzar la etapa de Pre radicación de solicitud de registro calificado.', '36'),
('137', 'En el caso de que la institución ofrezca programas en modalidades a  distancia, virtual y las posibles combinaciones de estas, deberá contar con apoyos tecnológicos y acompañamientos disponibles de manera ininterrumpida, para abordar las preguntas y los problemas de carácter técnico de los estudiantes.', '37'),
('139', 'Las evidencias indicadas en los numerales 3, 5 y 7 del literal a) y los numerales 1 al 3 del literal b) del presente artículo solo deberán ser presentadas por las instituciones que estén ofreciendo al menos un programa académico al momento de iniciar la etapa de Pre radicación de solicitud de registro calificado.', '39'),
('147', 'Las evidencias indicadas en el numeral 4 del literal b), numerales 4 y 7 del literal c) y  numerales 3, 5 y 7 del literal d) del presente artículo solo deberán ser presentadas por las instituciones que estén ofreciendo al menos un programa académico al momento de iniciar la etapa de Pre radicación de solicitud de registro calificado.', '47'),
('149', 'Respecto al reglamento estudiantil o su equivalente y las políticas para mejorar el bienestar, la permanencia y graduación de los estudiantes, la institución solo deberá presentar los respectivos documentos en caso de que hayan sido modificados durante la vigencia de las condiciones institucionales, adjuntando la debida justificación. En caso de que estos documentos no hayan tenido modificaciones, la institución deberá argumentar las razones de ello.', '49'),
('150', 'Respecto al reglamento profesoral o su equivalente y los demás documentos debidamente aprobados por las autoridades o instancias competentes, la institución solo deberá presentarlos en caso de que hayan sido modificados durante la vigencia de las condiciones institucionales, adjuntando la debida justificación. En caso de que los documentos no hayan tenido modificaciones, la institución deberá argumentar las razones de ello.', '50'),
('151', 'Respecto al proyecto educativo institucional, o el que haga sus veces, y el modelo de gobierno institucional, la institución solo deberá presentados en caso de que hayan sido modificados durante la vigencia de las condiciones institucionales, adjuntando la debida justificación. En caso de que los documentos no hayan tenido modificaciones la institución deberá argumentar las razones de ello.', '51'),
('152', 'Respecto a las políticas que promuevan procesos de autoevaluación, autorregulación y mejoramiento, la institución solo deberá presentarlas en caso de que hayan sido modificadas durante la vigencia de las condiciones institucionales, adjuntando la debida justificación. En caso de que las políticas no hayan tenido modificaciones, la institución deberá argumentar las razones de ello. ', '52'),
('153', 'Respecto a las políticas que promuevan el seguimiento a la actividad profesional de los egresados, la institución solo deberá presentarlas en caso de que hayan sido modificadas durante la vigencia de las condiciones institucionales, adjuntando la debida justificación. En caso de que las politicas no hayan tenido modificaciones, la institución deberá argumentar las razones de ello.', '53'),
('154', 'Respecto a la política de bienestar para la comunidad institucional, solo deberá ser presentada en caso de que haya sido modificada durante la vigencia de las condiciones institucionales, adjuntando la debida justificación. En caso de que la política no haya tenido modificaciones, la institución deberá argumentar las razones de ello.', '54'),
('155', 'Respecto a la misión, los propósitos y objetivos institucionales solo deberán ser presentados en caso de que hayan sido modificados durante la vigencia de las condiciones institucionales, adjuntando la debida justificación. En caso de que estos no hayan tenido modificaciones, la institución deberá argumentar las razones de ello.', '55'),
('156', 'Respecto a las políticas de gestión y evaluación del talento humano, la institución solo deberá presentarlas en caso de que hayan sido modificadas durante la vigencia de las condiciones institucionales, adjuntando la debida justificación. En caso de que las políticas no hayan tenido modificaciones, la institución deberá argumentar las razones de ello.', '56'),
('157', 'Respecto a las políticas de mantenimiento, renovación y actualización de la infraestructura, la institución solo deberá presentarlas en caso de que hayan sido modificadas durante la vigencia de las condiciones institucionales, adjuntando la debida justificación. En caso de que las políticas no hayan tenido modificaciones, la institución deberá argumentar las razones de ello.', '57'),
('158', 'Respecto a las políticas para la obtención, planificación, gestión y control de los recursos financieros, y las políticas para la formulación, ejecución, seguimiento y control de presupuestos anuales, la institución solo deberá presentarlas en caso de que hayan sido modificadas durante la vigencia de las condiciones institucionales, adjuntando la debida justificación. En caso de que las políticas no hayan tenido modificaciones, la Institución deberá argumentar las razones de ello.', '58'),
('18', 'Cuando la institución desarrolle actividades con entidades, empresas, organizaciones u otros entes que participen en el plan de estudios o faciliten espacios de práctica requeridos en el mismo, el reglamento deberá definir las políticas y criterios de admisión, permanencia y evaluación, teniendo en consideración dicho asocio y de acuerdo con los resultados de aprendizaje esperados.', '8'),
('237', 'En el caso en que se desarrolle oferta académica en la modalidad dual o que los programas contengan actividades como prácticas académicas o pasantías en lugares diferentes a la institución, se deberán contemplar estrategias para que los estudiantes tengan acceso a los servicios de bienestar en la institución y en las empresas, organizaciones u otros entes que hagan parte del proceso formativo.', '37'),
('251', 'Respecto a los documentos que den cuenta acerca de las políticas académicas asociadas a currículo; los resultados de aprendizaje; los créditos y actividades  académicas; las políticas de gestión institucional y bienestar, y las políticas de investigación, innovación, creación artística y cultural, la institución solo deberá presentarlos en caso de que hayan sido modificados durante la vigencia de las condiciones institucionales adjuntando la debida justificación. En caso de que los documentos no hayan tenido modificaciones, la institución deberá argumentar las razones de ello.', '51'),
('252', 'Respecto a la descripción general del sistema interno de aseguramiento de la calidad, la institución solo deberá presentarla en caso de que haya sido modificada durante la vigencia de las condiciones institucionales, adjuntando la debida justificación. En caso de que la descripción no haya tenido modificaciones, la institución deberá argumentar las razones de ello.', '52'),
('351', 'Respecto del marco normativo institucional para la gestión de la información y  las comunicaciones internas, la institución solo deberá presentarlo en caso de que haya sido modificado durante la vigencia de las condiciones institucionales, adjuntando la debida justificación. En caso de que el marco normativo no haya tenido modificaciones, la institución deberá argumentar las razones de ello.', '51'),
('451', 'Respecto a la estructura organizacional aprobada, la institución solo deberá presentarla en caso de que haya sido modificada durante la vigencia de las condiciones institucionales, adjuntando la debida justificación. En caso de que la estructura no haya tenido modificaciones, la institución deberá argumentar las razones de ello.', '51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblrol`
--

CREATE TABLE `tblrol` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblrol`
--

INSERT INTO `tblrol` (`id`, `nombre`) VALUES
(1, 'Administrador del Sistema'),
(2, 'Verificador'),
(3, 'Validador'),
(4, 'Administrativo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblrol_usuario`
--

CREATE TABLE `tblrol_usuario` (
  `fkNomUsuario` varchar(50) NOT NULL,
  `fkIdRol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblrol_usuario`
--

INSERT INTO `tblrol_usuario` (`fkNomUsuario`, `fkIdRol`) VALUES
('Usuario.777', 2),
('Usuario.777', 3),
('Usuario.777', 4),
('USUARIO3', 1),
('USUARIO3', 3),
('USUARIO3', 4),
('USUARIO31', 2),
('USUARIO31', 3),
('USUARIO37', 2),
('USUARIO37', 3),
('USUARIO37', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblseccion`
--

CREATE TABLE `tblseccion` (
  `id` varchar(10) NOT NULL,
  `titulo` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblseccion`
--

INSERT INTO `tblseccion` (`id`, `titulo`) VALUES
('0', 'NA'),
('1', 'MECANISMOS DE SELECCIÓN Y EVALUACIÓN DE ESTUDIANTES'),
('2', 'MECANISMOS DE SELECCIÓN Y EVALUACIÓN DE PROFESORES');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblsubnumeral`
--

CREATE TABLE `tblsubnumeral` (
  `id` varchar(10) NOT NULL,
  `descripcion` varchar(1000) NOT NULL,
  `fkidnumeral` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblsubnumeral`
--

INSERT INTO `tblsubnumeral` (`id`, `descripcion`, `fkidnumeral`) VALUES
('11a51', 'Definición de los órganos de gobierno y sus respectivas funciones.', '1a51'),
('11b52', 'Implementación y uso de la información para proponer y desarrollar medidas de mejoramiento.', '1b52'),
('12a51', 'Definición de los demás órganos colegiados y sus atribuciones.', '1a51'),
('12b52', 'Definición de los criterios de calidad frente a los cuales se puede determinar el logro de los propósitos establecidos.', '1b52'),
('13a51', 'Definición del quorum de los órganos decisorios.', '1a51'),
('13b52', 'Evolución del cumplimiento de las condiciones de calidad de los resultados académicos.', '1b52'),
('14a51', 'Definición de las funciones, periodo y forma de elección del rector o rectores y vicerrectores, o los cargos equivalentes.', '1a51'),
('14b52', 'Evolución de los resultados de apreciación institucional de la comunidad académica y de los diferentes grupos de interés.', '1b52'),
('15a51', 'Delegaciones de funciones directivas, cuando aplique.', '1a51'),
('15b52', 'Descripción de los procesos de autoevaluación y autorregulación realizados durante la última vigencia de condiciones institucionales.', '1b52'),
('16b52', 'Informes de autoevaluación y autorregulación institucional realizados durante la última vigencia de condiciones institucionales.', '1b52'),
('17b52', 'Evolución de autoevaluación institucional.', '1b52'),
('18b52', 'Descripción cuantitativa de la ejecución del plan de mejoramiento institucional en los últimos 7 años, comparada con el plan de mejoramiento que se tenía proyectado para el mismo periodo con la respectiva justificación en las diferencias significativas.', '1b52'),
('19b52', 'Plan de mejoramiento institucional actualizado o el instrumento equivalente.', '1b52'),
('41b51', 'En cuanto al currículo: ', '4b51'),
('42b51', 'En cuanto a los resultados de aprendizaje: ', '4b51'),
('43b51', 'En cuanto a créditos y actividades académicas: ', '4b51'),
('51b51', 'Evidencias de la implementación de las directrices éticas que rigen a la comunidad institucional.', '5b51'),
('52b51', 'Resultados de la aplicación de los conceptos de equidad, diversidad e inclusión, según el alcance definido.', '5b51'),
('53b51', 'Evidencias e indicadores de asignación, gestión y ejecución de recursos institucionales para el desarrollo del bienestar institucional.', '5b51'),
('54b51', 'Evidencia de la implementación de orientaciones a las actividades de gestión necesarias para cumplir los propósitos institucionales.', '5b51'),
('61b51', 'Evidencias del cumplimiento de la declaración institucional expresa del énfasis de investigación, innovación, creación artística y cultural garantizando que existe la investigación necesaria que enriquece el proceso formativo y que fomenta, fortalece y desarrolla la ciencia, tecnología y la innovación.', '6b51'),
('62b51', 'Evidencias de la promoción de la ética de la investigación, innovación, creación artística y cultural, su práctica responsable y el cumplimiento de la reglamentación de propiedad intelectual. ', '6b51'),
('63b51', 'Indicadores de la disposición de recursos humanos, tecnológicos y financieros en el desarrollo de la investigación, innovación, y/o creación artística y cultural, en coherencia con los programas y las modalidades que ofrece.', '6b51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblsub_subnumeral`
--

CREATE TABLE `tblsub_subnumeral` (
  `id` varchar(10) NOT NULL,
  `descripcion` varchar(1000) NOT NULL,
  `fkidsubnumeral` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblsub_subnumeral`
--

INSERT INTO `tblsub_subnumeral` (`id`, `descripcion`, `fkidsubnumeral`) VALUES
('411b51', 'Evidencia de la implementación de principios básicos de diseño del contenido curricular y de las actividades académicas relacionadas con la formación integral.', '41b51'),
('412b51', 'Evidencia de la implementación de la forma en cómo el currículo procura la interdisciplinariedad, a partir de su contenido y de las actividades académicas.', '41b51'),
('413b51', 'Evidencia de la implementación de componentes que la institución considere necesarios para cumplir con los resultados de aprendizaje previstos.', '41b51'),
('421b51', 'Resultado de la implementación de los procesos de validación y aprobación de los resultados de aprendizaje, en coherencia con los lineamientos institucionales.', '42b51'),
('422b51', 'Resultado de la evaluación de los resultados de aprendizaje previstos para el final del proceso formativo, en coherencia con el perfil del egresado y en consonancia con los lineamientos institucionales.', '42b51'),
('431b51', 'Evidencia de la implementación de directrices institucionales para la definición de la relación entre las horas de interacción con el profesor y las horas de trabajo independiente. ', '43b51'),
('432b51', 'Evidencia del desarrollo de las actividades académicas de acuerdo con la definición institucional de las mismas.', '43b51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbltipoevidencia`
--

CREATE TABLE `tbltipoevidencia` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbltipoevidencia`
--

INSERT INTO `tbltipoevidencia` (`id`, `nombre`) VALUES
(1, 'Documento');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbltitulo`
--

CREATE TABLE `tbltitulo` (
  `id` varchar(10) NOT NULL,
  `nombre` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbltitulo`
--

INSERT INTO `tbltitulo` (`id`, `nombre`) VALUES
('1', 'OBJETO, ÁMBITO DE APLICACIÓN Y GENERALIDADES'),
('2', 'DE LAS CONDICIONES INSTITUCIONALES'),
('3', 'DE LA RENOVACIÓN DE CONDICIONES INSTITUCIONALES');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblusuario`
--

CREATE TABLE `tblusuario` (
  `nomUsuario` varchar(50) NOT NULL,
  `contrasena` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblusuario`
--

INSERT INTO `tblusuario` (`nomUsuario`, `contrasena`) VALUES
('JuanAntonio', '1234567'),
('Usuario.777', '1234567'),
('USUARIO3', '1234567'),
('USUARIO31', '1234567'),
('USUARIO37', '1234567');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoindicador`
--

CREATE TABLE `tipoindicador` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidad_de_medicion`
--

CREATE TABLE `unidad_de_medicion` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `variable`
--

CREATE TABLE `variable` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `fechacreacion` datetime NOT NULL,
  `fkemailusuario` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `variable_indicador`
--

CREATE TABLE `variable_indicador` (
  `id` int(11) NOT NULL,
  `fkidvariable` int(11) NOT NULL,
  `fkidindicador` int(11) NOT NULL,
  `dato` double NOT NULL,
  `fechadato` datetime NOT NULL,
  `fknomusuario` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `evidencia_indicador`
--
ALTER TABLE `evidencia_indicador`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cons_fkidinicador77` (`fkidindicador`),
  ADD KEY `cons_fkidevidencia77` (`fkidevidencia`),
  ADD KEY `cons_fknomusuario77` (`fknomusuario`);

--
-- Indices de la tabla `frecuencia`
--
ALTER TABLE `frecuencia`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `fuente`
--
ALTER TABLE `fuente`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `fuente_indicador`
--
ALTER TABLE `fuente_indicador`
  ADD PRIMARY KEY (`fkidfuente`,`fkidindicador`),
  ADD KEY `cons_fkidfuente7` (`fkidfuente`),
  ADD KEY `cons_fkidindicador7` (`fkidindicador`);

--
-- Indices de la tabla `indicador`
--
ALTER TABLE `indicador`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cons_fkidunididadmedicion` (`fkidunidadmedicion`),
  ADD KEY `cons_fkidsentido` (`fkidsentido`),
  ADD KEY `cons_fkidfrecuencia` (`fkidfrecuencia`),
  ADD KEY `cons_fkidtipoindicador` (`fkidtipoindicador`);

--
-- Indices de la tabla `represenvisual`
--
ALTER TABLE `represenvisual`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `represenvisual_indicador`
--
ALTER TABLE `represenvisual_indicador`
  ADD PRIMARY KEY (`fkidindicador`,`fkidrepresenvisual`),
  ADD KEY `cons_fkidrespresenvisual` (`fkidrepresenvisual`);

--
-- Indices de la tabla `responsable`
--
ALTER TABLE `responsable`
  ADD PRIMARY KEY (`cedula`);

--
-- Indices de la tabla `responsable_indicador`
--
ALTER TABLE `responsable_indicador`
  ADD PRIMARY KEY (`fkidresponsable`,`fkidindicador`),
  ADD KEY `cons_fkidresponsable1` (`fkidresponsable`),
  ADD KEY `cons_fkidindicador1` (`fkidindicador`),
  ADD KEY `cons_fknomusuario1` (`fknomusuario`);

--
-- Indices de la tabla `resultadoindicador`
--
ALTER TABLE `resultadoindicador`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cons_fkidinicador5` (`fkidindicador`);

--
-- Indices de la tabla `sentido`
--
ALTER TABLE `sentido`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tblarticulo`
--
ALTER TABLE `tblarticulo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tblarticulo_tbltiyulo1` (`fkidtitulo`),
  ADD KEY `fk_tblarticulo_tblcapitulo1` (`fkidcapitulo`),
  ADD KEY `fk_tblarticulo_tblseccion1` (`fkidseccion`);

--
-- Indices de la tabla `tblautor`
--
ALTER TABLE `tblautor`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tblcapitulo`
--
ALTER TABLE `tblcapitulo`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tblestado`
--
ALTER TABLE `tblestado`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tblevidencia`
--
ALTER TABLE `tblevidencia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cons_fkidtipoevidencia` (`fkidtipoevidencia`),
  ADD KEY `cons_fkidarticulo` (`fkidarticulo`),
  ADD KEY `cons_fkidliteral` (`fkidliteral`),
  ADD KEY `cons_fkidnumeral` (`fkidnumeral`),
  ADD KEY `cons_fkidsub_subnumeral` (`fkidsub_subnumeral`),
  ADD KEY `cons_fkidsubnumeral` (`fkidsubnumeral`);

--
-- Indices de la tabla `tblevidenciaautor`
--
ALTER TABLE `tblevidenciaautor`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cons_fkidevidencia2` (`fkidevidencia`),
  ADD KEY `cons_fkidautor` (`fkiautor`);

--
-- Indices de la tabla `tblevidenciaestado`
--
ALTER TABLE `tblevidenciaestado`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cons_fkidevidencia1` (`fkidevidencia`),
  ADD KEY `cons_fkidestado` (`fkidestado`),
  ADD KEY `cons_fkidusuario` (`fkidusuario`);

--
-- Indices de la tabla `tblliteral`
--
ALTER TABLE `tblliteral`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tblliteral_tblarticulo1` (`fkidarticulo`);

--
-- Indices de la tabla `tblnumeral`
--
ALTER TABLE `tblnumeral`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tblnumeral_tblliteral1` (`fkidliteral`);

--
-- Indices de la tabla `tblparagrafo`
--
ALTER TABLE `tblparagrafo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tblparagrafo_tblarticulo1` (`fkidarticulo`);

--
-- Indices de la tabla `tblrol`
--
ALTER TABLE `tblrol`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tblrol_usuario`
--
ALTER TABLE `tblrol_usuario`
  ADD PRIMARY KEY (`fkNomUsuario`,`fkIdRol`),
  ADD KEY `cons_fkIdRol` (`fkIdRol`);

--
-- Indices de la tabla `tblseccion`
--
ALTER TABLE `tblseccion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tblsubnumeral`
--
ALTER TABLE `tblsubnumeral`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tblsubnumeral_tblnumeral1` (`fkidnumeral`);

--
-- Indices de la tabla `tblsub_subnumeral`
--
ALTER TABLE `tblsub_subnumeral`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tblsub_subnumeral_tblsubnumeral1` (`fkidsubnumeral`);

--
-- Indices de la tabla `tbltipoevidencia`
--
ALTER TABLE `tbltipoevidencia`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tbltitulo`
--
ALTER TABLE `tbltitulo`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tblusuario`
--
ALTER TABLE `tblusuario`
  ADD PRIMARY KEY (`nomUsuario`);

--
-- Indices de la tabla `tipoindicador`
--
ALTER TABLE `tipoindicador`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `unidad_de_medicion`
--
ALTER TABLE `unidad_de_medicion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `variable`
--
ALTER TABLE `variable`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `variable_indicador`
--
ALTER TABLE `variable_indicador`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cons_fkidinicador7` (`fkidindicador`),
  ADD KEY `cons_fkidvariable7` (`fkidvariable`),
  ADD KEY `cons_fknomusuario7` (`fknomusuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `evidencia_indicador`
--
ALTER TABLE `evidencia_indicador`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `frecuencia`
--
ALTER TABLE `frecuencia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `fuente`
--
ALTER TABLE `fuente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `indicador`
--
ALTER TABLE `indicador`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `represenvisual`
--
ALTER TABLE `represenvisual`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `resultadoindicador`
--
ALTER TABLE `resultadoindicador`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sentido`
--
ALTER TABLE `sentido`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblautor`
--
ALTER TABLE `tblautor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblevidencia`
--
ALTER TABLE `tblevidencia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tblevidenciaautor`
--
ALTER TABLE `tblevidenciaautor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblevidenciaestado`
--
ALTER TABLE `tblevidenciaestado`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tblrol`
--
ALTER TABLE `tblrol`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tbltipoevidencia`
--
ALTER TABLE `tbltipoevidencia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tipoindicador`
--
ALTER TABLE `tipoindicador`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `unidad_de_medicion`
--
ALTER TABLE `unidad_de_medicion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `variable`
--
ALTER TABLE `variable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `variable_indicador`
--
ALTER TABLE `variable_indicador`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `evidencia_indicador`
--
ALTER TABLE `evidencia_indicador`
  ADD CONSTRAINT `cons_fkidevidencia77` FOREIGN KEY (`fkidevidencia`) REFERENCES `tblevidencia` (`id`),
  ADD CONSTRAINT `cons_fkidinicador77` FOREIGN KEY (`fkidindicador`) REFERENCES `indicador` (`id`),
  ADD CONSTRAINT `cons_fknomusuario77` FOREIGN KEY (`fknomusuario`) REFERENCES `tblusuario` (`nomUsuario`);

--
-- Filtros para la tabla `fuente_indicador`
--
ALTER TABLE `fuente_indicador`
  ADD CONSTRAINT `cons_fkidfuente7` FOREIGN KEY (`fkidfuente`) REFERENCES `fuente` (`id`),
  ADD CONSTRAINT `cons_fkidindicador7` FOREIGN KEY (`fkidindicador`) REFERENCES `indicador` (`id`);

--
-- Filtros para la tabla `indicador`
--
ALTER TABLE `indicador`
  ADD CONSTRAINT `cons_fkidfrecuencia` FOREIGN KEY (`fkidfrecuencia`) REFERENCES `frecuencia` (`id`),
  ADD CONSTRAINT `cons_fkidsentido` FOREIGN KEY (`fkidsentido`) REFERENCES `sentido` (`id`),
  ADD CONSTRAINT `cons_fkidtipoindicador` FOREIGN KEY (`fkidtipoindicador`) REFERENCES `tipoindicador` (`id`),
  ADD CONSTRAINT `cons_fkidunididadmedicion` FOREIGN KEY (`fkidunidadmedicion`) REFERENCES `unidad_de_medicion` (`id`);

--
-- Filtros para la tabla `represenvisual_indicador`
--
ALTER TABLE `represenvisual_indicador`
  ADD CONSTRAINT `cons_fkidinicador3` FOREIGN KEY (`fkidindicador`) REFERENCES `indicador` (`id`),
  ADD CONSTRAINT `cons_fkidrespresenvisual` FOREIGN KEY (`fkidrepresenvisual`) REFERENCES `represenvisual` (`id`);

--
-- Filtros para la tabla `responsable_indicador`
--
ALTER TABLE `responsable_indicador`
  ADD CONSTRAINT `cons_fkidindicador1` FOREIGN KEY (`fkidindicador`) REFERENCES `indicador` (`id`),
  ADD CONSTRAINT `cons_fkidresponsable1` FOREIGN KEY (`fkidresponsable`) REFERENCES `responsable` (`cedula`),
  ADD CONSTRAINT `cons_fknomusuario1` FOREIGN KEY (`fknomusuario`) REFERENCES `tblusuario` (`nomUsuario`);

--
-- Filtros para la tabla `resultadoindicador`
--
ALTER TABLE `resultadoindicador`
  ADD CONSTRAINT `cons_fkidinicador5` FOREIGN KEY (`fkidindicador`) REFERENCES `indicador` (`id`);

--
-- Filtros para la tabla `tblarticulo`
--
ALTER TABLE `tblarticulo`
  ADD CONSTRAINT `fk_tblarticulo_tblcapitulo1` FOREIGN KEY (`fkidcapitulo`) REFERENCES `tblcapitulo` (`id`),
  ADD CONSTRAINT `fk_tblarticulo_tblseccion1` FOREIGN KEY (`fkidseccion`) REFERENCES `tblseccion` (`id`),
  ADD CONSTRAINT `fk_tblarticulo_tbltiyulo1` FOREIGN KEY (`fkidtitulo`) REFERENCES `tbltitulo` (`id`);

--
-- Filtros para la tabla `tblevidencia`
--
ALTER TABLE `tblevidencia`
  ADD CONSTRAINT `cons_fkidarticulo` FOREIGN KEY (`fkidarticulo`) REFERENCES `tblarticulo` (`id`),
  ADD CONSTRAINT `cons_fkidliteral` FOREIGN KEY (`fkidliteral`) REFERENCES `tblliteral` (`id`),
  ADD CONSTRAINT `cons_fkidnumeral` FOREIGN KEY (`fkidnumeral`) REFERENCES `tblnumeral` (`id`),
  ADD CONSTRAINT `cons_fkidsub_subnumeral` FOREIGN KEY (`fkidsub_subnumeral`) REFERENCES `tblsub_subnumeral` (`id`),
  ADD CONSTRAINT `cons_fkidsubnumeral` FOREIGN KEY (`fkidsubnumeral`) REFERENCES `tblsubnumeral` (`id`),
  ADD CONSTRAINT `cons_fkidtipoevidencia` FOREIGN KEY (`fkidtipoevidencia`) REFERENCES `tbltipoevidencia` (`id`);

--
-- Filtros para la tabla `tblevidenciaautor`
--
ALTER TABLE `tblevidenciaautor`
  ADD CONSTRAINT `cons_fkidautor` FOREIGN KEY (`fkiautor`) REFERENCES `tblautor` (`id`),
  ADD CONSTRAINT `cons_fkidevidencia2` FOREIGN KEY (`fkidevidencia`) REFERENCES `tblevidencia` (`id`);

--
-- Filtros para la tabla `tblevidenciaestado`
--
ALTER TABLE `tblevidenciaestado`
  ADD CONSTRAINT `cons_fkidestado` FOREIGN KEY (`fkidestado`) REFERENCES `tblestado` (`id`),
  ADD CONSTRAINT `cons_fkidevidencia1` FOREIGN KEY (`fkidevidencia`) REFERENCES `tblevidencia` (`id`),
  ADD CONSTRAINT `cons_fkidusuario` FOREIGN KEY (`fkidusuario`) REFERENCES `tblusuario` (`nomUsuario`);

--
-- Filtros para la tabla `tblliteral`
--
ALTER TABLE `tblliteral`
  ADD CONSTRAINT `fk_tblliteral_tblarticulo1` FOREIGN KEY (`fkidarticulo`) REFERENCES `tblarticulo` (`id`);

--
-- Filtros para la tabla `tblnumeral`
--
ALTER TABLE `tblnumeral`
  ADD CONSTRAINT `fk_tblnumeral_tblliteral1` FOREIGN KEY (`fkidliteral`) REFERENCES `tblliteral` (`id`);

--
-- Filtros para la tabla `tblparagrafo`
--
ALTER TABLE `tblparagrafo`
  ADD CONSTRAINT `fk_tblparagrafo_tblarticulo1` FOREIGN KEY (`fkidarticulo`) REFERENCES `tblarticulo` (`id`);

--
-- Filtros para la tabla `tblrol_usuario`
--
ALTER TABLE `tblrol_usuario`
  ADD CONSTRAINT `cons_fkIdRol` FOREIGN KEY (`fkIdRol`) REFERENCES `tblrol` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cons_fkNomUsuario` FOREIGN KEY (`fkNomUsuario`) REFERENCES `tblusuario` (`nomUsuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `tblsubnumeral`
--
ALTER TABLE `tblsubnumeral`
  ADD CONSTRAINT `fk_tblsubnumeral_tblnumeral1` FOREIGN KEY (`fkidnumeral`) REFERENCES `tblnumeral` (`id`);

--
-- Filtros para la tabla `tblsub_subnumeral`
--
ALTER TABLE `tblsub_subnumeral`
  ADD CONSTRAINT `fk_tblsub_subnumeral_tblsubnumeral1` FOREIGN KEY (`fkidsubnumeral`) REFERENCES `tblsubnumeral` (`id`);

--
-- Filtros para la tabla `variable_indicador`
--
ALTER TABLE `variable_indicador`
  ADD CONSTRAINT `cons_fkidinicador7` FOREIGN KEY (`fknomusuario`) REFERENCES `tblusuario` (`nomUsuario`),
  ADD CONSTRAINT `cons_fkidvariable7` FOREIGN KEY (`fkidindicador`) REFERENCES `indicador` (`id`),
  ADD CONSTRAINT `cons_fknomusuario7` FOREIGN KEY (`fkidvariable`) REFERENCES `variable` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
