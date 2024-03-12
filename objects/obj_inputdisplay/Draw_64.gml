if !global.inputdisplay
	exit;
if check_online()
{
	if global.__chat
		exit;
}
scr_getinput(true);

	x = pos[0];
	y = pos[1];
	
	// draw it
	var xx = 0, yy = 0;
	for(var i = 0; i < lengtharray; i++) // array length causes lag?
	{
		var k = inputkeys[i];
		 
		xx = k.x * keysize + k.x * keysep;
		yy = k.y * keysize + k.y * keysep;
		
		draw_inputdisplay_key(x + xx, y + yy, k.key, k.keyw * keysize + (k.keyw - 1) * keysep, k.keyh * keysize + (k.keyh - 1) * keysep);
	}
	
	// dont block the view
	var left = x, right = x + xx + keysize, top = y, bottom = y + yy + keysize;
	if extrakeys
		top -= (keysize + keysep)
	
	if instance_exists(obj_player)
	{
		var px = obj_player.x - _camx, py = obj_player.y - _camy;
		if px >= left - 30 && px <= right + 30
		&& py >= top - 30 && py <= bottom + 30
			image_alpha = 0.35;
		else
			image_alpha = 1;
	}
	if instance_exists(obj_choicebase)
	{
		image_alpha = 0.35;
	}
	
	// customize
	var mx = device_mouse_x_to_gui(0), my = device_mouse_y_to_gui(0);
	if mx >= left && mx <= right && my >= top && my <= bottom
	{
		if mouse_check_button_pressed(mb_left) && !drag
		{
			drag = true;
			dragoffset = [pos[0] - mx, pos[1] - my];
		}
		
		draw_set_colour(drag ? c_red : merge_colour(c_blue, c_aqua, 0.75));
		draw_rectangle(left, top, right, bottom, true);
	}
	if !mouse_check_button(mb_left)
		drag = false;
	
	if drag
	{
		pos[0] = mx + dragoffset[0];
		pos[1] = my + dragoffset[1];
		
		pos[0] = clamp(pos[0], 0, 960 - xx - keysize);
		pos[1] = clamp(pos[1], 0, 540 - yy - keysize);
		
		with obj_wc
			WC_dragobj = noone;
	}


