// Set retreat and out timer
if !ds_exists(global.boxlist, ds_type_list)
{
	instance_destroy();
	exit;
}

switch global.boxhp
{
	case 20:
	case 19:
		getoutspd = 120;
		outtimespd = 120;
		break;
	
	case 18:
	case 17:
		getoutspd = 100;
		outtimespd = 100;
		break;
	
	case 1:
		getoutspd = 5
		outtimespd = 5
		break
	
	case 0: 
		instance_destroy(obj_presentbox);
		exit;
		break; // idk if this matters
	
	default:
		getoutspd = 80;
		outtimespd = 80;
		break;
}

// Characters
if box == 1
	character = ds_list_find_index(global.boxlist, "box1")
if box == 2
	character = ds_list_find_index(global.boxlist, "box2")
if box == 3
	character = ds_list_find_index(global.boxlist, "box3")
if box == 4
	character = ds_list_find_index(global.boxlist, "box4")
if box == 5
	character = ds_list_find_index(global.boxlist, "box5")

switch character
{
	case 0:
		upspr = spr_noisepresentup
		spr = spr_noisepresent
		downspr = spr_noisepresentdown
		deadspr = spr_playerN_hurt
		break

	case 1:
		upspr = spr_gustavopresentup
		spr = spr_gustavopresent
		downspr = spr_gustavopresentdown
		deadspr = spr_gustavopresentdead
		break

	case 2:
		upspr = spr_snickpresentup
		spr = spr_snickpresent
		downspr = spr_snickpresentdown
		deadspr = spr_snickpresentdead
		break

	case 3:
		upspr = spr_slimepresentup
		spr = spr_slimepresent
		downspr = spr_slimepresentdown
		deadspr = spr_slimepresentdead
		break
		
	case 4:
		upspr = spr_stickpresentup
		spr = spr_stickpresent
		downspr = spr_stickpresentdown
		deadspr = spr_stickpresentdead
		break
}

// Contact with player
with instance_place(x, y, obj_player)
{
	if (((state = states.handstandjump or state = states.kungfu or state == states.punch) && character != "S")
	or (character == "S" && (state == states.handstandjump or state == states.mach3 
	or state == states.mach2)))
	&& other.sprite_index != spr_present
	{
		if (state == states.handstandjump 
		or state == states.punch or state = states.kungfu) && character != "S"
			scr_pummel();

		with other
			event_user(0);
	}
}

// Tick down the timer for the character to come out
if sprite_index == spr_present
{
	getout -= 1;
	if getout <= 0 && ((character == 0 or global.boxhp < 14)
	or (global.boxhp < 18 && character == 1) or (global.boxhp < 17 && character == 2) 
	or (global.boxhp < 16 && character == 3) or (global.boxhp < 15 && character == 4))
	{
		image_index = 0;
		sprite_index = upspr;
	}
}
else
{
	if (place_meeting(x, y, obj_baddie) && obj_baddie.thrown)
	or place_meeting(x, y, obj_shotgunbullet) or place_meeting(x, y, obj_antonball)
		event_user(0);
}

//Go idle sprite
if floor(image_index) >= image_number - 1 && sprite_index == upspr
{
	//Noise throwing bombs
	if character = 0 && global.boxhp < 3 && global.boxhp != 1
	{
		scr_soundeffect(sfx_enemyprojectile);
		with instance_create(x, y, obj_pizzagoblinbomb)
		{
			var a = 1
			if x != obj_player.x
				a = -sign(x - obj_player.x);
			hsp = a * 10
			vsp = -8
		}
	}
	sprite_index = spr
}

// Timer down when idle
if sprite_index == spr
{
	outtime -= 1;
	if outtime <= 0
	{
		image_index = 0;
		sprite_index = downspr;
	}
}

//Go back to present and reset variables
if sprite_index == downspr && floor(image_index) >= image_number-1
{
	ds_list_shuffle(global.boxlist);
	with obj_presentbox
	{						
		getout = getoutspd;
		outtime = outtimespd;
		sprite_index = spr_present;
	}
}


// Noisey spawn
if !instance_exists(obj_baddiespawner) && global.boxhp == 10
with instance_create(480, 288, obj_baddiespawner)
{
	content = obj_noisey;
	instance_create(x, y, obj_genericpoofeffect);
}

