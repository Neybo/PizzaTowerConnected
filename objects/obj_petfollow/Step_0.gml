// Sprites
if x != xprevious
{
	sprite_index = spr_petrun;
	xscale = sign(x - xprevious);
}
else
	sprite_index = spr_petidle;
depth = -6;

if petind != obj_player.petfollow
{
	petind = obj_player.petfollow;
	scr_petspr(petind);
	
	repeat 5
	{
		with instance_create(x + random_range(-50, 50), y + 25 + random_range(-25, 50), obj_cloudeffect)
			depth = other.depth - 1;
	}
}

xoffsetmax = 35;
if petind == 1 or petind == 3 // noiserat or grunt
	xoffsetmax += 5;
if obj_player.character == "S"
	xoffsetmax += 10;

if room == rank_room
	visible = false;

// misty float
if petind == 10 or petind == 11
{
	var sindiv = 20;
	if petind == 11
		sindiv = 15;
	
	siner++;
	yoffset = floor(-5 + sin(siner / sindiv) * -5);
}
else
	yoffset = 0;

// sync
if check_online()
{
	gms_self_set("petx", x);
	gms_self_set("pety", y + yoffset + yslope);
}
