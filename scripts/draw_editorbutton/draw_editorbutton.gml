/// @param {real} x
/// @param {real} y
/// @param {string} string
function draw_editorbutton(_xx, _yy, str, sel = false, forcesel = false)
{
	var hover = false;
	
	var xx = _xx + camera_get_view_x(view_camera[0])
	var yy = _yy + camera_get_view_y(view_camera[0])
	
	if mouse_x >= xx && mouse_y >= yy
	&& mouse_x < xx + 192 && mouse_y < yy + 48
		hover = true;
	
	draw_sprite(spr_editormenu_button, (hover && !forcesel) or sel, _xx, _yy);
	draw_set_font(global.bigfont);
	draw_set_colour(c_white);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	draw_text_auto(_xx + 192 / 2, _yy + 48 / 2, str);
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	if mouse_check_button_pressed(mb_left) && hover && ((forcesel && sel) || !forcesel)
		return 1;
	else if hover
		return -1;
	else
		return 0;
}

function draw_editorbutton_minus(_xx, _yy, sel = false)
{
	var hover = false;
	
	var xx = _xx + camera_get_view_x(view_camera[0])
	var yy = _yy + camera_get_view_y(view_camera[0])
	
	if mouse_x >= xx && mouse_y >= yy
	&& mouse_x < xx + 13 && mouse_y < yy + 13
		hover = true;
	
	draw_sprite(spr_editormenu_buttonsmall, (hover or sel) + 2, _xx, _yy);
	
	if mouse_check_button_pressed(mb_left) && hover
		return 1;
	else if hover
		return -1;
	else
		return 0;
}

function draw_editorbutton_plus(_xx, _yy, sel = false)
{
	var hover = false;
	
	var xx = _xx + camera_get_view_x(view_camera[0])
	var yy = _yy + camera_get_view_y(view_camera[0])
	
	if mouse_x >= xx && mouse_y >= yy
	&& mouse_x < xx + 13 && mouse_y < yy + 13
		hover = true;
	
	draw_sprite(spr_editormenu_buttonsmall, (hover or sel), _xx, _yy);
	
	if mouse_check_button_pressed(mb_left) && hover
		return 1;
	else if hover
		return -1;
	else
		return 0;
}

function draw_editorbutton_arrowL(_xx, _yy, sel = false)
{
	var hover = false;
	
	var xx = _xx + camera_get_view_x(view_camera[0])
	var yy = _yy + camera_get_view_y(view_camera[0])
	
	if mouse_x >= xx && mouse_y >= yy
	&& mouse_x < xx + 39 && mouse_y < yy + 25
		hover = true;
	
	draw_sprite(spr_editormenu_buttonarrow, (hover or sel), _xx, _yy);
	
	if mouse_check_button_pressed(mb_left) && hover
		return 1;
	else if hover
		return -1;
	else
		return 0;
}

function draw_editorbutton_arrowR(_xx, _yy, sel = false)
{
	var hover = false;
	
	var xx = _xx + camera_get_view_x(view_camera[0])
	var yy = _yy + camera_get_view_y(view_camera[0])
	
	if mouse_x >= xx && mouse_y >= yy
	&& mouse_x < xx + 39 && mouse_y < yy + 25
		hover = true;
	
	draw_sprite(spr_editormenu_buttonarrow, (hover or sel) + 2, _xx, _yy);
	
	if mouse_check_button_pressed(mb_left) && hover
		return 1;
	else if hover
		return -1;
	else
		return 0;
}

function draw_editorbutton_checkbox(_xx, _yy, sel = false)
{
	var hover = false;
	
	var xx = _xx + camera_get_view_x(view_camera[0])
	var yy = _yy + camera_get_view_y(view_camera[0])
	
	if mouse_x >= xx && mouse_y >= yy
	&& mouse_x < xx + 32 && mouse_y < yy + 32
		hover = true;
	
	draw_sprite(spr_check_button, 0 + (hover * 2) + sel, _xx, _yy);
	
	if mouse_check_button_pressed(mb_left) && hover
		return 1;
	else if hover
		return -1;
	else
		return 0;
}