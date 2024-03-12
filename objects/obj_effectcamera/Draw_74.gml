application_surface_draw_enable(false);

draw_clear_alpha(c_black, 1)
draw_set_alpha(1)
draw_set_color(c_white)
visible = true
depth = -99999

effect_draw_full_data(surface_data)

application_surface_draw_enable(true);