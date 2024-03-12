surf = -4
if global.racing
	instance_destroy()
image_speed = 0.35
targetRoom = room
targetDoor = "LAP"
targetTime = 0.0
timetoadd = global.lapextratime
if (global.lap >= 5)
	timetoadd *= 1.2
if (global.lap >= 99)
	timetoadd = 0
if FINAL_GAMEPLAY && global.fill <= 0
	timetoadd = 0
	