/// @description reload keys
inputkeys = []
extrakeys = false
array_push(inputkeys, {x : 0, y : 0, key : "Z", keyw : 1, keyh : 1});
array_push(inputkeys, {x : 1, y : 0, key : "UP", keyw : 1, keyh : 1});
array_push(inputkeys, {x : 2, y : 0, key : "X", keyw : 1, keyh : 1});
array_push(inputkeys, {x : 0, y : 1, key : "LEFT", keyw : 1, keyh : 1});
array_push(inputkeys, {x : 1, y : 1, key : "DOWN", keyw : 1, keyh : 1});
array_push(inputkeys, {x : 2, y : 1, key : "RIGHT", keyw : 1, keyh : 1});
array_push(inputkeys, {x : 0, y : 2, key : "SHIFT", keyw : 2, keyh : 1});
if global.usebullet || global.breakdance
{
	extrakeys = true
	array_push(inputkeys, {x : 0, y : -1, key : "A", keyw : 1, keyh : 1});
}
if global.useammo
{
	extrakeys = true
	array_push(inputkeys, {x : 1, y : -1, key : "S", keyw : 1, keyh : 1});
}
if global.attackstyle != attacks.grab
{
	extrakeys = true
	array_push(inputkeys, {x : 2, y : -1, key : "V", keyw : 1, keyh : 1});
}
array_push(inputkeys, {x : 2, y : 2, key : "C", keyw : 1, keyh : 1});
lengtharray = array_length(inputkeys)
