if (room == rm_editor)
{
}
if (other.state != (157 << 0))
{
    if audio_is_playing(sfx_collecttopping)
        audio_stop_sound(sfx_collecttopping)
    scr_soundeffect(sfx_collecttopping)
    if (.character == "V")
        global.playerhealth = clamp((global.playerhealth + 1), 0, 100)
    global.heattime += 10
    global.heattime = clamp(global.heattime, 0, 60)
    with (obj_camera)
        healthshaketime = 30
    if (other.object_index == )
        global.collect += 10
    else
        global.collectN += 10
    create_collect(x, y, sprite_index)
    with (instance_create((x + 16), y, obj_smallnumber))
        number = string(10)
    instance_destroy()
}
