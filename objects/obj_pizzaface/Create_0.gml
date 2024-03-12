if (global.racing)
	instance_destroy()

vsp = 0
hsp = 0
state = (141 << 0)
elite = 0
panic = 0
grav = 0.5
destroyable = 1
escape = 0
maxspeed = 8
spd = 0
saved_angle = 0
afterimg = 0
flash = 0
end_turn = 0
image_speed = 0.35
depth = -5
x = obj_player.x
y = obj_player.y
image_alpha = 0
alarm[1] = 10
finalbehavior = 1

sugary = check_sugary();
if sugary && !global.classiclap
{
	sprite_index = spr_coneball;
	scr_soundeffect(sfx_coneball);
	
	reset_pos = function()
	{
		x = obj_player.x + choose(800, -800);
		y = obj_player.y + choose(800, -800);
		
		xx = x - _camx;
		yy = y - _camy;
	}
}
else
{
	if sugary
		scr_soundeffect(sfx_coneball);
	else
		scr_soundeffect(sfx_pizzaface);
	if !finalbehavior
		sprite_index = spr_pizzaface_angry;
	if sugary
		sprite_index = spr_coneball_NEW;
	if FINAL_GAMEPLAY
	{
		image_alpha = 0
		x = obj_player.x
		y = obj_player.y
	}
}

siner = room_speed * random_range(4, 8);
attack = 0;
xx = x;
yy = y;
treasure = false;

sugary = check_sugary();
pizzafaceiscoming = FMOD_EMPTY
if !sugary
	pizzafaceiscoming = scr_soundeffect_ext(sfx_pizzafacemoving, true)