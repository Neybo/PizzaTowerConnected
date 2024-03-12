if global.playertexture <= 0
    surf_free()
if state == states.hang
	state = states.normal;

insidefreezer = string_startswith(room_name, "oldfreezer_")

with obj_secretportal
{
    if secret
    {
        if !instance_exists(obj_ghostcollectibles)
            instance_create(0, 0, obj_ghostcollectibles)
    }
}

if place_meeting(x, y + 1, obj_boxofpizza) or place_meeting(x, y - 1, obj_boxofpizza)
{
	box = true;
	hallway = false;
	state = states.crouchjump;
	jumpstop = true;
}

if !oldhallway
{
	var doortarget = noone;
	with obj_doorPARENT
		if door == other.targetDoor doortarget = id;
	
	if (hub_pvp == room)
		with (obj_doorA)
			doortarget = id
	
	if instance_exists(doortarget)
	{
		y = doortarget.y - 14;
		if !instance_exists(obj_randomsecret)
		{
			if hallway
				x = doortarget.x + (hallwaydirection * 90);
			else if box
				x = doortarget.x + 32;
			else if verticalhallway
			{
				var hw = 32;
				with doortarget
				{
					var vh = instance_place(x, y, obj_verticalhallway);
					if vh
					{
						x = vh.x;
						hw = vh.sprite_width;
					}
				}
			
				x = doortarget.x + floor(vhallwaypos * hw);
				if scr_solid_player(x, y)
					x = doortarget.x + 18;
			}
			else
				x = doortarget.x + 18;
		}
		else
			x = doortarget.x + 18;
		
		if targetDoor == "A" && place_meeting(x, y, obj_exitgate)
			x -= 18;
	}
	
	// avoid spawning inside of a hallway
	var hallwayprotect = instance_place(x, y, obj_hallway);
	if hallwayprotect && hallwayprotect.image_xscale != 0
	{
		xscale = sign(-hallwayprotect.image_xscale);
		x += xscale * 100
	}
	
	
	if verticalhallway
		y += vhallwaydirection * 50;
	
	if is_real(targetDoor)
	{
		if !fmod_is_instance_playing(global.music)
		{
			with obj_music
				wait = true;
		}
		
		with obj_teleporter
		{
			if trigger == other.targetDoor && !start
			{
				player.x = x
				player.y = y - 14
				alarm[1] = 15;
			}
		}
	}
}
else
{
	x = target_x
	y = target_y
}

// snap to wall if climbing
if state == states.climbwall
{
	var xx = x;
	while !scr_solid(x + xscale, y)
	{
		x += xscale;
		if abs(x) > room_width
		{
			x = xx;
			break;
		}
	}
	x -= xscale; // you've collided too much. now step back, again.
	
	grounded = scr_solid_player(x, y + 1)
}

// dont fall off the ladder Please
if state == states.ladder
	doorx = x;

if box
	grounded = false;

hallway = false
verticalhallway = false
box = false
oldhallway = false

if isgustavo
    brick = true

roomstartx = x
roomstarty = y
hitX = x
hitY = y

// bringing baddies through rooms (rest of the code is in obj_fadeout)
if baddiegrabbedID != 0 && baddiegrabbedID != obj_null && baddiegrabbedID != obj_otherplayer
{
	with baddiegrabbedID
		persistent = false;
	with obj_baddiecollisionbox
		if baddieID == other.baddiegrabbedID
			persistent = false;
}

if (is_fullgame_room() and !fullgame) 
or (check_online() && !global.pvp && scr_pvparenacheck())
{
	scr_soundeffect(sfx_denied)
	room_goto(hub_room1)
	targetDoor = "A"
}

// correct online position
if check_online()
{
	gms_self_set("x", x);
	gms_self_set("y", y);
}

// baddie tombs
if !ds_list_empty(global.baddietomb)
{
	for(var i = 0; i < ds_list_size(global.baddietomb); i++)
	{
		var arr = ds_list_find_value(global.baddietomb, i);
		var tombRoom = arr[0];
		var X = arr[1];
		var Y = arr[2];
		var spr = arr[3];
		
		if !is_undefined(tombRoom) && !is_undefined(X) && !is_undefined(Y)
		{
			if room == tombRoom
			{
				with instance_create(X, Y, obj_baddiegibsstick)
				{
					storedx = X;
					storedy = Y;
					grounded = true;
					hsp = 0;
					vsp = 0;
					saveable = false;
					
					image_index = image_number - 1;
					if !is_undefined(spr)
						sprite_index = spr;
				}
			}
		}
	}
}