function distance_to_pos(x1,y1,x2,y2,xdist,ydist){
	return (abs(x1 - x2) <= xdist) && (abs(y1 - y2) <= ydist)
}

function distance_between_points(x1, y1, x2, y2)
{
	return sqrt(sqr(x2 - x1) + sqr(y2 - y1));
}

function angle_rotate(angle, target, speed)
{
	var diff;
	// 180 is to be replaced by "pi" for radians
	diff = cycle(target - angle, -180, 180);
	// clamp rotations by speed:
	if (diff < -speed) return angle - speed;
	if (diff > speed) return angle + speed;
	// if difference within speed, rotation's done:
	return target;
}

function cycle(value, min, max)
{
	var result, delta;
	delta = (max - min);
	// % is remainder-of-division operator here.
	// limit input to (-delta .. +delta):
	result = (value - min) % delta;
	// wrap negative results around the limit:
	if (result < 0) result += delta;
	// return adjusted input:
	return result + min;
}

function magnitude(a, b)
{
	return sqrt(abs(a) + abs(b));
}

function get_projectile_angle(argument0, argument1, argument2, argument3, argument4, argument5)
{
	var xt = floor(argument2 - argument0);
	var yt = -floor(argument3 - argument1);
	var root = power(argument4, 4) - (argument5 * ((argument5 * sqr(xt)) + (2 * sqr(argument4) * yt)));
	var angle = 0;
	if (root > 0)
	{
		angle = radtodeg(arctan((sqr(argument4) + sqrt(root)) / (argument5 * xt)));
		if (xt < 0)
			angle -= 180;
	}
	else if (xt > 0)
		angle = 45;
	else
		angle = 135;
	return angle;
}
