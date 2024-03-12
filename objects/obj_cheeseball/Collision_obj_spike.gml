/*
if .state = states.cheeseball
{
with ()
{
	scr_soundeffect(sfx_loseknight)
	.grav = 0.5
	instance_create(x,y,obj_slimedebris) 
	instance_create(x,y,obj_slimedebris) 
	instance_create(x,y,obj_slimedebris) 
	instance_create(x,y,obj_slimedebris) 
	instance_create(x,y,obj_slimedebris)
	instance_create(x,y,obj_slimedebris) 
	instance_create(x,y,obj_slimedebris) 
	instance_create(x,y,obj_slimedebris) 
	instance_create(x,y,obj_slimedebris) 
	instance_destroy(other)
		if x != other.x
	{
	.hsp = sign(x - other.x) * 5;
	}
	else .hsp = 5
	 vsp = -3
	 .visible = true
	 image_index = 0
	.image_index = 0
	.flash = true
	state = states.bump

	}
}
else
{
*/
	instance_destroy()
//}