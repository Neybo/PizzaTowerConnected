seconds--
alarm[0] = 60
scr_soundeffect(sfx_warbeep)
if (seconds < 0)
{
    if (minutes > 0)
    {
        minutes--
        seconds = 59
    }
    else
    {
        seconds = 0
        if (room != rank_room)
        {
            alarm[1] = 60
            alarm[0] = -1
        }
    }
}
