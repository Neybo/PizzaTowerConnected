if cureffect != -1
	effect_handle_update(effects[cureffect], surface_data)

if keyboard_check_pressed(ord("1")) cureffect = 0;
if keyboard_check_pressed(ord("2")) cureffect = 1;
if keyboard_check_pressed(ord("3")) cureffect = 2;
/*
if keyboard_check_pressed(ord("4")) cureffect = 3;
if keyboard_check_pressed(ord("5")) cureffect = 4;
if keyboard_check_pressed(ord("6")) cureffect = 5;
if keyboard_check_pressed(ord("7")) cureffect = 6;
if keyboard_check_pressed(ord("8")) cureffect = 7;
if keyboard_check_pressed(ord("9")) cureffect = 8;
*/
if keyboard_check_pressed(ord("0")) 
{
	surface_data = []
	array_copy(surface_data, 0, surface_data_default, 0, array_length(surface_data_default))
	stage = 0;
}