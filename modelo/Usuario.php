<?php
  class Usuario{
  	var $nomUsuario;
  	var $contrasena;
  	function __construct($nomUsuario,$contrasena){
  		$this->nomUsuario=$nomUsuario;
  		$this->contrasena=$contrasena;
  	}
  	function setNomUsuario($nomUsuario){
  		$this->nomUsuario=$nomUsuario;
  	}
  	function getNomUsuario(){
  		return $this->nomUsuario;
  	} 
  	function setContrasena($contrasena){
  		$this->contrasena=$contrasena;
  	}
  	function getContrasena(){
  		return $this->contrasena;
  	}    		
  }
?>