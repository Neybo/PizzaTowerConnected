/// @description toppin spr && border spr
event_user(0);

var bordersp = bg_space1
var rm_name = room_name

if string_contains(rm_name, "secret")
	bordersp = (string_contains(rm_name, "d2") ? spr_d2secret : bg_secret)
else if string_contains(rm_name, "tower")
	bordersp = bg_tower
	
borderspr = bordersp
onlinetxt = lang_str("online.onlinetxt")
if room != rm_load 
	drawhud = true