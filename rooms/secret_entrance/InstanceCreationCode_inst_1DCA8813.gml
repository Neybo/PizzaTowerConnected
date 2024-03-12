msg = "There may be positioning issues"
if instance_exists(obj_randomsecret) 
	&& variable_instance_exists(obj_randomsecret.id, "secretsleft") 
	&& obj_randomsecret.secretsleft == 0
	instance_destroy()