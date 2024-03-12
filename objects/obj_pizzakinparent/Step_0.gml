var _spr_intro = spr_intro, _spr_idle = spr_idle, _spr_run = spr_run;

// strongcold sprites
if sc_check()
{
	_spr_intro = spr_intro_strongcold;
	_spr_idle = spr_idle_strongcold;
	_spr_run = spr_run_strongcold;
	
	if global.panic or playerid.state == states.frozen
	{
		// panicing (strongcold)
		_spr_idle = spr_panicidle_strongcold;
		_spr_run = spr_panic_strongcold;
	}
}
else if global.panic or playerid.state == states.frozen
{
	// panicing
	_spr_run = spr_panic;
	_spr_idle = spr_panicidle;
}

// done with intro
if sprite_index == _spr_intro && floor(image_index) >= image_number - 1 && _spr_intro != _spr_run
	sprite_index = _spr_idle

// animation
if (sprite_index != _spr_intro or _spr_intro == _spr_run)
&& (sprite_index != spr_taunt or spr_taunt == -1)
{
	// Sprites
	if x - xprevious != 0
	{
		sprite_index = _spr_run;
		xscale = sign(x - xprevious);
	}
	else
		sprite_index = _spr_idle;
	depth = -6;
}

// taunt
if spr_taunt != -1
{
	if playerid.sprite_index == playerid.spr_taunt && sprite_index != spr_taunt
	{
		with instance_create(x, y, obj_cloudeffect)
		{
			depth = other.depth + 1;
			sprite_index = spr_confectitaunt;
		}
		
		sprite_index = spr_taunt;
		image_index = random(image_number);
	}
	if sprite_index == spr_taunt
	{
		lerpx = x;
		lerpy = y;
		
		var target = playerid;
		if instance_exists(followid)
			target = followid;
		
		followqueue = [target.x, target.y];
		image_speed = 0;
		
		if playerid.sprite_index != playerid.spr_taunt
			sprite_index = _spr_idle;
	}
	else
		image_speed = 0.35;
}

if mimic
	image_blend = c_black