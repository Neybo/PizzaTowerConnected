if (playerid.state != states.mach3)
&& playerid.state != states.chainsaw 
&& playerid.state != states.crouchslide && playerid.state != states.rocket 
&& (playerid.state != states.punch 
|| playerid.sprite_index == playerid.spr_breakdancestart) // has to be for a frame
	instance_destroy()

x = playerid.x + (offsetx * sign(playerid.xscale))
y = playerid.y
image_xscale = playerid.xscale

