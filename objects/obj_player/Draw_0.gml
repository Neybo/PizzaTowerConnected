//Draw
image_angle = img_angle
drawspr = sprite_index;
var _img = image_index;

// pln room color
var col = image_blend;
if room == hub_roomPLN
{
	var startgate = instance_place(x, y, obj_startgate);
	if !(startgate && startgate.image_index == 1)
		col = merge_colour(col, c_black, 0.4);
}

//if state != states.cheeseball && state != states.cotton
//{
if scr_checkskin(checkskin.p_peter)
	drawspr = spr_player_petah;
if scr_checkskin(checkskin.n_big)
	drawspr = spr_playerN_chungus;
if scr_checkskin(checkskin.s_sbombic)
	drawspr = spr_sbombic;
/*if character == "PUFFER"
{
	if x != xprevious
		drawspr = spr_pufferfish_move;
	else
		drawspr = spr_pufferfish_idle;
}*/
//}

// flashing and apply palette
if !flash
{
	if (state != states.ghost or (drawspr == spr_player_ghostend && image_index >= 12))
	{
		pal_swap_set(spr_palette, paletteselect, false);
		//}
	} 
	//else if inverted
//		shader_set(shd_invert)
}
else
	draw_set_flash(true);
	
if global.sloperot && state != states.knightpepslopes && state != states.Sjumpprep
{	
	// TODO: find a better way?
	var slope = instance_place(x, y + 1, obj_slope)
	var slopecheck = slope && scr_slope()// && state != states.backbreaker
	
	
	if !slopecheck
	    img_angle = lerp(img_angle, 0, 0.3)
	else
	{
	    with slope
	    {
			var origin = [x + (16 * abs(image_xscale)), y + (16 * abs(image_yscale))] 
			
			var funny = abs(image_yscale) + abs(image_xscale)
			// pie guy theory, this is shit but it works better
			var dist = distance_between_points(origin[0], origin[1], other.x, other.y) 
			/ (funny / 2 - (funny / 4 * (funny > 12)))
			
			var angle = lerp(0, 45, clamp(24 / dist + 0.05, 0, 1))
			
			other.img_angle = round(lerp(other.img_angle, 
			angle * (image_yscale / image_xscale), 0.3))
		}
	}
}
else
	img_angle = 0;

draw_set_blend_mode(bm_normal)
var shakeamt = random_range(-shake, shake)
// draw
draw_sprite_ext(drawspr, _img, x + shakeamt, y, xscale * scale_xs, yscale * scale_ys, 
img_angle, col, image_alpha);

// reset flash and palette
draw_set_flash(false);
pal_swap_reset();
if !flash
{
	scr_drawtexture(drawspr, _img, x + shakeamt, y, xscale * scale_xs, yscale * scale_ys, 
	img_angle, col, image_alpha,,,,,spr_texture)
	//my pepper is pizzad
	if pizzapepper
	{
		pal_swap_set(spr_pepperpal, 1, false, true);
		draw_sprite_ext(drawspr, _img, x + shakeamt, y, xscale * scale_xs, yscale * scale_ys, 
		img_angle, col, image_alpha);
		pal_swap_reset();
	}
}

// cowboy hat
if hatsprite > -1
{
	hatimg += sprite_get_speed(hatsprite);
	if hatimg >= sprite_get_number(hatsprite)
		hatimg -= sprite_get_number(hatsprite);
	
	var yplus = lengthdir_y(-sprite_get_bbox_top(drawspr) + 40, img_angle + 90);
	draw_sprite_ext(hatsprite, hatimg, x, y + yplus + (50 - sprite_get_yoffset(drawspr)), xscale, yscale, img_angle, col, image_alpha);
}

// Draw name
if check_online()
{
	// get player name
	var nick = name_gms_empty(gms_self_name(), nickname);
	
	// apply color
	draw_set_colour(make_colour_hsv(color_get_hue(nickcol), color_get_saturation(nickcol), color_get_value(nickcol) * (color_get_value(col) / 255)));
	
	// setup
	draw_set_font(global.font_small);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	var yy = clamp(sprite_get_bbox_top(drawspr) + y - 75, 0, room_height - 16);
	
	// draw
	draw_text(x, yy, nick);

	if (scr_pvparenacheck())
	{
		draw_set_halign(fa_center);
		draw_set_colour(c_red);
		draw_text(x, yy - 48, "Damage dealt: " + string(obj_pvparena.damagedealt));
		var text = string(floor(obj_pvparena.elapsedtimelasted / 60)) + ":"
		if (obj_pvparena.elapsedtimelasted % 60 < 10)
			text += "0"
		text += string(floor(obj_pvparena.elapsedtimelasted % 60))
		draw_set_colour(c_green);
		draw_text(x, yy - 24, text);
	}
	
	//reset
	draw_set_halign(fa_left);
	draw_set_colour(c_white);
}