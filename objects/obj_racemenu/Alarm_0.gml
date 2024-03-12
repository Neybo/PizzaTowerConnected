/// @description reset
fmod_stop_all();
scr_playerreset();
keyboard_clear(vk_escape)
instance_destroy()
obj_player.state = states.normal;
global.__script_session = -1
gms_session_join(global.default_session);