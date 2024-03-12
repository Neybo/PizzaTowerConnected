if room != rm_disclaimer
{
	instance_destroy();
	exit;
}

if keyboard_check(ord("L"))
&& keyboard_check(ord("S"))
&& keyboard_check(ord("D"))
&& keyboard_check(ord("E"))
{
	global.lsdtrip = true
}
else
	global.lsdtrip = false

global.music = FMOD_EMPTY;

con = -1;
size = 0;
cancon = false;

version = 10;

// crack my own drm
drm = true;
str = lang_str("disclaimer.info") + lang_string("disclaimer.loading");

global.pastdisclaimer = true;
global.logged = false;
global.jukebox = -1;
global.modifier = -1;
global.panic = false;
global.snickchallenge = false;
global.snickrematch = false;

if (!code_is_compiled())
	str += "\n\n\nNOT YYC! WARNING!";
if (!release)
	str += "\n\nTHIS IS NOT A RELEASE BUILD"
if (!os_is_network_connected())
	str += "You are offline."
req = -1;
net = true; // is connected to the internet
t = 0; // animation timer
showwait = false;
cancon = false;

// if you have seen the disclaimer already, skip it
/*
ini_open("saveData.ini");
if ini_read_real("online", "disclaimer", false)
{
	event_user(0);
	ini_close();
	exit;
}
else
*/
	event_user(1); // show disclaimer
//ini_close();
req2 = -1
/*
drm = true;
if !patron
	drm = false;

str = lang_string("disclaimer.offline");

req = -1;
net = os_is_network_connected();
if net == true
	req = http_get(base64_decode("aHR0cDovL3B0b2xldmVsZWRpdG9yLjAwMHdlYmhvc3RhcHAuY29tL2Rpc2NsYWltZXI="));
else
	event_user(1);

t = 0;

alarm[1] = room_speed * 5;
showwait = false;
*/
