function array_find_value(_array,_value){

	if array_length(_value) > 0
	{
		for(var _i=0; _i < array_length(_array); _i++)
		{		
			if array_equals(_array[_i],_value)
			{
				return _i	
			}
		}		
	}
		else
	{	
		for(var _i=0; _i < array_length(_array); _i++)
		{		
			if _array[_i] == _value
			{
				return _i	
			}
		}
	}
	
	return -1
}