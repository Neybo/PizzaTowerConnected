draw_set_color(c_black)
draw_rectangle(0,0,960,540,false)

draw_set_color(c_ltgrey)
draw_line(480 + 328, 20, 480 + 328, 520)

if !scrollselect
	draw_set_color(c_white)

// simple formula for smoothness
var size_of_bar = 500 / scrollsize
var bar_pos_ext = (500 - size_of_bar) * (scrolly / scrollmax)

draw_rectangle(480 + 320, 20 + bar_pos_ext, 480 + 336, 20 + (size_of_bar + bar_pos_ext), false)

draw_set_font(global.font_small)

draw_set_color(c_white)

var yy = 10 + spacesep - scrolly

for (var i = 0; i < langlen; i++)
{
	var col = c_white
	if i != curlangselected &&
	point_in_rectangle(mouse_x,mouse_y,480 - 330, yy, 480 + 310, yy + langheight)
	{
		if mouse_check_button_pressed(mb_left)
			curlangselected = i
		col = c_ltgrey
	}
		
	draw_set_color(i == curlangselected ? c_lime : col)
	draw_rectangle(480 - 330, yy, 480 + 310, yy + langheight, true)
	draw_set_color(col)
	draw_set_halign(fa_left)
	
	var size = string_width(langs[i].name)
	
	draw_text_transformed(480 - 320, yy + langheight / 5, langs[i].name, 
	min(400 / size, 1.5), min(400 / size, 1.5), 0)
	var credits_amt = array_length(langs[i].credits)
	var txt = ""
	for (var j = 0; j < credits_amt; j++)
	{
		if j == credits_amt - 1
			txt += langs[i].credits[j]
		else
			txt += langs[i].credits[j] + ", "
	}
	
	draw_text(480 - 320, yy + (langheight - (langheight / 5)), txt)
	
	yy += langtotalsiz
}

// cut off text amagically
draw_set_color(c_black)
draw_rectangle(0,0,960,10,false)
draw_rectangle(0,531,960,540,false)

draw_set_color(c_white)
draw_roundrect_ext(480 - 340, 10, 480 + 340, 530, 5, 5, true)

// finally, do buttons

// defaults
var col = c_white
if point_in_rectangle(mouse_x, mouse_y, 10, 464, 130, 500)
	col = c_ltgrey
draw_set_color(col)
draw_set_align(fa_center, fa_middle)
draw_roundrect_ext(10, 464, 130, 500, 3, 3, true)
var size = string_width(langs[curlangselected].text_default)
draw_text_transformed(70, 484, langs[curlangselected].text_default,
min(120 / size, 1),min(120 / size, 1), 0)
if mouse_check_button_pressed(mb_left) && col == c_ltgrey
{
	initlang = get_specific_lang()
	curlangselected = find_ind()
}

// done
var col = c_white
if point_in_rectangle(mouse_x, mouse_y, 830, 464, 950, 500)
	col = c_ltgrey
draw_set_color(col)
draw_set_align(fa_center, fa_middle)
draw_roundrect_ext(830, 464, 950, 500, 3, 3, true)
var size = string_width(langs[curlangselected].text_done)
draw_text_transformed(890, 484, langs[curlangselected].text_done,
min(120 / size, 1),min(120 / size, 1), 0)
draw_set_align(fa_left, fa_top)
var checkfucker = initlang != langs[curlangselected].file
if checkfucker
{
	draw_set_color(c_white)
	draw_text_ext(830, 400, langs[curlangselected].text_reset, 10, 120)
}
if mouse_check_button_pressed(mb_left) && col == c_ltgrey
{
	ini_open("saveData.ini");
	ini_write_string("online", "language", langs[curlangselected].file)
	ini_close()
	if !checkfucker
		instance_destroy()
	else
	{
		fmod_destroy()
		game_restart()
	}
}
	

draw_set_color(c_white)