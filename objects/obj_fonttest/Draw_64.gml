if keyboard_check_pressed(ord("1"))
	curfontselected = 0
if keyboard_check_pressed(ord("2"))
	curfontselected = 1
if keyboard_check_pressed(ord("3"))
	curfontselected = 2
if keyboard_check_pressed(ord("4"))
	curfontselected = 3
if keyboard_check_pressed(ord("5"))
	curfontselected = 4
if keyboard_check_pressed(ord("6"))
	curfontselected = 5
if keyboard_check_pressed(ord("7"))
	curfontselected = 6
if keyboard_check_pressed(ord("T"))
	fontstr = get_string("Test what string? ", "")
	
draw_set_align(fa_center, fa_middle)
	
draw_set_font(fonts[curfontselected].fnt)
	
draw_text_ext(480, 140, string_upper(fontstr), 36, 950)
	
if !fonts[curfontselected].capsonly
{
	draw_text_ext(480, 270, string_lower(fontstr), 36, 950)
	
	draw_text_ext(480, 400, fontstr, 36, 950)
}