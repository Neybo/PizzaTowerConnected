if global.panic
	return;
global.panic = true;
global.minutes = 1;
global.seconds = 30;

global.wave = 0;
global.maxwave = (global.minutes * 60 + global.seconds) * 60;

with obj_camera
	alarm[1] = 60;

// eggplant timer
global.fill = ((global.minutes * 60 + global.seconds) * 60) * obj_chunktimer.fillrate;
with obj_tv
	chunkmax = global.fill