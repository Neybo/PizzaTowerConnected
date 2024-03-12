if (targetplayer.id != other.id)
    return;
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
if (pickedup == 0)
    instance_create(x, y, obj_genericpoofeffect)
pickedup = 1
