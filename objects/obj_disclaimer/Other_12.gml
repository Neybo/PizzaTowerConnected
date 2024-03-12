/// @description cancon 1
cancon = 1
str = lang_string("disclaimer.info");

if (!code_is_compiled())
	str += "\n\n\nNOT YYC! WARNING!";
if (!release)
	str += "\n\nTHIS IS NOT A RELEASE BUILD"
if (!os_is_network_connected())
	str += "You are offline, yes. But I don't care anymore. Proceed onwards."