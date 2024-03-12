image_speed = 0.35;
depth = 60;
if scr_depthcheck()
	depth += 100;

createdpizza = false;
content = obj_bigcollect;

spr_closed = spr_pizzaboxunopen;
spr_open = spr_pizzaboxopen;

subimg = 0

if check_sugary()
{
	spr_closed = spr_pizzaboxunopen_ss;
	spr_open = spr_pizzaboxopen_ss;
	if FINAL_GAMEPLAY
	{
		spr_closed = spr_confectibox;
		spr_open = spr_confectiboxopen;
	}
}

sprite_index = spr_closed;
mimic = false
