if floor(image_index) = 2 && canthrowbomb = true
{
	//scr_sound(sound_enemythrow)
	with instance_create(x+(image_xscale *10),y-20,obj_pizzagoblinbomb)
	{
		hsp = other.image_xscale * 4
		drop = true
		vsp = -5
		depth = other.depth - 10 // nice lol
		countdown = other.bombcountdown
	}
	canthrowbomb = false
	alarm[0] = 150
}

if floor(image_index) = image_number -1 && canthrowbomb = false
{
	image_speed = 0
}
else
	image_speed = 0.35

if !instance_exists(obj_pizzagoblinbomb) && obj_player.state != states.bombpep && alarm[0] < 10
{
	canthrowbomb = true
	alarm[0] = -1
}
else
	canthrowbomb = false

