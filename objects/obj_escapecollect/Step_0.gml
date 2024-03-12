if global.panic || global.wartimer
	image_alpha = (place_meeting(x, y, obj_otherplayer) ? 0.5 : 1);
else
	image_alpha = 0.35;
