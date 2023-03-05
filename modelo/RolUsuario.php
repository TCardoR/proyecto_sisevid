<?php
  class RolUsuario{
  	var $fkNomUsuario;
  	var $fkIdRol;
  	function __construct($fkNomUsuario,$fkIdRol){
  		$this->fkNomUsuario=$fkNomUsuario;
  		$this->fkIdRol=$fkIdRol;
  	}
  	function setFkNomUsuario($fkNomUsuario){
  		$this->fkNomUsuario=$fkNomUsuario;
  	}
  	function getFkNomUsuario(){
  		return $this->fkNomUsuario;
  	} 
  	function setFkIdRol($fkIdRol){
  		$this->fkIdRol=$fkIdRol;
  	}
  	function getFkIdRol(){
  		return $this->fkIdRol;
  	}    		
  }
?>