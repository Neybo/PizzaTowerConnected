depth = 10000
instance_deactivate_all(true)
instance_activate_object(obj_gms)
instance_activate_object(obj_music)
instance_activate_object(obj_chatexister)
global.panic = false
with obj_music
	fadeoff = 0
application_surface_draw_enable(true)

lastplayerracing = gms_session_player_count(gms_session_current_id())

// false data for testing
/*
global.raceleader = ds_list_create()
global.racetime = ds_list_create()


ds_list_add(global.raceleader, "raf13")
ds_list_add(global.raceleader, "joe")
ds_list_add(global.raceleader, "obama")
ds_list_add(global.raceleader, "kstr")
ds_list_add(global.raceleader, "bruj")
ds_list_add(global.raceleader, "bruj2")
ds_list_add(global.raceleader, "bruj3")
ds_list_add(global.raceleader, "bruj4")

ds_list_add(global.raceleader, "wario")
ds_list_add(global.raceleader, "dead person")
ds_list_add(global.raceleader, "wario2")
ds_list_add(global.raceleader, "dead person2")

ds_list_add(global.racetime, "0:00")
ds_list_add(global.racetime, "0:01")
ds_list_add(global.racetime, "0:02")
ds_list_add(global.racetime, "0:06")
ds_list_add(global.racetime, "0:10")
ds_list_add(global.racetime, "0:11")
ds_list_add(global.racetime, "0:12")
ds_list_add(global.racetime, "0:13")

ds_list_add(global.racetime, "N/A")
ds_list_add(global.racetime, "N/A")
ds_list_add(global.racetime, "N/A")
ds_list_add(global.racetime, "N/A")
*/
