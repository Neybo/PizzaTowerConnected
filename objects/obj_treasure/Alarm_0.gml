with obj_player
	sprgot = -1;

with obj_player
	state = states.normal
	
with instance_create(x, y, obj_smallnumber)
	number = "2000"
global.collect += 2000
instance_destroy()
