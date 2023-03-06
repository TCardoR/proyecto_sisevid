<?php
class Autor
{
    var $id;
    var $ident;
    var $nombre;

    function __construct($id, $ident, $nombre)
    {
        $this->id = $id;
        $this->ident = $ident;
        $this->nombre = $nombre;
    }
    function setId($id)
    {
        $this->id = $id;
    }
    function getId()
    {
        return $this->id;
    }
    function setIdent($id)
    {
        $this->id = $id;
    }
    function getIdent()
    {
        return $this->id;
    }
    function setNombre($nombre)
    {
        $this->nombre = $nombre;
    }
    function getNombre()
    {
        return $this->nombre;
    }
}
?>