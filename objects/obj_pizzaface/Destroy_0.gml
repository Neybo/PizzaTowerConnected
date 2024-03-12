if (global.racing)
	exit;

if !sugary
	sprite_index = spr_pizzaface_hurt
with instance_create(x, y, obj_shakeanddie)
	sprite_index = other.sprite_index

scr_soundeffect(sfx_explosion)
scr_soundeffect(sfx_groundpound)
fmod_release_instance(pizzafaceiscoming)