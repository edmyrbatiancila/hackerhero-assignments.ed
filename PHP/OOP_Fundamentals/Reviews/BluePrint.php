<?php

class MobilePhone 
{
    public $apps = array();
    public $model;
    public $sim_num;

    public function __construct() 
    {
        echo "Welcome!";
        $this->model = "Realme 8 5g";
    }
    public function __get($property)
    {
        if(property_exists($this, $property))
        {
        return $this->$property;
        }
    }
    public function __set($property, $value) 
    {
        if (property_exists($this, $property)) 
        {
        $this->$property = $value;
        }
        return $this;
    }
    public function install($app_name) 
    {
        array_push($this->apps, $app_name);
        echo "<br>Successfully installed $app_name.";
        $this->list_apps();
    }
    public function list_apps() 
    {
        echo "<br>All apps:";
        foreach($this->apps as $app) 
        {
            echo "$app ";
        }
    }
}