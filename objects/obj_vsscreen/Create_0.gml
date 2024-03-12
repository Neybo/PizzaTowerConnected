alarm[0] = 300
image_speed = 0.1
depth = -9999
pepx =  -415
noisex = room_width 
vsy = -400
shake = 0
instance_deactivate_all(true)
instance_activate_object(obj_wc)
instance_activate_object(obj_otherplayer)
instance_activate_object(obj_gms)
instance_activate_object(obj_player)
with obj_player
	state = -1
flash = false
flashed = false
flamey = 0

