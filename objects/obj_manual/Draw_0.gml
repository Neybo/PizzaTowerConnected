draw_self();
draw_set_font(global.font_small);
draw_set_colour(c_red);
if !open
{
	draw_set_valign(fa_center)
	draw_set_halign(fa_left)
	draw_text(104, 48, lang_str("manual.viewkey"))
	draw_set_halign(fa_right)
	draw_text(940, 48, lang_string("manual.discord"))
	
	draw_set_halign(fa_center)
	draw_set_valign(fa_top);
	exit;
}
draw_sprite(manualspr, i, 0, 0);

draw_set_halign(fa_center)
draw_set_valign(fa_top);

if i == 0
{
	// welcome
	draw_set_halign(fa_center);
	draw_set_colour(c_black);
	draw_text(960 / 2, 64, lang_string("manual.welcome"));
	draw_set_colour(c_red);
	draw_text(960 / 2, 63, lang_string("manual.welcome"));
}
else if i == 1
{
	// controls
	draw_set_halign(fa_center);
	draw_set_colour(c_black);
	draw_text_transformed(960 / 2, 40, lang_string("manual.controls"), 2, 2, 0);
	draw_set_colour(c_red);
	draw_text_transformed(960 / 2, 38, lang_string("manual.controls"), 2, 2, 0);
	
	draw_set_halign(fa_left);
	draw_text(252, 224, lang_string("manual.controls.content"));
}
else if i == 2
{
	// commands
	draw_set_halign(fa_center);
	draw_set_colour(c_black);
	draw_text_transformed(960 / 2, 40, lang_string("manual.commands"), 2, 2, 0);
	draw_set_colour(c_red);
	draw_text_transformed(960 / 2, 38, lang_string("manual.commands"), 2, 2, 0);
	
	draw_set_halign(fa_left);
	draw_text(204, 204, lang_string("manual.commands.content"));
}
else if i == 3
{
	// rules
	draw_set_halign(fa_center);
	draw_set_colour(c_black);
	draw_text_transformed(960 / 2, 40, lang_string("manual.rules"), 2, 2, 0);
	draw_set_colour(c_red);
	draw_text_transformed(960 / 2, 38, lang_string("manual.rules"), 2, 2, 0);
	
	draw_text(960 / 2, 132, lang_string("manual.rules.content"));
	
	draw_set_halign(fa_left);
	draw_text(284, 204, lang_string("manual.rules.content2"));
}
else if i == 4
{
	// lapping
	draw_set_halign(fa_center);
	draw_set_colour(c_black);
	draw_text_transformed(960 / 2, 40, lang_string("manual.lapping"), 2, 2, 0);
	draw_set_colour(c_red);
	draw_text_transformed(960 / 2, 38, lang_string("manual.lapping"), 2, 2, 0);
	
	draw_set_valign(fa_middle);
	draw_text(960 / 2, 540 / 2, lang_string("manual.lapping.content"));
	draw_set_valign(fa_top);
}
else if i == 5
{
	// credits
	draw_set_halign(fa_center);
	
	draw_set_colour(c_black);
	draw_text_transformed(960 / 2, 40, lang_string("manual.credits"), 2, 2, 0);
	draw_set_colour(c_red);
	draw_text_transformed(960 / 2, 38, lang_string("manual.credits"), 2, 2, 0);
	
	draw_text(280, 72, lang_string("manual.credits1"));
	draw_text(680, 72, lang_string("manual.credits2"));
	draw_text(480, 400, lang_string("manual.credits3"))
}
else if i == 6
{
	// credits+
	draw_set_halign(fa_center);
	
	draw_set_colour(c_black);
	draw_text_transformed(960 / 2, 40, lang_string("manual.creditspt2"), 2, 2, 0);
	draw_set_colour(c_red);
	draw_text_transformed(960 / 2, 38, lang_string("manual.creditspt2"), 2, 2, 0);
	draw_text(280, 72, lang_string("manual.credits4"));
	draw_text(680, 72, lang_string("manual.credits5"));
}
else if i == 7
{
	//ptox team
	draw_set_halign(fa_center);
	draw_set_colour(c_black);
	draw_text_transformed(960 / 2, 40, lang_string("manual.ptoxcredits"), 2, 2, 0);
	draw_set_colour(c_red);
	draw_text_transformed(960 / 2, 38, lang_string("manual.ptoxcredits"), 2, 2, 0);
	
	draw_text(480, 76, lang_string("manual.ptoxteam"));
	draw_text(480, 320, lang_string("manual.translationteam"));
}