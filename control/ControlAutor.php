<?php
class ControlAutor{
    var $objAutor;
    function __construct($objAutor)
    {
        $this->objAutor = $objAutor;
    }
    function guardar()
    {

        $ide = $this->objAutor->getId();
        $ident = $this->objAutor->getIdent();
        $nom = $this->objAutor->getNombre();

        $comandoSql = "INSERT INTO tblautor(id,ident,nombre) VALUES ('$ide', '$ident','$nom')";
        $objControlConexion = new ControlConexion();
        $objControlConexion->abrirBd($GLOBALS['serv'], $GLOBALS['usua'], $GLOBALS['pass'], $GLOBALS['bdat'], $GLOBALS['port']);
        $objControlConexion->ejecutarComandoSql($comandoSql);
        $objControlConexion->cerrarBd();

    }
    function consultar()
    {
        $ide = $this->objAutor->getId();

        $comandoSql = "SELECT * FROM tblautor WHERE id = '$ide'";
        $objControlConexion = new ControlConexion();
        $objControlConexion->abrirBd($GLOBALS['serv'], $GLOBALS['usua'], $GLOBALS['pass'], $GLOBALS['bdat'], $GLOBALS['port']);
        $recordSet = $objControlConexion->ejecutarSelect($comandoSql);
        if ($row = $recordSet->fetch_array(MYSQLI_BOTH)) {
            $this->objAutor->setIdent($row['ident']);
            $this->objAutor->setNombre($row['nombre']);
        }
        $objControlConexion->cerrarBd();
        return $this->objAutor;
    }
    function modificar()
    {
        $ide = $this->objAutor->getId();
        $ident = $this->objAutor->getIdent();
        $nom = $this -> objAutor->getNombre();

        $comandoSql = "UPDATE tblautor SET ident='$ident', nombre='$nom' WHERE id = '$ide'";
        $objControlConexion = new ControlConexion();
        $objControlConexion->abrirBd($GLOBALS['serv'], $GLOBALS['usua'], $GLOBALS['pass'], $GLOBALS['bdat'], $GLOBALS['port']);
        $objControlConexion->ejecutarComandoSql($comandoSql);
        $objControlConexion->cerrarBd();
    }
    function borrar()
    {
        $ide = $this->objAutor->getId();
        $comandoSql = "DELETE FROM tblautor WHERE id = '$ide'";
        $objControlConexion = new ControlConexion();
        $objControlConexion->abrirBd($GLOBALS['serv'], $GLOBALS['usua'], $GLOBALS['pass'], $GLOBALS['bdat'], $GLOBALS['port']);
        $objControlConexion->ejecutarComandoSql($comandoSql);
        $objControlConexion->cerrarBd();
    }
    function listar()
    {
        $comandoSql = "SELECT * FROM tblautor";
        $objControlConexion = new ControlConexion();
        $objControlConexion->abrirBd($GLOBALS['serv'], $GLOBALS['usua'], $GLOBALS['pass'], $GLOBALS['bdat'], $GLOBALS['port']);
        $recordSet = $objControlConexion->ejecutarSelect($comandoSql);
        if (mysqli_num_rows($recordSet) > 0) {
            $arregloAutor = array();
            $i = 0;
            while ($row = $recordSet->fetch_array(MYSQLI_BOTH)) {
                $objAutor = new Autor("", "","");
                $objAutor->setId($row['id']);
                $objAutor->setIdent($row['ident']);
                $objAutor->setNombre($row['nombre']);
                $arregloAutor[$i] = $objAutor;
                $i++;
            }
        }
        $objControlConexion->cerrarBd();
        return $arregloAutor;
    }
}
?>