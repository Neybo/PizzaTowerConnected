
//Grab

instance_create(x + (obj_player.xscale * 40),y, obj_punchdust)
with obj_player{
image_index = 0
sprite_index = spr_haulingstart
if other.heavy = true
heavy = true
else
heavy = false
state = states.grab

}

state= states.grabbed

instance_destroy(other)


