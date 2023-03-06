<?php
    include '../control/configBd.php';
    include '../modelo/Usuario.php';
    include '../modelo/Autor.php';
    include '../control/ControlConexion.php';
    include '../control/ControlUsuario.php';
    include '../control/ControlAutor.php';
    $id="1";
    $objAutor=new Autor($id,'','');
    $objControlAutor=new ControlAutor($objAutor);
    $objAutor=$objControlAutor->consultar();
    echo 'ident='. $objAutor->getIdent();
    echo 'Nombre='. $objAutor->getNombre();
?>