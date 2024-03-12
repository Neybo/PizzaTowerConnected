with (other)
{
    if (key_up && grounded && (state == (0 << 0) || state == (79 << 0) || state == (80 << 0) || state == (40 << 0) || state == (94 << 0) || state == (75 << 0)) && (!instance_exists(obj_noisesatellite)) && (!instance_exists(obj_fadeout)) && state != (92 << 0) && ((.spotlight == 1 && object_index == ) || (.spotlight == 0 && object_index == obj_player2)))
    {
        with (other)
        {
            instance_create(x, y, obj_genericpoofeffect)
            .visible = false
            .sprite_index = .spr_idle
            .hsp = 0
            .vsp = 0
            .state = (92 << 0)
            scr_soundeffect(sfx_taxi2)
            playerid = 102
            sprite_index = spr_taximove
            hsp = 10
            .cutscene = 1
            if (global.coop == 1)
            {
                obj_player2.sprite_index = obj_player2.spr_idle
                scr_soundeffect(sfx_taxi2)
                playerid = 101
                sprite_index = spr_taximove
                hsp = 10
                obj_player2.visible = false
                obj_player2.hsp = 0
                obj_player2.vsp = 0
                obj_player2.state = (92 << 0)
                obj_player2.cutscene = 1
            }
        }
    }
}
