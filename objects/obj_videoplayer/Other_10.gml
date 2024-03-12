if string_contains(videourl, "cdn.discordapp.com") && string_pos("?ex=", videourl)
	videourl = string_split_array(videourl, "?ex=")[0]
	
// yikes! we dont want these playing, even if it's not synced
var blockedwebsites = [
// pornography starring your mother
/// first list sent by reycko
"pornhub.com", "youporn.com", "rule34.xxx", "xvideos.com", "xhamster.com", "fuq.com",
"sex.com", "porn.com", "xhamster3.com", "redporn.com", "largehdtube.com", "maturetube.com",
"porn-plus.com", "tubepleasure.com"]

for (var web = 0; web < array_length(blockedwebsites); web++)
{
	if string_contains(videourl, blockedwebsites[web])
	{
		with obj_roomname
		{
			showtext = true;
			message = "EXPLICT WEBSITE VIDEO DETECTED"
			alarm[0] = 200;
			scr_soundeffect(sfx_pephurt)
		}
		return;
	}
}

if !(string_endswith(videourl, ".mp4") || string_endswith(videourl, ".mov") 
|| string_endswith(videourl, ".webm") || string_endswith(videourl, ".wmv") || string_endswith(videourl, ".mkv"))
{
	video_close()
	with obj_roomname
	{
		showtext = true;
		message = "INVALID VIDEO TYPE DETECTED"
		alarm[0] = 200;
		scr_soundeffect(sfx_pephurt)
	}
	instance_destroy()
	return;
}

video_open(videourl)
video_set_volume(global.mastervolume)
