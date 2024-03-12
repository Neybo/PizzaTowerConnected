function scr_trylogintoken(argument0){
	switch argument0
	{
		case e_ok:
			with (obj_login)
			{
				event_user(15)
			}
		default:
			with (obj_login)
			{
				event_user(0)
				tokenlogin = false
				showtoken = true
			}
	}
}