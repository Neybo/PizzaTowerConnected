forceopen = instance_exists(obj_randomsecret) 
	&& variable_instance_exists(obj_randomsecret.id, "secretsleft") 
	&& obj_randomsecret.secretsleft == 0