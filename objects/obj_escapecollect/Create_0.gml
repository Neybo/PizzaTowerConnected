if OLD_GAMEPLAY
{
	instance_destroy();
	exit
}

sprite_index = scr_collectsprite(,true);
mask_index = OLD_GAMEPLAY ? spr_sausagecollect : spr_sausagecollect_NEW;
image_speed = 0.35;

depth = 2;
if scr_depthcheck()
	depth += 100;
ID = -1;

gotowardsplayer = false
movespeed = 5
player = noone

image_alpha = 0.35;

snd = sfx_collectescapesmall
// thats a lot // not anymore