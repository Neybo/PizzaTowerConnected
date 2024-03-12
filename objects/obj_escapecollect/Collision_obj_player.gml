if room == rm_editor exit;
if other.state == states.gameover exit;

if audio_is_playing(sfx_collecttopping)
audio_stop_sound(sfx_collecttopping)

scr_soundeffect(sfx_collecttopping)


if obj_player.character = "V" 
global.playerhealth = clamp(global.playerhealth+1, 0, 100)

global.collect +=  10

with instance_create(x+16,y,obj_smallnumber)
number = string(10)

instance_destroy()