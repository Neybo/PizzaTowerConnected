if instance_exists(obj_noisecrusher)
	draw_sprite_ext(spr_pizzahealthbar, 8 - global.bosshealth, 862, 80, 1, 1, 0, c_white, alpha)
draw_sprite_ext(noisesprite, -1, 832, 100, 1, 1, 0, c_white, alpha)

//Noise
if obj_player.state == states.hurt
	noisesprite = spr_noiseHUD_happy
else if obj_noisecrusher.state == states.stun or obj_noisecrusher.state == states.grabbed
	noisesprite = spr_noiseHUD_hurt
else if global.bosshealth <= 3
	noisesprite = spr_noiseHUD_lowhealth
else
	noisesprite = spr_noiseHUD_idle

