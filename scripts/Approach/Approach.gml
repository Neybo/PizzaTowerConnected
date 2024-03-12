function Approach(a, b, amount, instant = false)
{
	if instant
		return b;
	if a < b
	{
		a += amount;
		if a > b
			return b;
	}
	else
	{
		a -= amount;
		if a < b
			return b;
	}
	return a;
}

