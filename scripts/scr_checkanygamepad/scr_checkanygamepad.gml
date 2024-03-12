function scr_checkanygamepad(cont = global.cont)
{
	if cont > -1
	{
		for (var i = gp_face1; i < gp_axisrv; i++)
		{
			if gamepad_button_check(cont, i)
				return i;
		}
	}
	return false;
}

