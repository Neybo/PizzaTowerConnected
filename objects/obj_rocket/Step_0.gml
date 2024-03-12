if instance_exists(playerid) && (playerid.state == states.rocket 
|| playerid.state == states.rocketslide || 
(playerid.state == states.hitlag && (sprite_index == playerid.spr_rocket 
|| sprite_index == playerid.spr_rocketstart)))
	image_alpha = 0
else if !(instance_exists(playerid) && playerid.state == states.backbreaker)
	image_alpha = place_meeting(x, y, obj_otherplayer) ? 0.5 : 1

