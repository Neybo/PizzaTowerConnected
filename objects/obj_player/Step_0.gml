scr_getinput(,true);
animEnd = scr_anim_end()

statefunction();
/*if instance_exists(obj_wartimer)
	global.wartimer = 1
else
	global.wartimer = 0*/

basegrav = 0.5;

breakdance_buffer--;
faceplantbuffer--;

if !place_meeting(x, y + 1, obj_railparent)
{
    if state == states.mach3 or state == states.mach2 or state == states.tumble
        railmovespeed = Approach(railmovespeed, 0, 0.1)
    else
        railmovespeed = Approach(railmovespeed, 0, 0.5)
}

if FINAL_GAMEPLAY
{
	if !global.performancemode
	{
		// blur afterimages
		if blur_effect > 0
		    blur_effect--
		else if breakdance_speed >= 0.6 or boxxeddash or state == states.ghost 
		or state == states.tumble or state == states.ratmountbounce 
		or state == states.ratmountattack or state == states.handstandjump 
		or state == states.barrelslide or state == states.kungfu
		or (state == states.grab && sprite_index == spr_swingding && swingdingdash <= 0) 
		or state == states.freefall or (state == states.cotton 
		or state == states.trickjump
		&& (sprite_index == spr_cotton_attack or movespeed > 6))
		{
		    if visible && !place_meeting(x, y, obj_secretportal) && !place_meeting(x, y, obj_secretportalstart)
		    {
		        blur_effect = 2
		        with instance_create(x, y, obj_blurafterimage)
				{
					sprite_index = other.sprite_index
					image_index = other.image_index
					image_xscale = other.xscale
		            playerid = other.id
				}
		    }
		}
	}

	// invhurt
	invhurt_buffer--;
	if state == states.hurt
	{
		if hurt_buffer > 0
			hurt_buffer--;
		else
		{
			invhurt_buffer = invhurt_max;
			hurt_buffer = -1;
		}
	}
	else
	{
		if hurt_buffer > 0
			invhurt_buffer = invhurt_max;
		hurt_buffer = -1;
	}
}

if global.heatmeter
{
	// heat meter
	if global.heattime > 0
		global.heattime -= 0.25;
	if global.heattime <= 0 && global.style > -1 && !global.stylelock
		global.style -= 0.05;
	if state == states.victory && place_meeting(x, y, obj_startgate) && global.style > -1
		global.style -= 5;

	if cutscene or global.miniboss
		global.heattime = 60;
}

if wallclingcooldown < 10
	wallclingcooldown++
if noisebombcooldown > 0
	noisebombcooldown--

//Pepper Pizza
if pizzapepper
{
	angry = true
	anger = 1
	
	//pizzapepper--
	if pizzapepper <= 0
	{
		angry = false;
		anger = 0;
	}
}

//Supercharge
if global.combo != global.previouscombo
{
    global.previouscombo = global.combo
    if (global.combo % 5) == 0 && global.combo != 0
    {
        with instance_create(x, y - 80, obj_combotitle)
        {
            title = floor(global.combo / 5)
            title = clamp(title, 0, floor(sprite_get_number(spr_comboend_title1) / 5))
        }
    }
}

if (state != states.door && state != states.tube && state != states.taxi 
&& state != states.gottreasure && state != states.victory && state != states.actor 
&& state != states.comingoutdoor && (state != states.knightpep ||
(sprite_index != spr_knightpepstart && sprite_index != spr_knightpepthunder))
&& !instance_exists(obj_fadeout) && !place_meeting(x, y, obj_secretportal) 
&& !place_meeting(x, y, obj_secretportalstart)
&& !global.miniboss)
{
	if global.combotime > 0 && !cutscene 
	&& !(scr_pizzyphys_check() && state == states.tacklecharge)
		global.combotime -= OLD_GAMEPLAY ? 0.35 : 0.125;
}



//Supercharged effect
if !instance_exists(superchargedeffectid) && supercharged
{
	with instance_create(x, y, obj_superchargeeffect)
	{
		playerid = other.object_index	
		other.superchargedeffectid = id
	}
}
if instance_exists(superchargedeffectid) && !supercharged
	instance_destroy(superchargedeffectid);
 
//Pizzashield
if !instance_exists(pizzashieldid) && pizzashield
{
	with instance_create(x,y,obj_pizzashield)
	{
		playerid = other.object_index	
		other.pizzashieldid = id
	}
}
 
//Player sounds
scr_playersounds()

//Reset doublejump for Noise
if grounded && vsp >= 0
	doublejump = false

//Jetpack flash
if pogochargeactive
{
	if !flashflicker
	{
		if pogochargeactive && sprite_index == spr_playerN_pogofall
			sprite_index = spr_playerN_pogofallmach

		if pogochargeactive && sprite_index == spr_playerN_pogobounce
			sprite_index = spr_playerN_pogobouncemach
	}
	
	flashflicker = true
	pogocharge--
}
else
	flashflicker = false

if state != states._throw
	kickbomb = false

if pogocharge <= 0
{
	pogochargeactive = false
	pogocharge = 100
}

//Flash flicker
if flashflicker
{
	flashflickertime++
	if flashflickertime >= 20
	{
		flash = true
		flashflickertime = 0
	}
}

//Thrown at enemy
if state != states.grabbed && state != states.hurt
	thrown = false
	
// game over
if state == states.gameover && y > room_height * 2
{
	scr_playerreset();
	targetDoor = "NONE";
	if backtohubstartx == 0 && backtohubstarty == 0
		targetDoor = "A";
	else
	{
		x = backtohubstartx;
		y = backtohubstarty;
	}
	room_goto(backtohubroom);
	
	backtohubstartx = 0;
	backtohubstarty = 0;
	backtohubroom = hub_room1;
}

//Out of grab
if (baddiegrabbedID == obj_null or !instance_exists(baddiegrabbedID) 
or baddiegrabbedID == 0 or baddiegrabbedID == -1) 
&& (state == states.grab or state == states.superslam or state == states.tacklecharge)
	state = states.normal

//Grind
if grinding
	state = states.grind

//Angry
if anger > 0
{
	angry = true;
	anger -= 1;
}
else
	angry = false;

if character == "V"
{
	if state != states.grab && state != states.grabbed
		swingdingbuffer = 0
	
	if global.playerhealth <= 30
	{
		if instance_exists(obj_sweat)
		{
			with instance_create(x, y, obj_sweat)
				playerid = other.id;
		}
	}
}

//Input buffer jumping
if input_buffer_jump < 8
	input_buffer_jump++

//Input buffer second jumping
if input_buffer_secondjump < 8
	input_buffer_secondjump++

//Input buffer high jumping
if input_buffer_highjump < 8
	input_buffer_highjump++

if input_buffer_faceplant < 8
	input_buffer_faceplant++

if shoot_buffer > 0
	shoot_buffer--;

//Key effect
if key_particles
	instance_create(random_range(x + 25, x - 25), random_range(y + 35, y - 25), obj_keyeffect)

if !inv_frames && !hurted && state != states.ghost
	image_alpha = 1

//Attack
attacking = _attacking
			or (state == states.jump && sprite_index = spr_playerN_noisebombspinjump) 
			or pizzapepper

//Grab Moves
grabbing = _grabbing

//Instant-Kill Attack
instakillmove = _instakillmove
or (state == states.jump && sprite_index == spr_playerN_noisebombspinjump) 
or (state == states.hurt && thrown) 
or (state == states.superslam && sprite_index = spr_piledriver) 
or (state == states.handstandjump && 
(sprite_index == spr_attackdash or sprite_index == spr_airattackstart or sprite_index == spr_airattack)) 
or (sprite_index == spr_swingding && FINAL_GAMEPLAY)
			
if pizzapepper && !_pepperinstakillmove // FINAL INVERSE NOTE !!
	instakillmove = true

//Flash																	  
if flash && alarm[0] <= 0
	alarm[0] = 9;

if state != states.mach3 
{
	if state != states.machslide
		autodash = false
	if (state != states.mach2 && state != states.trickjump)
	{
		ramp = false;
		ramp_points = 0
	}
}

if state != states.backbreaker
{
	if !(state == states.grab or state == states.superslam or state == states.mach2 
	or state == states.finishingblow or state == states.tacklecharge or state == states.hitlag)
	{
		baddiegrabbedID = obj_null
		heavy = false
	}
	
	if global.combotime <= 0
	{
		global.savedcombo = global.combo;
		global.combotime = 0;
		global.combo = 0;
	}
	
	if ((global.combo >= 3 && OLD_GAMEPLAY) or (supercharge > 9 && FINAL_GAMEPLAY))
	&& character != "S"
	{
		if character != "V"
		{
			if !supercharged
			{
				global.ammo = min(global.ammo + global.useammo, 3)
				global.bullet = min(global.bullet + global.usebullet, 3)
			}
			supercharged = true
		}
		else
			anger = 100
	}
	
	//POGO
	if state != states.pogo
	{
		pogospeed = 6
		pogospeedprev = false
	}
}

if state != states.gameover
{
	//Die
	if global.playerhealth <= 0  
	{
		image_index = 0
		sprite_index = spr_dead
		state = states.gameover
	}
	
	// Bottomless pits
	if (y > room_height + 150 or place_meeting(x, y, obj_backtostart)) && !cutscene
	&& canfall && state != states.comingoutdoor && visible
	{		
		grav = basegrav;
		vsp = 10;
		hsp = 0;
		
		x = roomstartx;
		y = roomstarty;
		if instance_exists(obj_falloffrespawn)
		{
			var falloffrespawn = instance_nearest(x, y, obj_falloffrespawn);
			x = falloffrespawn.x;
			y = falloffrespawn.y;
		}
		
		scr_transfobump(false);
		
		if !skateboarding
		{
			state = states.freefall;
			if place_meeting(x, y + 8, obj_boxofpizza)
			{
				state = states.crouchjump;
				jumpstop = true;
				vsp = -4;
			}
		}
	}
}

if state != states.normal
{
	// Stop winding up
	if sprite_index == spr_winding
		windingAnim = 0
	if state != states.machslide
	{
		machslideAnim = false
		if state != states.freefallland
			facehurt = false
	}
	idle = 0
	dashdust = false
	
	// reset shot variable
	if state != states.pistol
		shot = false
		
	with obj_sweat
	{
		if playerid == other.id
			instance_destroy();
	}
}
else
{
	//Angry cloud
	if (angry or global.stylethreshold >= 2) && !instance_exists(angryeffectid)
	&& character != "V"
	{
		with instance_create(x, y, obj_angrycloud)
		{
			playerid = other.object_index
			other.angryeffectid = id	 
		}
	}
}


if state != states.Sjump
{		
	sjumpvsp = -12;
	// pizzelle one time super jump
	if grounded
		sjump = true;
}
// reset face stomp anim
if state != states.facestomp
	facestompAnim = false

// reset mach punch anim
if state != states.mach2
	machpunchAnim = false

// ladder buffer
if state != states.ladder
	ladderbuffer--

if state != states.handstandjump
{
	if state != states.tumble
		crouchslipbuffer = 0	
	
	//Reset suplex
	if grounded && (state != states.cotton or grounded)
		suplexmove = false;
}
if state != states.freefall
{
	if state != states.hitlag
		freefallsmash = 0
		
	if state != states.cotton
		freefallvsp = 15;
		
	// reset super slam time
	if state != states.facestomp && state != states.superslam 
    && state != states.freefallland
		superslam = 0
}

if state != states.jump
{
	// reset stomp
	stompAnim = false
	
	if state != states.normal
	{
		if state != states.handstandjump
		{
			// reset momentum
			if state != states.hitlag && state != states.mach1
			&& state != states.mach2 && state != states.mach3 && state != states.freefallprep 
			&& state != states.knightpep && state != states.shotgun && state != states.knightpepslopes 
			&& state != states.faceplant && state != states.cotton
				momentum = false
				
			// reset mort
			if mort && state != states.pistol
				mort = false;

		}
	}
	if (state != states.crouchjump && state != states.slap) or vsp < 0
		fallinganimation = 0
}
// reset gravity
if state != states.grabbing && state != states.barrel && state != states.tumble 
	&& state != states.ghost && sprite_index != spr_pmortjump && state != states.cotton 
	&& state != states.fling
	grav = basegrav;
else if state == states.barrel or (state == states.tumble && FINAL_GAMEPLAY)
	grav = 0.6;

// reset black fade
if state != states.comingoutdoor && c < 255
{
	c = 255;
	image_blend = c_white;
}

// colorful afterimages
if _colorfulafterimages or sprite_index == spr_barrelroll
or (state == states.parry && NOT_FINAL_GAMEPLAY_ONLY)
or (state == states.jump && sprite_index == spr_playerN_noisebombspinjump) or pogochargeactive
or (OLD_GAMEPLAY && state == states.cotton 
&& (movespeed > 6 or sprite_index == spr_cotton_attack))
{
	if !macheffect
	{
		macheffect = true;
		if (state == states.punch)
			toomuchalarm1 = 12;
		else
			toomuchalarm1 = 6;
	}
	
	toomuchalarm1 -= 1;
	if toomuchalarm1 <= 0
	{
		with instance_create(x, y, obj_mach3effect)
		{
			playerid = other.id
			image_index = other.image_index
			image_xscale = other.xscale
			sprite_index = other.drawspr
			image_angle = other.img_angle
		}
		if (state == states.punch)
			toomuchalarm1 = 12;
		else
			toomuchalarm1 = 6;
	}
}
else
{
	macheffect = false;
	with obj_mach3effect
	{
		if !keep && playerid == other.id
		{
			if playerid.character != "SP" or OLD_GAMEPLAY
				instance_destroy();
			else
				image_alpha -= 0.1;
		}
	}
}

//Mask
if character == "S"
{
	if state == states.crouchjump or state == states.crouch
		state = states.normal;
	
	if state == states.bombpep or state == states.firemouth 
	or state == states.hurt or state == states.cheeseball
		mask_index = spr_player_mask
	else
		mask_index = spr_crouchmask
}
else
{
	if !scr_solid_player(x, y)
	{
		if _playermaskcheck && sprite_index != spr_barrelroll && sprite_index != spr_bombpepintro 
		&& sprite_index != spr_knightpepthunder
		&& sprite_index != spr_breakdancesuper && sprite_index != spr_cotton_roll 
		&& sprite_index != spr_cotton_rollmax
		{
			mask_index = spr_player_mask;
			if scr_solid_player(x, y)
				mask_index = spr_crouchmask;
		}
		else
			mask_index = spr_crouchmask
	}
	else
	{
		// push out of block
		if state == states.jump or state == states.ladder
			y++;
		else
			mask_index = spr_crouchmask;
	}
}

// cutscene
cutscene = (
	state == states.gottreasure or sprite_index == spr_knightpepstart 
	or sprite_index == spr_knightpepthunder
	or state == states.keyget or state == states.door or state == states.ejected
	or state == states.victory or state == states.comingoutdoor or state == states.gameover
	or place_meeting(x, y, obj_secretportal) or place_meeting(x, y, obj_secretportalstart)
	or place_meeting(x, y, obj_ghostjohn)
)

//Up arrow
var exitgate = instance_place(x,y,obj_exitgate)
if (place_meeting(x, y, obj_door) && !place_meeting(x, y, obj_doorblocked)
or place_meeting(x, y, obj_uparrow_object) 
or (place_meeting(x, y, obj_hubelevator) 
&& instance_place(x, y, obj_hubelevator).state == 0) or 
(place_meeting(x, y, obj_geromedoor) && global.gerome) or 
(exitgate && 
(global.panic or exitgate.forceopen or global.snickchallenge 
or (global.wartimer and not exitgate.forceclose))
&& !global.failedmod)
&& grounded)
{
	var arrowexists = false;
	with obj_uparrow
		if playerid == other.id arrowexists = true;
	
	if !arrowexists
	{
		with instance_create(x + hsp, y - 50 + vsp, obj_uparrow)
			 playerid = other.id
	}
}
else with obj_uparrow
{
	if playerid == other.id
		instance_destroy();
}
 
// speed lines
if (FINAL_GAMEPLAY && state == states.mach3) 
or (OLD_GAMEPLAY && state == states.mach2)
{
	if !instance_exists(speedlineseffectid)
	{
		with instance_create(x, y, obj_speedlines)
		{
			playerid = other.object_index
			other.speedlineseffectid = id
		}
	}
}
else if instance_exists(speedlineseffectid)
	instance_destroy(speedlineseffectid);

// collision
scr_collide_destructibles();

if state == states.tube or state == states.gotoplayer
{
    x += hsp
    y += vsp
}
else if state != states.titlescreen && state != states.grabbed && state != states.door 
&& state != states.ejected && state != states.comingoutdoor && state != states.keyget 
&& state != states.victory && state != states.portal && state != states.timesup 
&& state != states.gottreasure && state != states.rotate 
&& state != states.gameover && (state != states.backbreaker or OLD_GAMEPLAY)
	scr_collide_player();

prevstate = state
prevsprite = sprite_index

// correct depth
depth = (state == states.grabbed ? -5 : -7);

//if state == states.rotate
//	depth = obj_camera.depth - 1;

if shake > 0
	shake = max(shake - 0.5, 0);
