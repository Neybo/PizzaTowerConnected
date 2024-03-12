if showtoken && !loading
{
	if (draw_editorbutton_checkbox(10, 505, global.savethegmstoken))
		global.savethegmstoken = !global.savethegmstoken
	draw_set_font(global.font_small)
	draw_text(95, 513, "Remember me?")
}