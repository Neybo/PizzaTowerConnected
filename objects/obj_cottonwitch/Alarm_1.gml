if state == states.stun && hsp != 0
	alarm[1] = 2;
with instance_create(x, y, obj_baddiegibs)
{
	angspd = random(2);
	sprite_index = spr_cottonwitchprojectile;
	hsp = -other.hsp / 2;
	vsp = -other.vsp / 2;
}

