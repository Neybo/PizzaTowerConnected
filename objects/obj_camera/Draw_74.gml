//DDP Raise this value to change how intense the blur is
if instance_exists(obj_effectcamera)
	return

application_surface_draw_enable(false);

var reenableautodraw = true;

var appa = 1;
if global.panic && global.panicmelt
{
	appa = max(lerp(1.0, (1.0 - MAX_BLUR), global.wave / global.maxwave), 0.01);
	reenableautodraw = false;
}

var shader = noone;
if check_sugary() && ((global.panic && global.wave >= global.maxwave) or global.failedmod)
	shader = shd_greyscale;
else if !instance_exists(obj_endlevelfade)
	shaderfade = 0;

if shader != noone
{
	shaderfade = Approach(shaderfade, 0.45, 0.005);
	
	shader_set(shader)
	var fade = shader_get_uniform(shader, "fade")
	shader_set_uniform_f(fade, shaderfade)
	reenableautodraw = false
}


draw_surface_stretched_ext(application_surface, 0, 0, 960, 540, c_white, appa);

if shader != noone
	shader_reset();

application_surface_draw_enable(reenableautodraw);