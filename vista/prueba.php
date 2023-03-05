<?php
    include '../control/configBd.php';
    include '../modelo/Usuario.php';
    include '../control/ControlConexion.php';
    include '../control/ControlUsuario.php';
    $nomU="Usuario.777";
    $objUsuario=new Usuario($nomU,'');
    $objControlUsuario=new ControlUsuario($objUsuario);
    $objUsuario=$objControlUsuario->consultar();
    echo 'Contraseña='. $objUsuario->getContrasena();
?>