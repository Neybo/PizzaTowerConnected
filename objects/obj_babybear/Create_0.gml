event_inherited();
movespeed = 6;
idlespr = spr_babybear_walk
walkspr = spr_babybear_walk
grabbedspr = spr_babybear_stun
stunfallspr = spr_babybear_stun
scaredspr = spr_babybear_scared
spr_dead = spr_babybear_dead

with instance_create(x, y, obj_baddiecollisionbox)
{
	sprite_index = spr_babybear_walk
	mask_index = sprite_index
	baddieID = other.id
	other.boundbox = true
}
sugaryenemy = true;
escape = true;
sprite_index = walkspr;

