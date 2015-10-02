#!/usr/bin/perl

use DBI;
use strict;
my $driver = "mysql"; 
my $database = "madreTeresa";
my $dsn = "DBI:$driver:database=$database";
my $userid = "root";
my $password = "racing31720700";

my $dbh = DBI->connect($dsn, $userid, $password,{
   PrintError       => 0,
   RaiseError       => 1,
   AutoCommit       => 1,
   FetchHashKeyName => 'NAME_lc',
} ) or die $DBI::errstr;

$dbh->do("DROP DATABASE $database");
$dbh->do("CREATE DATABASE  IF NOT EXISTS `madreTeresa` /*!40100 DEFAULT CHARACTER SET latin1 */;");
$dbh->do("USE `madreTeresa`;");

$dbh->do("DROP TABLE IF EXISTS `donaciones`;");
$dbh->do("CREATE TABLE `donaciones` (
  `iddonaciones` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `monto` decimal(7,2) DEFAULT NULL,
  `fechaDonacion` date DEFAULT NULL,
  `DNI` int(11) DEFAULT NULL,
  PRIMARY KEY (`iddonaciones`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1;");

$dbh->do("DROP TABLE IF EXISTS `eventos`;");

$dbh->do("DROP TABLE IF EXISTS `logUsuario`;");

$dbh->do("CREATE TABLE `logUsuario` (
  `idlogUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `activo` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `nombreUsuario` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idlogUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=248 DEFAULT CHARSET=latin1;");

$dbh->do("DROP TABLE IF EXISTS `provincias`;");
$dbh->do("CREATE TABLE `provincias` (
  `codProv` int(11) NOT NULL,
  `provincia` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`codProv`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;");

$dbh->do("INSERT INTO `provincias` VALUES (2,'BUENOS AIRES'),(3,'CATAMARCA'),(4,'CÓRDOBA'),(5,'CORRIENTES'),(6,'CHACO'),(7,'CHUBUT'),(8,'ENTRE RÍOS'),(9,'FORMOSA'),(10,'JUJUY'),(11,'LA PAMPA'),(12,'LA RIOJA'),(13,'MENDOZA'),(14,'MISIONES'),(15,'NEUQUEN'),(16,'RÍO NEGRO'),(17,'SALTA'),(18,'SAN JUAN'),(19,'SAN LUIS'),(20,'SANTA CRUZ'),(21,'SANTA FE'),(22,'SANTIAGO DEL ESTERO'),(23,'TUCUMÁN'),(24,'TIERRA DEL FUEGO');");



$dbh->do("DROP TABLE IF EXISTS `tipoGasto`;");
$dbh->do("CREATE TABLE `tipoGasto` (
  `idtipo_gasto` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  `TipoGasto` varchar(45) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `Elemento` varchar(255) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`idtipo_gasto`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;");

$dbh->do("DROP TABLE IF EXISTS `tipoSocio`;");
$dbh->do("CREATE TABLE `tipoSocio` (
  `idTipoSocio` int(11) NOT NULL AUTO_INCREMENT,
  `tipoSocio` varchar(100) NOT NULL,
  `monto` decimal(7,2) NOT NULL,
  PRIMARY KEY (`idTipoSocio`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;");

$dbh->do("INSERT INTO `tipoSocio` VALUES (1,'ACTIVO',20.00),(3,'ADHERENTE',15.00),(4,'HONORARIO',5.00),(5,'VITALICIO',20.00);");

$dbh->do("DROP TABLE IF EXISTS `usuario`;");
$dbh->do("CREATE TABLE `usuario` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;");

$dbh->do("INSERT INTO `usuario` VALUES (15,'admin','admin'),(16,'calcuta','calcuta');");

$dbh->do("DROP TABLE IF EXISTS `cuotaSocial`;");

$dbh->do("CREATE TABLE `gastos` (
  `idgastos` int(11) NOT NULL AUTO_INCREMENT,
  `monto` decimal(9,2) DEFAULT NULL,
  `fechaGasto` date DEFAULT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  `tipo_gasto_idtipo_gasto` int(11) NOT NULL,
  PRIMARY KEY (`idgastos`),
  KEY `fk_gastos_tipo_gasto1_idx` (`tipo_gasto_idtipo_gasto`),
  CONSTRAINT `gastos_ibfk_2` FOREIGN KEY (`tipo_gasto_idtipo_gasto`) REFERENCES `tipoGasto` (`idtipo_gasto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;");

$dbh->do("DROP TABLE IF EXISTS `localidades`;");

$dbh->do("CREATE TABLE `localidades` (
  `codLoc` int(11) NOT NULL,
  `codProv` int(11) NOT NULL,
  `localidad` varchar(150) NOT NULL,
  PRIMARY KEY (`codLoc`,`codProv`),
  KEY `codProv` (`codProv`),
  CONSTRAINT `FK_localidades_codProv` FOREIGN KEY (`codProv`) REFERENCES `provincias` (`codProv`),
  CONSTRAINT `localidades_ibfk_1` FOREIGN KEY (`codProv`) REFERENCES `provincias` (`codProv`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;");

$dbh->do("INSERT INTO `localidades` VALUES (1,6,'AVIA TERAI'),(2,6,'BARRANQUERAS'),(3,6,'PUERTO VILELAS'),(4,6,'BASAIL'),(5,6,'CAMPO FELMAN'),(6,6,'CAMPO LA AURORA'),(7,6,'CAMPO LARGO'),(8,6,'CAMPO WINTER'),(9,6,'CAPITAN SOLARI'),(10,6,'CHARADAI'),(11,6,'CHARATA'),(12,6,'CHOROTIS'),(13,6,'CIERVO PETISO'),(14,6,'COLONIA BAJO HONDO'),(15,6,'COLONIA BENITEZ'),(16,6,'COL.BERNARDINO RIVADAVIA'),(17,6,'COLONIA EL AGUARA'),(18,6,'COLONIA ELISA'),(19,6,'COL.GRAL.NECOCHEA'),(20,6,'COL.HIPOLITO VIEYTES'),(21,6,'COLONIA JOSE MARMOL'),(22,6,'COLONIA JUAN J.LAVALLE'),(23,6,'COLONIA JUAN J. PASO'),(24,6,'COLONIA JUAN LARREA'),(25,6,'COLONIA JUAN PENCO'),(26,6,'COLONIA LA LOLA'),(27,6,'COLONIA POPULAR'),(28,6,'COLONIA RODIRGUEZ PE?A'),(29,6,'COLONIAS UNIDAS'),(30,6,'CONCEPCION DEL BERMEJO'),(31,6,'CORONEL DU GRATY'),(32,5,'CORRIENTES'),(33,6,'CORZUELA'),(34,6,'COTE LAI'),(35,9,'EL COLORADO'),(36,6,'EL ESPINILLO'),(37,6,'EL ?ANDUBAY'),(38,6,'EL PALMAR'),(39,6,'EL PALMAR - QUITILIP'),(40,6,'EL PINTADO-WICHI'),(41,6,'EL TRAGADERO'),(42,6,'EL SAUZALITO'),(43,6,'ENRIQUE URIEN'),(44,21,'FLORENCIA'),(45,6,'FONTANA'),(46,6,'FORTIN AGUILAR'),(47,6,'FORTIN LAVALLE'),(48,6,'FUERTE ESPERANZA'),(49,6,'GANCEDO'),(50,6,'GENERAL CAPDEVILLA'),(51,6,'GRAL.J.DE SAN MARTIN'),(52,6,'GENERAL PAZ'),(53,6,'GENERAL VEDIA'),(54,6,'HAUMONIA'),(55,6,'HERMOSO CAMPO'),(56,6,'HORQUILLA'),(57,6,'ISLA DEL CERRITO'),(58,6,'ITIN'),(59,6,'JUAN JOSE CASTELLI'),(60,6,'LA CLOTILDE'),(61,6,'LA CHIQUITA'),(62,6,'LA EDUVIGIS'),(63,6,'LA ESCONDIDA'),(64,6,'LA LEONESA'),(65,6,'LA LIGURIA'),(66,6,'LA MASCOTA'),(67,6,'LA MATANZA'),(68,6,'LA TAMBORA'),(69,6,'LA TIGRA'),(70,6,'LA VERDE'),(71,6,'LAGUNA BLANCA'),(72,6,'LAGUNA LIMPIA'),(73,6,'LAPACHITO'),(74,6,'LAS BRE?AS'),(75,6,'LAS GARCITAS'),(76,6,'LAS PALMAS'),(77,6,'LOS FRENTONES'),(78,6,'MACHAGAI'),(79,6,'MAKALLE'),(80,6,'MARGARITA BELEN'),(81,6,'MESON DE FIERRO'),(82,6,'MIRAFLORES'),(83,6,'MISION NUEVA POMPEYA'),(84,22,'MONTE QUEMADO'),(85,6,'NAPALPI'),(86,6,'NAPENAY'),(87,6,'NECOCHEA'),(88,6,'PAMPA ALEGRIA'),(89,6,'PAMPA ALMIRON'),(90,6,'PAMPA CABRERA'),(91,6,'PAMPA DEL INDIO'),(92,6,'PAMPA DEL INFIERNO'),(93,6,'PAMPA FLORIDA'),(94,6,'PAMPA GRANDE'),(95,6,'PAMPA LANDRIEL'),(96,6,'PAMPA OCULTA'),(97,6,'PAMPA VERDE'),(98,6,'PRESIDENCIA DE LA PLAZA'),(99,6,'PRESIDENCIA ROCA'),(100,6,'PRESIDENCIA R.SAENZ PE?A'),(101,6,'PRESIDENTE URIBURU'),(102,6,'PUERTO BERMEJO'),(103,6,'PUERTO TIROL'),(104,6,'GENERAL PINEDO'),(105,6,'PUERTO VICENTIN'),(106,6,'QUITILIPI'),(107,6,'RESISTENCIA'),(108,6,'RIO MUERTO'),(109,6,'LA SABANA'),(110,6,'SAMUHU'),(111,6,'SAN BERNARDO'),(112,6,'SANTA SYLVINA'),(113,6,'SELVAS DEL RIO DE ORO'),(114,6,'SUBERBUHLER'),(115,6,'TACO POZO'),(116,6,'TRES ESTACAS'),(117,6,'TRES HORQUETAS(Gr.VEDIA)'),(118,6,'TRES HORQUETAS(Col.BENITEZ)'),(119,6,'TRES ISLETAS'),(120,6,'TRES PALMAS'),(121,6,'VENADOS GRANDES'),(122,6,'VILLA ANGELA'),(123,6,'VILLA BERTHET'),(124,6,'VILLA RIO BERMEJITO'),(125,6,'ZAPALLAR'),(126,6,'ZAPARINQUI'),(127,6,'PTO.EVA PER?N (EX PTO.VELAZ)'),(128,13,'GODOY CRUZ'),(129,4,'VILLA CARLOS PAZ'),(130,13,'GUAYMALLEN'),(131,4,'BELL VILLE'),(132,6,'PAMPA CHICA'),(133,21,'ROSARIO'),(134,21,'AROCENA'),(135,4,'CORDOBA'),(136,2,'FLORENCIO VARELA'),(137,21,'VILLA OCAMPO'),(138,2,'LANUS'),(139,2,'S.N.DE ARROYOS'),(140,9,'PIRANE'),(141,6,'EL ZAPALLAR'),(142,2,'MARTINEZ'),(143,2,'SAN FRANCISCO SOLANO'),(144,2,'GRAND BOURG'),(145,2,'VILLA DE MAYO'),(146,9,'GENERAL MASILLA'),(147,4,'LABOULAYE'),(148,2,'GUERNICA'),(149,2,'VILLA ADELINA'),(150,2,'LOMAS DE ZAMORA'),(151,2,'MONTE GRANDE'),(152,21,'GALVEZ'),(153,2,'CAPITAL FEDERAL'),(154,2,'MERLO'),(155,5,'ITUZAINGO'),(156,6,'TRES MOJONES'),(157,21,'LAS TOSCAS'),(158,2,'OLIVOS'),(159,4,'ALTA GRACIA'),(160,2,'CAMARONES-CAP.FED.'),(161,2,'BANFIELD'),(163,6,'COL.TACUARI'),(164,2,'ARRECIFES'),(165,5,'ITATI'),(166,2,'AVDA. PUEYRREDON'),(167,2,'MAR DEL PLATA'),(168,5,'MONTE CASEROS'),(169,2,'MAQUINISTA SABIO'),(170,2,'CLAYPOLE'),(171,2,'MAXIMO PAZ'),(172,2,'WILLIAM MORRIS'),(173,2,'GONZALEZ CATAN'),(175,8,'URDINARRAIN'),(176,2,'BECAR'),(177,2,'VILLA MADERO'),(178,14,'OBERA'),(180,9,'FORMOSA'),(181,2,'OLAVARRIA'),(182,2,'LUIS GUILLON'),(184,21,'VILLA GUILLERMINA'),(185,4,'MONTE MAIZ'),(186,2,'NECOCHEA'),(187,5,'MERCEDES'),(188,2,'LA FERRERE'),(189,2,'DEL VISO'),(190,2,'PILAR'),(191,3,'S.F.VALLE CATAMARCA'),(192,17,'SALTA'),(193,17,'ROSARIO DE LERMA'),(194,2,'RAFAEL CASTILLO'),(195,2,'TALCAHUANO-CAP.FED.'),(196,6,'COMANDANCIA FRIAS'),(197,6,'COLONIA BRANDSEN'),(198,2,'SAN ISIDRO'),(199,2,'LANUS O.-CAP.FED.'),(200,23,'SAN M.DE TUCUMAN'),(201,9,'IBARRETA'),(202,21,'RECONQUISTA'),(203,2,'9 DE ABRIL-D.E.ECHEVERRIA'),(204,21,'LOS AMORES'),(205,21,'AVELLANEDA'),(206,2,'SAN MIGUEL'),(207,21,'BOMBAL'),(208,2,'AV.STA.FE-CAP.FEDERA.'),(209,2,'AV.BOEDO-CAP.FEDERA.'),(210,2,'ACASSUSO'),(213,13,'LAS HERAS'),(214,2,'TALAR DE PACHECO-TIGRE'),(215,2,'MORENO'),(216,4,'VILLA MARIA'),(217,2,'VALENTIN ALSINA'),(218,8,'PARANA'),(219,2,'CAMPANA'),(220,14,'EL DORADO'),(221,21,'SANTA FE'),(222,10,'JUJUY'),(225,2,'CASEROS'),(226,13,'SAN JOSE'),(227,5,'BIGAND'),(230,21,'GABOTO'),(231,4,'LEONES'),(233,2,'SAN PEDRO'),(234,8,'CONCORDIA'),(235,4,'SAN FRANCISCO'),(236,2,'JOSE C.PAZ'),(238,2,'ESCOBAR'),(239,2,'HURLINGHAM'),(240,2,'EL TALAR'),(241,4,'MARCOS JUAREZ'),(244,2,'WILDE'),(245,2,'PERGAMINO'),(246,21,'JUAN B.MOLINA'),(247,4,'OLIVA'),(248,17,'EL GALPON'),(252,2,'JUNIN'),(253,6,'COLONIA BARANDA'),(255,22,'SANTIAGO DEL ESTERO'),(256,2,'RAMOS MEJIA'),(259,4,'RIO TERCERO'),(260,21,'GRANADERO BAIGORRIA'),(261,4,'VILLA ALLENDE'),(262,17,'LOS ROSALES'),(263,4,'RIO SEGUNDO'),(264,2,'MANZANARES-CAP.FED.'),(265,4,'JUSTINIANO POSSE'),(266,2,'MARCOS PAZ'),(267,21,'IBARLUCEA'),(268,4,'ONCATIVO'),(269,8,'VICTORIA'),(270,2,'TORTUGUITAS'),(272,4,'CRUZ ALTA'),(273,2,'AMERICA'),(275,2,'AVELLANEDA'),(276,9,'CLORINDA'),(277,4,'JESUS MARIA'),(278,21,'ROLDAN'),(279,2,'QUILMES OESTE'),(280,2,'QUILMES'),(281,6,'PAMPA IPORA GUAZU'),(282,21,'VILLA TRINIDAD'),(283,21,'CA?ADA DE GOMEZ'),(284,21,'EL TREBOL'),(285,2,'BURSACO'),(286,2,'MONTE CHINGOLO'),(287,21,'TORTUGAS'),(288,4,'GENERAL CABRERA'),(289,4,'RIO CUARTO'),(290,4,'SALADILLO'),(291,21,'SAN JOSE DE LA ESQUINA'),(292,4,'INRIVILLE'),(293,2,'BERAZATEGUI'),(294,4,'VILLA DEL ROSARIO'),(295,4,'LAGUNA LARGA'),(296,4,'PILAR'),(297,4,'GENERAL DEHEZA'),(298,11,'GENERAL ACHA'),(299,21,'FIRMAT'),(300,21,'CAPITAN BERMUDEZ'),(301,2,'DON TORCUATO'),(303,21,'RAFAELA'),(304,21,'LAS PAREJAS'),(305,21,'GOBERNADOR CRESPO'),(306,21,'CHABAS'),(307,21,'SAN LORENZO'),(308,4,'MARULL'),(309,4,'LOS SURGENTES'),(310,23,'TUCUMAN'),(311,21,'MONJE'),(314,4,'CAMILO ALDAO'),(315,5,'PASO DE LOS LIBRES'),(316,14,'POSADAS'),(317,4,'ADELIA MARIA'),(318,23,'TAFI VIEJO'),(319,21,'CA?ADA ROSQUIN'),(320,21,'SUNCHALES'),(321,4,'DESPE?ADEROS'),(322,4,'W.ESCALANTE'),(323,21,'LANTERI'),(324,4,'TORO PUIJO'),(325,14,'LEANDRO N.ALEM'),(326,4,'MORTEROS'),(327,21,'BARRANCAS'),(328,2,'SALTO'),(329,4,'LABORDE'),(330,21,'TOTORAS'),(331,4,'LAS VARILLAS'),(332,2,'BERNAL'),(335,2,'LA PLATA'),(336,2,'SAN MARTIN'),(337,21,'SASTRE'),(338,4,'SACANTA'),(339,4,'PASCO'),(340,2,'SAN ANDRES'),(341,21,'MARIA SUSANA'),(342,4,'PAMPAYA NORTE'),(343,4,'JAMES CRAIK'),(344,24,'USHUAIA'),(345,2,'TRES ARROYOS'),(346,21,'PUJATO'),(347,2,'LA SALADA'),(348,2,'EZEIZA'),(349,19,'SAN LUIS'),(350,21,'MARIA JUANA'),(351,4,'COL.MADRESELVA-BALNEARIA'),(352,2,'ITUZAINGO -BS.AS.'),(353,2,'VILLA MAIPU'),(354,21,'COLONIA ALDAO'),(355,4,'VILLA ASCASUBI'),(356,2,'BENAVIDEZ'),(357,2,'VILLA LUZURIAGA'),(358,4,'MONTE BUEY'),(359,21,'ARMSTRONG'),(360,4,'PUNILLA'),(361,22,'PAMPA DE LOS GUANACOS'),(362,22,'BANDERA'),(363,21,'CORONDA'),(364,2,'LOS POLVORINES'),(365,4,'BRINKMANN'),(366,21,'TOSTADO'),(367,2,'CA?UELAS'),(368,5,'SAN LUIS DEL PALAMAR'),(369,3,'SAN FERNANDO DEL V.CATAMARCA'),(370,21,'CHA?AR LADEADO'),(371,21,'ESPERANZA'),(372,4,'RIO PRIMERO'),(373,21,'CASILDA'),(374,2,'BULOGNE SUR MER'),(375,2,'GARIN'),(376,21,'FRAY LUIS BELTRAN'),(377,22,'LA BANDA'),(378,2,'LLAVALLOL'),(379,2,'TEMPERLEY'),(380,21,'NELSON'),(382,2,'MORON'),(383,2,'BERNAL'),(384,21,'VENADO TUERTO'),(385,8,'LA PAZ'),(386,2,'TIGRE'),(387,2,'SAN NICOLAS DE LOS ARROYOS'),(388,21,'SAN CARLOS'),(389,2,'TRISTAN SUAREZ'),(390,2,'INGENIERO MASCHWITZ'),(392,6,'EL PALMAR'),(393,2,'VILLA BALLESTER'),(394,2,'CASTELAR'),(397,21,'VILLA G.GALVEZ'),(398,21,'ARROYO SECO'),(399,2,'ING.PABLO NOGUES'),(400,17,'JOAQUIN V.GONZALEZ'),(401,2,'VIRREY DEL PINO'),(403,2,'GLEW'),(405,2,'BERNAL'),(407,21,'COLONIA EL TOBA'),(408,2,'SAN FERNANDO'),(409,21,'LAS PETACAS'),(411,21,'HERSILIA'),(412,2,'PEHUAJO'),(413,18,'JACHAL'),(415,2,'MORENO'),(416,2,'MANUEL ALBERTI'),(417,2,'VIRREYES'),(418,4,'ALICIA'),(419,5,'PASO DE LA PATRIA'),(420,2,'VILLA RITA'),(421,2,'VICENTE LOPEZ'),(422,4,'BIALET MASSE'),(423,14,'IGUAZU'),(424,5,'SANTA LUCIA'),(425,16,'VIEDMA'),(426,2,'ISIDRO CASANOVA'),(427,9,'LAGUNA BLANCA'),(428,17,'GENERAL GUEMES'),(429,21,'SANTA MARGARITA'),(431,21,'INTIYACO'),(432,21,'CA?ADA OMBU'),(433,16,'SAN CARLOS DE BARILOCHE'),(434,2,'SEVIGNE'),(435,2,'RAFAEL CALZADA'),(436,7,'COMODORO RIVADAVIA'),(438,4,'MORRISON'),(439,2,'CIUDADELA'),(440,2,'BENITO JUAREZ'),(441,21,'FUENTES'),(442,21,'PEREZ'),(443,4,'CORRALITO'),(445,2,'CHIVILCOY'),(446,20,'EL CALAFATE'),(447,2,'BERISSO'),(448,21,'GATO COLORADO'),(449,2,'PABLO PODESTA'),(450,22,'A?ATUYA'),(451,4,'ARROYITO'),(452,24,'RIO GRANDE'),(453,2,'FERRE'),(454,4,'CALCHIN'),(455,2,'EL PALOMAR'),(456,2,'GENERAL SARMIENTO'),(457,2,'SARANDI'),(458,4,'ALMAFUERTE'),(459,21,'CERES'),(460,7,'TRELEW'),(461,21,'AREQUITO'),(462,2,'REMEDIOS DE ESCALADA'),(463,21,'SAN CRISTOBAL'),(464,21,'PAVON ARRIBA'),(465,2,'PIEDRITAS'),(466,4,'ESTACION CALCHIN'),(467,21,'SAN GENARO'),(468,5,'SANTA ROSA-DPTO.CONCEPCION'),(469,4,'EMBALSE'),(470,4,'ASCOCHINGA'),(471,6,'SALTO DE LA VIEJA'),(473,15,'NEUQUEN'),(474,2,'ALMIRANTE BROWN'),(475,21,'CORONEL BOGADO'),(476,2,'VILLA MARTELLI'),(477,4,'COSQUIN'),(478,22,'RIVADAVIA'),(479,20,'RIO GALLEGOS'),(480,2,'UNION FERROVIARIA'),(481,6,'COLONIA TACUARI'),(482,2,'CAPITAN SARMIENTO'),(483,23,'MONTEROS'),(484,22,'CAMPO DEL CIELO'),(485,4,'BARRIO QUEBRADA DE LAS ROSAS'),(486,4,'CERRO LAS ROSAS'),(487,2,'PASO DEL REY'),(488,21,'SAN JOSE DE LA ESQUINA'),(489,22,'QUIMIL'),(490,21,'LAGRA?A'),(491,21,'LOGRO?O'),(492,4,'LOZADA'),(493,2,'ADROGUE'),(494,21,'LOPEZ'),(495,21,'ELORTONDO'),(496,4,'LA GRANJA'),(497,3,'BANDA VARELA'),(498,5,'SALADAS'),(499,8,'UBAJAY'),(500,21,'LOS LAURALES'),(501,17,'TARTAGAL'),(502,21,'LANDETA'),(503,21,'ARROLLO CEIBAL'),(504,18,'SAN JUAN'),(505,6,'PAMPA AGUADO'),(506,11,'SANTA ROSA'),(507,4,'UNQUILLO'),(508,2,'EZPELETA'),(509,4,'POZO DEL MOLLE'),(510,4,'MATORRALES'),(511,21,'CARLOS PELLEGRINI'),(512,21,'MOISES VILLE'),(513,2,'COLON'),(515,9,'PALO SANTO'),(516,21,'PUERTO GRAL.SAN MARTIN'),(517,2,'BELLA VISTA'),(518,7,'RAWSON'),(519,17,'METAN'),(520,4,'LA PARA'),(521,2,'LIBERTAD'),(522,2,'BAHIA BLANCA'),(523,2,'LAS FLORES'),(524,8,'CHAJARI'),(525,21,'SAN JORGE'),(526,4,'VILLA DOLORES'),(527,21,'HUMBERTO PRIMERO'),(528,2,'MARIANO ACOSTA'),(529,2,'SAN JUSTO'),(530,21,'VERA'),(531,21,'SANTA ISABEL'),(532,2,'GENERAL PACHECO'),(533,22,'LOS PIRPINTOS'),(534,14,'SAN IGNACIO'),(535,20,'RIO TURBIO'),(536,5,'BARRIO PIRAYU'),(537,21,'MELINCUE'),(538,14,'EL SOBERBIO'),(539,2,'PELLEGRINI'),(540,13,'SAN RAFAEL'),(541,20,'LOS ANTIGUOS'),(542,2,'JOSE L. SUAREZ'),(543,2,'VILLA GESELL'),(544,14,'PUERTO IGUAZU'),(545,9,'TRES LAGUNAS'),(546,2,'ZARATE'),(547,21,'MALABRIGO'),(548,4,'VILLA FONTANA'),(549,21,'EL NOCHERO'),(550,21,'LAS GARZAS'),(551,16,'CIPOLLETTI'),(552,4,'LA FRANCIA'),(553,4,'HERNANDO'),(554,2,'TANDIL'),(555,12,'LA RIOJA'),(556,2,'TRES SARGENTOS'),(557,2,'GENERAL BELGRANO'),(559,2,'MIRAMAR'),(560,21,'VILLA MINETTI'),(561,2,'CARAPACHAY'),(562,5,'GOYA'),(563,4,'FREYRE'),(564,21,'LLAMBI CAMPBELL'),(565,14,'PUERTO ESPERANZA'),(566,2,'HAEDO'),(567,21,'SAN JUSTO'),(568,4,'VILLA CABRERA'),(569,2,'CHACABUCO'),(570,5,'CURUZU-CUATIA'),(571,9,'LAS LOMITAS'),(572,2,'GENERAL RODRIGUEZ'),(573,21,'WHEELWRIGHT'),(574,2,'ADOLFO SORDEAUX'),(575,4,'TIO PUJIO'),(576,11,'CATRILO'),(577,7,'ESQUEL'),(578,5,'ALVEAR'),(579,2,'JOSE LEON SUAREZ'),(580,9,'VIILA DOS TRECE'),(581,9,'VILLA DOS TRECE'),(582,2,'FLORIDA'),(583,2,'OSTENDE'),(584,2,'AZUL'),(585,13,'RIVADAVIA'),(586,2,'LUJAN'),(587,20,'CALETA OLIVIA'),(588,2,'CARLOS SPEGAZZINI'),(589,23,'YERBA BUENA'),(590,4,'DEVOTO'),(591,13,'MAIPU'),(592,20,'LAS HERAS'),(593,21,'RICARDONE'),(594,21,'VILLA CA?AS'),(595,2,'BRAGADO'),(596,8,'VILLAGUAY'),(597,2,'BOULOGNE'),(598,14,'JARDIN AMERICA'),(599,4,'ISLA VERDE'),(600,2,'AMEGHINO'),(601,4,'MONTE CRISTO'),(602,5,'SAN COSME'),(603,4,'LOS CONDORES'),(604,2,'SAN ALBERTO'),(605,21,'SOLEDAD'),(606,7,'DOLAVON'),(607,3,'SUMALAO'),(608,20,'GOBERNADOR GREGORES'),(609,2,'GREGORIO LAFERRER'),(610,4,'SAN JAVIER'),(611,2,'LOMAS DEL MIRADOR'),(612,2,'PONTEVERA'),(613,15,'BARRANCAS'),(614,2,'PARQUE SAN MARTIN'),(615,21,'LAS ROSAS'),(616,5,'SANTO  TOM'),(617,2,'BOUCHARD'),(618,2,'ALVARADO'),(619,8,'GUALEGUAY'),(620,10,'PERICO'),(622,2,'PUNTA ALTA'),(623,2,'SAN NICOLAS'),(624,5,'BERON DE ASTRADA'),(626,14,'PUERTO RICO'),(627,21,'SANTO TOM'),(628,21,'ZAVALLA'),(629,14,'SAN PEDRO'),(630,2,'DOCK SUD'),(631,4,'SANTA ROSA DE CALAMUCHITA'),(632,22,'ROVERSI'),(633,2,'MATHEU'),(634,4,'BALLESTEROS'),(635,4,'ALTO ALBERDI'),(636,2,'ENSENADA'),(637,5,'PERUGORRIA'),(638,16,'PERITO MORENO'),(639,14,'SAN JAVIER'),(640,10,'SAN SALVADOR DE JUJUY'),(641,23,'CONCEPCION'),(642,2,'GRAN BOURG'),(643,2,'MAR DE AJO'),(644,4,'LA FALDA'),(645,2,'ANCHORENA'),(646,15,'VILLA LA ANGOSTURA'),(647,11,'GENERAL PICO'),(648,16,'CHOELE CHOEL'),(649,2,'MONTE GRANDE'),(650,13,'MENDOZA'),(651,8,'CONCEPCION DEL URUGUAY'),(652,21,'ALVAREZ'),(653,2,'QUEQUEN'),(654,20,'COMANDANTE LUIS PIEDRA BUENA'),(655,9,'VILLA ESCOBAR'),(656,2,'LOS TOLDOS'),(657,4,'BALNEARIA'),(658,2,'SAN ANTONIO DE ARECO'),(659,21,'HUMBOLDT'),(660,21,'VILLA CONSTITUCION'),(661,21,'SAN JERONIMO SUD'),(662,6,'COLONIA JUAN JOSE CASTELLI'),(663,23,'FAMAILLA'),(664,4,'SANTA ROSA DE R.PRIMERO'),(665,4,'LA PUERT-R.PRIMERO'),(666,4,'CORRAL DE BUSTOS'),(667,2,'VILLA ELISA'),(668,15,'ZAPALA'),(669,2,'LOMA HERMOSA'),(670,9,'LAGUNA YEMA'),(671,4,'LEONES'),(672,5,'CONCEPCION'),(673,21,'MONTES DE OCA'),(674,17,'VILLA SAN LORENZO'),(675,20,'PUERTO DESEADO'),(676,2,'MARTIN CORONADO'),(677,8,'GUALEGUAYCHU'),(678,20,'COM.L.PIEDRABUENA'),(679,2,'PRESIDENTE DERQUI'),(680,2,'SAN CLEMENTE DEL TUYU'),(681,21,'EL SOMBRERITO'),(682,2,'CARILO'),(683,2,'VILLA CELINA'),(684,4,'RIO CEBALLOS'),(685,9,'ING.GUILLERMO JUAREZ'),(686,14,'SAN JOSE'),(687,5,'SAN CARLOS'),(688,4,'COLONIA CAROYA'),(689,2,'MALVINAS ARGENTINA'),(690,21,'TACUARENDI'),(691,21,'MARGARITA'),(692,21,'RUFINO'),(693,2,'BOLIVAR'),(694,4,'CORONEL MOLDES'),(695,2,'PEREZ MILLAN'),(696,2,'MUNRO'),(697,5,'ESQUINA'),(698,7,'PUERTO MADRYN'),(699,8,'VIALE'),(700,8,'ROSARIO DEL TALA'),(701,14,'CANDELARIA'),(702,2,'RANELAGH'),(703,5,'LA CRUZ'),(704,2,'EXALTACION DE LA CRUZ'),(705,2,'PUNTA ALTA'),(706,21,'VILLA ELOISA'),(707,5,'CHAVARRIA'),(708,2,'AVDA. SEGUROLA'),(709,2,'COL.DR.GDOR.UDAONDO'),(710,21,'CA?ADA RICA'),(711,19,'VILLA DE MERLO'),(712,5,'EMPEDRADO'),(713,2,'SANTOS LUGARES'),(714,14,'APOSTOLES'),(715,22,'TOMAS YOUNG'),(716,8,'VILLA LIBERTADOR GENERAL SAN MARTIN'),(717,5,'IT? IBATLE'),(718,23,'EL MANANTIAL'),(719,14,'GARUPA'),(720,4,'VILLA AZALAIS'),(721,2,'SAENZ PE?A'),(722,21,'COLASTIN? NORTE'),(723,17,'EMBARCACION'),(724,2,'SAN MARTIN DE LOS ANDES'),(725,2,'ALMAGRO'),(726,14,'SANTA ANA'),(727,21,'VILA'),(728,15,'CUTRAL-C'),(729,2,'O HIGGINS'),(730,2,'NORBERTO DE LA RIESTRA'),(731,4,'LA CARLOTA'),(732,23,'TRANCAS'),(733,2,'SANTA LUCIA'),(734,21,'FUNES'),(735,2,'PACHECO'),(736,6,'CAMPO MORENO'),(737,4,'VILLA GENERAL BELGRANO'),(740,5,'BELLA VISTA'),(741,9,'COMANDANTE FONTANA'),(742,4,'ALTOS DE CHIPION'),(743,21,'VIDELA'),(744,4,'VILLA CONCEPCION DEL TIO'),(745,6,'PUERTO EVA PERON'),(746,2,'CIUDAD EVITA');");

$dbh->do("CREATE TABLE `florVida` (
  `apellido` varchar(100) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `localidad` int(11) NOT NULL,
  `direccion` varchar(250) DEFAULT NULL,
  `fechaDefuncion` date DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `idFV` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idFV`),
  KEY `fk_florVida_1` (`localidad`),
  CONSTRAINT `fk_florVida_1` FOREIGN KEY (`localidad`) REFERENCES `localidades` (`codLoc`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;");


$dbh->do("DROP TABLE IF EXISTS `socios`;");
$dbh->do("CREATE TABLE `socios` (
  `idSocio` int(11) NOT NULL AUTO_INCREMENT,
  `idTipoSocio` int(11) NOT NULL,
  `documento` int(11) NOT NULL,
  `sexo` varchar(30) NOT NULL,
  `nombre` varchar(80) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `cuil` varchar(20) DEFAULT NULL,
  `numSoc` int(10) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `celular` varchar(20) DEFAULT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `localidad` int(11) NOT NULL,
  `direccion` varchar(250) NOT NULL,
  `fechaBaja` date DEFAULT NULL,
  `socio` tinyint(1) NOT NULL DEFAULT '0',
  `adherente` tinyint(1) NOT NULL DEFAULT '0',
  `donante` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idSocio`),
  KEY `fk_socios_1_idx` (`localidad`),
  KEY `fk_socios_2_idx` (`idTipoSocio`),
  CONSTRAINT `fk_socios_1` FOREIGN KEY (`localidad`) REFERENCES `localidades` (`codLoc`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_socios_2` FOREIGN KEY (`idTipoSocio`) REFERENCES `tipoSocio` (`idTipoSocio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;");

$dbh->do("DROP TABLE IF EXISTS `sociosFlorVida`;");
$dbh->do("CREATE TABLE `sociosFlorVida` (
  `idSocio` int(11) NOT NULL AUTO_INCREMENT,
  `apellido` varchar(150) DEFAULT NULL,
  `nombre` varchar(150) DEFAULT NULL,
  `localidad` int(11) DEFAULT NULL,
  `direccion` varchar(250) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `cuil` varchar(20) DEFAULT NULL,
  `sexo` varchar(1) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `celular` varchar(20) DEFAULT NULL,
  `dni` int(11) DEFAULT NULL,
  PRIMARY KEY (`idSocio`),
  KEY `fk_sociosFlorVida_1` (`localidad`),
  CONSTRAINT `fk_sociosFlorVida_1` FOREIGN KEY (`localidad`) REFERENCES `localidades` (`codLoc`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;");
$dbh->do("DROP TABLE IF EXISTS `tipoEvento`;");

$dbh->do("CREATE TABLE `relacSocDifuntos` (
  `idSocioFV` int(11) NOT NULL,
  `idFV` int(11) NOT NULL,
  PRIMARY KEY (`idSocioFV`,`idFV`),
  KEY `idFV` (`idFV`),
  CONSTRAINT `relacSocDifuntos_ibfk_5` FOREIGN KEY (`idSocioFV`) REFERENCES `sociosFlorVida` (`idSocio`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relacSocDifuntos_ibfk_6` FOREIGN KEY (`idFV`) REFERENCES `florVida` (`idFV`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;");

$dbh->do("CREATE TABLE `tipoEvento` (
  `idTipoEvento` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) NOT NULL,
  PRIMARY KEY (`idTipoEvento`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;");

$dbh->do("CREATE TABLE `eventos` (
  `idEvento` int(11) NOT NULL AUTO_INCREMENT,
  `motivo` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `montoPublic` decimal(7,2) DEFAULT NULL,
  `montoRifas` decimal(7,2) DEFAULT NULL,
  `montoTarjetas` decimal(7,2) DEFAULT NULL,
  PRIMARY KEY (`idEvento`),
  KEY `fk_eventos_1` (`motivo`),
  CONSTRAINT `fk_eventos_1` FOREIGN KEY (`motivo`) REFERENCES `tipoEvento` (`idTipoEvento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;");

$dbh->do("CREATE TABLE `cuotaFlorDeVida` (
  `idcuotaFlorDeVida` int(11) NOT NULL AUTO_INCREMENT,
  `monto` decimal(7,2) NOT NULL,
  `fechaPago` date NOT NULL,
  `idSocioFV` int(11) NOT NULL,
  `idFV` int(11) NOT NULL,
  PRIMARY KEY (`idcuotaFlorDeVida`,`idSocioFV`,`idFV`),
  KEY `idSocioFV` (`idSocioFV`),
  KEY `idFV` (`idFV`),
  CONSTRAINT `cuotaFlorDeVida_ibfk_11` FOREIGN KEY (`idSocioFV`) REFERENCES `sociosFlorVida` (`idSocio`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cuotaFlorDeVida_ibfk_12` FOREIGN KEY (`idFV`) REFERENCES `florVida` (`idFV`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;");

$dbh->do("CREATE TABLE `cuotaSocial` (
  `idCuotaSocial` int(11) NOT NULL AUTO_INCREMENT,
  `idSocio` int(11) NOT NULL,
  `fechaActivacion` date NOT NULL,
  `fechaPago` date DEFAULT NULL,
  `monto` decimal(7,2) DEFAULT NULL,
  `cuota` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`idCuotaSocial`),
  KEY `cuotaSocios` (`idSocio`),
  CONSTRAINT `cuotaSocial_ibfk_2` FOREIGN KEY (`idSocio`) REFERENCES `socios` (`idSocio`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=242 DEFAULT CHARSET=latin1;");

print "done\n";