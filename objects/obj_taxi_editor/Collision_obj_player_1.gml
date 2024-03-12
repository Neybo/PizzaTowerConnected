if (index < 0)
{
}
if ((.state != (92 << 0) || obj_player2.state != (92 << 0)) && sprite_index == spr_taxiidle)
{
    with (obj_stopsign_editor)
    {
        if (index == other.index)
        {
            other.sign_id = id
            other.xx = x
            other.yy = y
        }
    }
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
