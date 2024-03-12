/// @description errormsg
gms_session_join(global.default_session);
menu = racestates.creating_or_joining
scr_soundeffect(sfx_pephurt)
with obj_roomname
{
	message = other.errormsg;
	showtext = true;
	alarm[0] = 200;
}
idtojoin = 3
maxplayer = 2
levelselect = 0