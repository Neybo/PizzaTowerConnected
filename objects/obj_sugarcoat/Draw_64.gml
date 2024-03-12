image_alpha -= 0.0175
draw_sprite_ext(spr_sugarcoat,image_index,x,y,1,1,0,c_white,image_alpha)
if (image_alpha <= 0)
	instance_destroy()