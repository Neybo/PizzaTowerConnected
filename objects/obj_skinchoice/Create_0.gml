event_inherited();
noisetype = 0;
sel = [1.0, "P",  noone, 0]; // fucking true index i hate you

selvert = true;

spr_idle = -1;
spr_select = -1;

selected = false;

texture = global.texturelist

comingfromtex = false
savedsel = 0


// fuck fuck fuck fduck fuckc ufkck
surf = -1 // fuck you fuck you
img_angle = 0 // ficl jio sfdaih oifhdashsdf ajhb dfsii mkmsa asoanhdi;iokb
drawspr = spr_player_idle // HJSADFJKLFDSHFDKSHDFSLK

// shitty shit shit
function draw_player(pal, _spr, specialsprite, _x = 0, _y = 0, scale = 2, _texturemode = false, _pal2 = 0)
{
	if sprite_exists(spr_palette) && !specialsprite
		pal_swap_set(spr_palette, pal, false,, clamp(sel[3], 0, 1));
	if sprite_exists(_spr)
		draw_sprite_ext(_spr, img, (960 / 2) + xoffset + _x, (540 / 2) + yoffset + _y, scale, scale, 0, 
		(locked ? merge_colour(c_white, c_black, 0.75) : c_white), 
		((100 - abs(xoffset) - abs(yoffset)) / 100) * talpha);

	pal_swap_reset();
	if !specialsprite && ((_texturemode) ? texture[_pal2] : texture[sel[3]]) != -4
	{
		scr_drawtexture(_spr, img, 480 + xoffset + _x, 270 + yoffset + _y, scale, scale, 0,
		(locked ? merge_colour(c_white, c_black, 0.75) : c_white), 
		((100 - abs(xoffset) - abs(yoffset)) / 100) * talpha,
		(_texturemode) ? texture[_pal2] : texture[sel[3]], 600, 600, scale, spr_snicktexture)
		// use iq to save time
	}
}
