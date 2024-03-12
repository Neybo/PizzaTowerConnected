if instance_exists(obj_pausefadeout)
	instance_destroy(obj_pausefadeout)

if fadealpha > 1
{
	fadein = true
	if instance_exists(obj_player)
	{
			with obj_player
			{
				if place_meeting(x, y, obj_goldendoor)
				{
					gms_logout();
					game_restart()
				}
				if baddiegrabbedID != 0 && baddiegrabbedID != obj_null && instance_exists(baddiegrabbedID)
				&& baddiegrabbedID.object_index != obj_pizzaballOLD
				&& baddiegrabbedID.object_index != obj_otherplayer
				{
					with baddiegrabbedID
						persistent = true;
					with obj_baddiecollisionbox
						if baddieID == other.baddiegrabbedID
							persistent = true;
				}
			}
			
			if room == hub_outsideAFK
			{
				with obj_player
				{
					sprite_index = spr_lookdoor		
					image_index = 0		
					state = states.door
				}
			}
			if instance_exists(obj_randomsecret)
			{
				var targetAcquired = scr_chooserandomsecret_return()
				with obj_player
				{
					state = states.normal
					movespeed = 0
					targetRoom = targetAcquired[0]
					targetDoor = targetAcquired[1]
					scale_xs = 1
					scale_ys = 1
				}
			}
			if room != obj_player.targetRoom
				room_goto_new(obj_player.targetRoom)
			else
			{
				with obj_player
					event_perform(ev_other, ev_room_start);
				with obj_door
					event_perform(ev_other, ev_room_start);
			}
			
			with obj_player
				if state == states.ladder
					ladderbuffer = 3;
			if instance_exists(obj_player) && obj_player.state == states.grabbed
			{
				fadealpha = 1
				cont = false;
				alarm[0] = 5;
			}
	}
}

if !fadein
	fadealpha += 0.1
else if cont
	fadealpha -= 0.1

with obj_player
{
	if other.fadein && (state == states.door or state == states.victory)
	{
		if sprite_index == spr_downpizzabox or sprite_index == spr_uppizzabox
			state = states.crouchjump
		else
		{
			c = 0;
			state = states.comingoutdoor
			image_index = 0
		}
	}
}

if fadein && fadealpha <= 0
	instance_destroy()

