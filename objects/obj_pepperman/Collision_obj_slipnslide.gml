if other.drop = false
{
	fmod_stop_instance_immediately(global.music);
	
	instance_destroy(obj_peppermandestroyable)
	instance_create(x,y,obj_key)
	dead = true
	sprite_index = spr_pepperman_hurt
	hsp = spd
	other.drop = true
}
