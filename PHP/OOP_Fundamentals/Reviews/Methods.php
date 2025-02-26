<?php

class MobilePhone
{
    public $sim_num = 9354354546;
    
    public function welcome()
    {
        echo "Welcome!";
    }
    public function get_sim_num()
    {
        return $this->welcome() . " " . $this->sim_num;
    }
    public function set_sim_num($sim_num )
    {
        //notice that the class's property and function's parameter are the same name! (optional)
        //let's set the class's PROPERTY, not this method's PARAMETER
        $this->sim_num = $sim_num ;   
        //without $this keyword, you are referring to the local variable only (scoped inside function).
    }

}

$instance1 = new MobilePhone();
echo $instance1 ->get_sim_num();
$instance1->set_sim_num(111111111111);
echo $instance1->get_sim_num();

$instance2 = new MobilePhone();
echo $instance2->get_sim_num();