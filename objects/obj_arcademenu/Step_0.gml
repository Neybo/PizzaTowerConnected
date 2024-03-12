scr_getinput(true);
if key_slap2 or key_escape
{
	scr_soundeffect(sfx_modmenuclose);
	instance_destroy();
}

if key_jump
{
	var func = choices[sel[0]][sel[1]][2];
	if is_method(func)
		func();
	else
		scr_soundeffect(sfx_denied);
}

var move = key_left2 + key_right2;
if move != 0
{
	scr_soundeffect(sfx_step);
	sel[0] += move;
	if sel[0] >= array_length(choices)
		sel[0] = 0;
	if sel[0] <= -1
		sel[0] = array_length(choices) - 1;
	
	sel[1] = clamp(sel[1], 0, array_length(choices[sel[0]]) - 1);
}

var move2 = -key_up2 + key_down2;
if move2 != 0 && array_length(choices[sel[0]]) > 1
{
	scr_soundeffect(sfx_step);
	sel[1] += move2;
	if sel[1] >= array_length(choices[sel[0]])
		sel[1] = 0;
	if sel[1] <= -1
		sel[1] = array_length(choices[sel[0]]) - 1;
}

