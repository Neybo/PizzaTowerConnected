/// @description Let's go swimming!
instance_destroy()
instance_create(x, y, obj_bossdefeatflash)
if (room == ancient_20)
{
    obj_tv.message = "VICTORY!!!"
    obj_tv.showtext = true
    obj_tv.alarm[0] = 260
    obj_tv.tvsprite = spr_tvclap
    obj_tv.image_speed = 0.1
    obj_player.image_index = 0
    obj_player.x = 704
    obj_player.hsp = 0
    obj_player.y = 562
    obj_player.sprite_index = spr_player_levelcomplete
    obj_player.state = states.victory
	with obj_player
	{
		event_perform(ev_step_begin, 0)
		 obj_player.hsp = 0
		 obj_player.sprite_index = spr_player_levelcomplete
	}
	obj_player.hsp = 0
	fmod_set_vol(global.music, 0, false)
    instance_create(1230, 562, obj_noise_pushbutton)
}
















