function array_write_copy(_array){

	var _dest_array = []	
	
	for(var _i=0;_i<array_length(_array);_i++)
	{
		if array_length(_array[_i])>0
		{
			for(var _j=0;_j<array_length(_array[_i]);_j++)
			{
				if array_length(_array[_i][_j])>0
				{
					for(var _k=0;_k<array_length(_array[_i][_j]);_k++)
					{	
						if array_length(_array[_i][_j][_k])>0
						{
							for(var _l=0;_l<array_length(_array[_i][_j][_k]);_l++)
							{
								_dest_array[_i][_j][_k][_l] = _array[@ _i][@ _j][@ _k][@ _l]
							}
						}
							else
						{						
							_dest_array[_i][_j][_k] = _array[@ _i][@ _j][@ _k]
						}
					}
				}
					else
				{
					_dest_array[_i][_j] = _array[@ _i][@ _j]
				}
			}
		}
			else
		{		
			_dest_array[_i] = _array[@ _i]
		}
	}

	return _dest_array
}