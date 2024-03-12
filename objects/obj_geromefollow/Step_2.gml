event_inherited();
yoffset = 0;

if x - xprevious != 0
{
	xscale = -sign(xprevious - x);
	sprite_index = spr_gerome_keymove;
}
else
	sprite_index = spr_gerome_keyidle;

