if timer > 0
    timer--
else
{
    timer = timer_max
    if comboscore > 0
    {
        if combominus <= 1
            combominus = 1
        comboscore -= round(combominus)
        if comboscore < 0
            comboscore = 0
        create_collect(obj_player.x, obj_player.y - 100, scr_collectsprite())
    }
    else if alarm[1] == -1
        alarm[1] = 50
}

title_index += 0.35
if title_index >= 2
    title_index = frac(title_index)
if room == rank_room or room == timesuproom
    instance_destroy()
