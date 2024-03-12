if scr_solidwall(x + hsp + sign(hsp), y - 1) or place_meeting(x + hsp * 2, y, obj_hallway) // or place_meeting(x + hsp * 2, y, obj_solid)
	hsp *= -1;
scr_collide();

if place_meeting(x, y, obj_otherplayer)
	image_alpha = 0.5;
else
	image_alpha = 1;
hpcreateelapsed += 1 / 60 // im too stupid leave me alone!
if (hpcreateelapsed > 1)
	cankill = true