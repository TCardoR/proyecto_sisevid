<?php
class ControlRolUsuario{
	var $objRolUsuario;
        function __construct($objRolUsuario)
        {
            $this->objRolUsuario = $objRolUsuario;
		}


    function guardar() {
		$fkNomU = $this->objRolUsuario->getFkNomUsuario();
        $fkIdR = $this->objRolUsuario->getFkIdRol();
        
        $comandoSql = "INSERT INTO tblrol_usuario(fkNomUsuario,fkIdRol) VALUES ('$fkNomU','$fkIdR')";
        $objControlConexion = new ControlConexion();
        $objControlConexion->abrirBd($GLOBALS['serv'],$GLOBALS['usua'],$GLOBALS['pass'],$GLOBALS['bdat'],$GLOBALS['port']);
        $objControlConexion->ejecutarComandoSql($comandoSql);
        $objControlConexion->cerrarBd();
    }

        function consultarRoles_por_NomUsuario()
        {
            $msg = "ok";
            $i=0;
            $matRolUsuario = null;
            $nomUsu = $this->objRolUsuario->getFkNomUsuario();
            $comandoSql  ="SELECT tblrol.id,tblrol.nombre " .
                        "FROM tblrol INNER JOIN tblrol_usuario ON tblrol.id=tblrol_usuario.fkIdRol" .
                        " WHERE tblrol_usuario.fkNomUsuario='$nomUsu'";
            $objControlConexion = new ControlConexion();
            $objControlConexion->abrirBd($GLOBALS['serv'],$GLOBALS['usua'],$GLOBALS['pass'],$GLOBALS['bdat'],$GLOBALS['port']);
            $recordSet = $objControlConexion->ejecutarSelect($comandoSql);
            try
            {
                if (mysqli_num_rows($recordSet) > 0)
                {
                    $i = 0;
                    while ($row = $recordSet->fetch_array(MYSQLI_BOTH))
                    {
                        $matRolUsuario[$i][0] = $row[0];
                        $matRolUsuario[$i][1] = $row[1];
                        $i++;
                    }
                    $objControlConexion->cerrarBd();
                }
            }
            catch (Exception $objExcetion)
            {
                $msg = $objExcetion->getMessage();
            }
            return $matRolUsuario;
        }
        function borrarDelNomUsuario()
        {
            $fkNomU = $this->objRolUsuario->getFkNomUsuario();
            $comandoSql  ="DELETE FROM tblrol_usuario WHERE fkNomUsuario='$fkNomU'";
            $objControlConexion = new ControlConexion();
            $objControlConexion->abrirBd($GLOBALS['serv'],$GLOBALS['usua'],$GLOBALS['pass'],$GLOBALS['bdat'],$GLOBALS['port']);
        	$objControlConexion->ejecutarComandoSql($comandoSql);
            $objControlConexion->cerrarBd();
        }
}
?>