scr_getinput(true);

if room == Realtitlescreen or room == characterselect
{
	instance_destroy();
	exit;
}

xoffset = lerp(xoffset, 0, 0.25);
yoffset = lerp(yoffset, 0, 0.25);

// change the palette
if con == 1
	exit;

if key_start or key_slap2
{
	keyboard_clear(global.key_start);
	keyboard_clear(global.key_slap);
	
	scr_soundeffect(sfx_dresserback);
	con = 1;
	exit;
}

if check_shaders() or !selvert
{
	if (-key_left2 or (holdt == 0 && -key_left)) && sel[selaccess] > selmin
	{
		scr_soundeffect(sfx_step);
		sel[selaccess] -= /*(key_attack) ? 2 :*/ 1;
		xoffset = -100;
		
		if holdt == -1
			holdt = 30;
		else
			holdt = 5;
		
		if !selvert
			event_user(0);
	}
	else if (key_right2 or (holdt == 0 && key_right)) && sel[selaccess] < selmax
	{
		scr_soundeffect(sfx_step); 
		sel[selaccess] += /*(key_attack) ? 2 :*/ 1;
		xoffset = 100;
		
		if holdt == -1
			holdt = 30;
		else
			holdt = 5;
		
		if !selvert
			event_user(0);
	}
	if texturemode
	sel[3] = clamp(sel[3], selmin, selmax);
	else
	sel[0] = clamp(sel[0], selmin, selmax);
	
	if key_left + key_right == 0
		holdt = -1;
	else if holdt > 0
		holdt--;
}
else
{
	sel[selaccess] = 0;
	if !locked && (-key_left2 or key_right2)
	{
		scr_soundeffect(sfx_denied);
		palname = "Palettes unavailable.";
	}
}

// select the palette
if key_jump
{
	if locked
		scr_soundeffect(sfx_denied);
	else
	{
		keyboard_clear(global.key_jump);
		con = 1;
		t = 0;
		event_user(1);
	}
}