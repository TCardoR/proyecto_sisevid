<?php
class ControlUnidadMedicion
{
    var $objUnidadMedicion;
    function __construct($objUnidadMedicion)
    {
        $this->objUnidadMedicion = $objUnidadMedicion;
    }
    function guardar()
    {

        $ide = $this->objUnidadMedicion->getId();
        $des = $this->objUnidadMedicion->getDescripcion();

        $comandoSql = "INSERT INTO unidad_de_medicion(id,descripcion) VALUES ('$ide', '$des')";
        $objControlConexion = new ControlConexion();
        $objControlConexion->abrirBd($GLOBALS['serv'], $GLOBALS['usua'], $GLOBALS['pass'], $GLOBALS['bdat'], $GLOBALS['port']);
        $objControlConexion->ejecutarComandoSql($comandoSql);
        $objControlConexion->cerrarBd();

    }
    function consultar()
    {
        $ide = $this->objUnidadMedicion->getId();

        $comandoSql = "SELECT * FROM unidad_de_medicion WHERE id = '$ide'";
        $objControlConexion = new ControlConexion();
        $objControlConexion->abrirBd($GLOBALS['serv'], $GLOBALS['usua'], $GLOBALS['pass'], $GLOBALS['bdat'], $GLOBALS['port']);
        $recordSet = $objControlConexion->ejecutarSelect($comandoSql);
        if ($row = $recordSet->fetch_array(MYSQLI_BOTH)) {
            $this->objUnidadMedicion->setDescripcion($row['descripcion']);
        }
        $objControlConexion->cerrarBd();
        return $this->objUnidadMedicion;
    }
    function modificar()
    {
        $ide = $this->objUnidadMedicion->getId();
        $des = $this->objUnidadMedicion->getDescripcion();

        $comandoSql = "UPDATE unidad_de_medicion SET descripcion='$des' WHERE id = '$ide'";
        $objControlConexion = new ControlConexion();
        $objControlConexion->abrirBd($GLOBALS['serv'], $GLOBALS['usua'], $GLOBALS['pass'], $GLOBALS['bdat'], $GLOBALS['port']);
        $objControlConexion->ejecutarComandoSql($comandoSql);
        $objControlConexion->cerrarBd();
    }
    function borrar()
    {
        $ide = $this->objUnidadMedicion->getId();
        $comandoSql = "DELETE FROM unidad_de_medicion WHERE id = '$ide'";
        $objControlConexion = new ControlConexion();
        $objControlConexion->abrirBd($GLOBALS['serv'], $GLOBALS['usua'], $GLOBALS['pass'], $GLOBALS['bdat'], $GLOBALS['port']);
        $objControlConexion->ejecutarComandoSql($comandoSql);
        $objControlConexion->cerrarBd();
    }
    function listar()
    {
        $comandoSql = "SELECT * FROM unidad_de_medicion";
        $objControlConexion = new ControlConexion();
        $objControlConexion->abrirBd($GLOBALS['serv'], $GLOBALS['usua'], $GLOBALS['pass'], $GLOBALS['bdat'], $GLOBALS['port']);
        $recordSet = $objControlConexion->ejecutarSelect($comandoSql);
        if (mysqli_num_rows($recordSet) > 0) {
            $arregloUnidadMedicion = array();
            $i = 0;
            while ($row = $recordSet->fetch_array(MYSQLI_BOTH)) {
                $objUnidadMedicion = new UnidadMedicion("", "");
                $objUnidadMedicion->setId($row['id']);
                $objUnidadMedicion->setDescripcion($row['descripcion']);
                $arregloUnidadMedicion[$i] = $objUnidadMedicion;
                $i++;
            }
        }
        $objControlConexion->cerrarBd();
        return $arregloUnidadMedicion;
    }
}
?>