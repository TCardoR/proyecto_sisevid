<?php
class ControlTitulo
{
    var $objTitulo;
    function __construct($objTitulo)
    {
        $this->objTitulo = $objTitulo;
    }
    function guardar()
    {

        $ide = $this->objTitulo->getId();
        $nom = $this->objTitulo->getNombre();

        $comandoSql = "INSERT INTO tbltitulo(id,nombre) VALUES ('$ide', '$nom')";
        $objControlConexion = new ControlConexion();
        $objControlConexion->abrirBd($GLOBALS['serv'], $GLOBALS['usua'], $GLOBALS['pass'], $GLOBALS['bdat'], $GLOBALS['port']);
        $objControlConexion->ejecutarComandoSql($comandoSql);
        $objControlConexion->cerrarBd();

    }
    function consultar()
    {
        $ide = $this->objTitulo->getId();

        $comandoSql = "SELECT * FROM tbltitulo WHERE id = '$ide'";
        $objControlConexion = new ControlConexion();
        $objControlConexion->abrirBd($GLOBALS['serv'], $GLOBALS['usua'], $GLOBALS['pass'], $GLOBALS['bdat'], $GLOBALS['port']);
        $recordSet = $objControlConexion->ejecutarSelect($comandoSql);
        if ($row = $recordSet->fetch_array(MYSQLI_BOTH)) {
            $this->objTitulo->setNombre($row['nombre']);
        }
        $objControlConexion->cerrarBd();
        return $this->objTitulo;
    }
    function modificar()
    {
        $ide = $this->objTitulo->getId();
        $nom = $this->objTitulo->getNombre();

        $comandoSql = "UPDATE tbltitulo SET nombre='$nom' WHERE id = '$ide'";
        $objControlConexion = new ControlConexion();
        $objControlConexion->abrirBd($GLOBALS['serv'], $GLOBALS['usua'], $GLOBALS['pass'], $GLOBALS['bdat'], $GLOBALS['port']);
        $objControlConexion->ejecutarComandoSql($comandoSql);
        $objControlConexion->cerrarBd();
    }
    function borrar()
    {
        $ide = $this->objTitulo->getId();
        $comandoSql = "DELETE FROM tbltitulo WHERE id = '$ide'";
        $objControlConexion = new ControlConexion();
        $objControlConexion->abrirBd($GLOBALS['serv'], $GLOBALS['usua'], $GLOBALS['pass'], $GLOBALS['bdat'], $GLOBALS['port']);
        $objControlConexion->ejecutarComandoSql($comandoSql);
        $objControlConexion->cerrarBd();
    }
    function listar()
    {
        $comandoSql = "SELECT * FROM tbltitulo";
        $objControlConexion = new ControlConexion();
        $objControlConexion->abrirBd($GLOBALS['serv'], $GLOBALS['usua'], $GLOBALS['pass'], $GLOBALS['bdat'], $GLOBALS['port']);
        $recordSet = $objControlConexion->ejecutarSelect($comandoSql);
        if (mysqli_num_rows($recordSet) > 0) {
            $arregloTitulo = array();
            $i = 0;
            while ($row = $recordSet->fetch_array(MYSQLI_BOTH)) {
                $objTitulo = new Titulo("", "");
                $objTitulo->setId($row['id']);
                $objTitulo->setNombre($row['nombre']);
                $arregloTitulo[$i] = $objTitulo;
                $i++;
            }
        }
        $objControlConexion->cerrarBd();
        return $arregloTitulo;
    }
}
?>