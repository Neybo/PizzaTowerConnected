if !instance_exists(playerid)
	exit

if playerid.state == states.taxi || playerid.state == states.policecartaxi
{
	with playerid
	{
		instance_create(x, y, obj_genericpoofeffect)
		scr_soundeffect(sfx_taxi1)
		state = states.normal
		cutscene = false
		visible = true
		if (room == hub_pvp)
		{
			x = 900
			y = 400
		}
	}
}
