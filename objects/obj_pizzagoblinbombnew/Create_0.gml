hsp = 0;
vsp = 0;
grav = 0.5;
countdown = 125;
image_speed = 0.35;
depth = -90;
drop = true;
grounded = false;
state = states.normal;
playerid = -4;
pizzagoblin = false;
platformid = -4;
hsp_carry = 0;
vsp_carry = 0;
kickbuffer = 0;
movespeed = 0;
defused = false;
destroy = true;
baddie = false;
grabbable = true;
bomblit_spr = spr_bomblitnew;
bouncesound = false;
snd = fmod_create_instance(sfx_bombfuse)
fmod_set_loop(snd, true)
