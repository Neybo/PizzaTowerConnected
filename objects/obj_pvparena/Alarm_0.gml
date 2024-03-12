/// @description top
for (i = 0; i < gms_other_count() + 1;i++)
{
	if (i < gms_other_count())
	var _pid = gms_other_find(i)
	if ((topplayeridwithkills == 0 && gms_other_get_real(_pid, "pvp_kills") > 0)  || 
	(gms_other_get_real(_pid, "pvp_kills") > gms_other_get_real(topplayeridwithkills, "pvp_kills")))
		topplayeridwithkills = _pid

	var totaltime = gms_other_get_real(_pid, "timespent_pvp_s") + (gms_other_get_real(_pid, "timespent_pvp_m") * 60)
	
	if ((topplayeridwithtime == 0 && totaltime > 0)  || 
	(totaltime >  gms_other_get_real(topplayeridwithtime, "timespent_pvp_s") + 
	(gms_other_get_real(topplayeridwithtime, "timespent_pvp_m") * 60)))
		topplayeridwithtime = _pid
}