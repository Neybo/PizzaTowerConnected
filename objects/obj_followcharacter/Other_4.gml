followqueue = [];
lerpx = undefined;
lerpy = undefined;

var target = obj_player;
if instance_exists(target)
{
	xscale = target.xscale;
	if off_on_y
		xoffset = 0;
	else
		xoffset = -xscale * xoffsetmax;
	
	followqueue = [target.x + xoffset * pos, target.y];
	x = followqueue[0] + xoffset;
	y = followqueue[1];
	
	lerpx = x;
	lerpy = y;
}

