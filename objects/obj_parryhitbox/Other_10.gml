var myplayer = obj_player.id
with myplayer
{
	if (global.notgonnasugarcoatit)
		instance_create(0,0,obj_sugarcoat)
	else
		scr_soundeffect(sfx_parry);
	state = states.parry
	sprite_index = choose(spr_parry1, spr_parry2, spr_parry3)
	image_index = 0
	image_speed = 0.35
	taunttimer = 20
	movespeed = 8
	parry_inst = noone
	parry_count = 1
	with instance_create(x, y, obj_parryeffect)
		image_xscale = other.xscale
	flash = true
}

instance_destroy();
//alarm[0] = die_time
collisioned = true
