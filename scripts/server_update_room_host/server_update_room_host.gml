function server_update_room_host(_client){

	var _client_number = -1

	//get fresh host info stored in client array	
	_client[CLIENT_ARRAY.host] = array_write_copy(_client[CLIENT_ARRAY.hostlibrary])  

	//check what this client can host
	if array_length(client_array)>0
	{					
		//then check and update
		for(var _i=0;_i<array_length(client_array);_i++)
		{
			if  client_array[_i][CLIENT_ARRAY.socket] != _client[CLIENT_ARRAY.socket]
			{
				if client_array[_i][CLIENT_ARRAY.session_id] = _client[CLIENT_ARRAY.session_id]
				{									
					for(var _f=0;_f<array_length(_client[CLIENT_ARRAY.host]);_f++)
					{												
						if array_find_value(client_array[_i][CLIENT_ARRAY.host],_client[CLIENT_ARRAY.host][_f]) !=-1
						{
							_client[CLIENT_ARRAY.host][_f] = 0
						}
					}				
				}
			}
				else
			{
				_client_number = _i	
			}
		}
	}
	
	//testing
	//show_debug_message($"host:{_client[CLIENT_ARRAY.host]}")

	//make host if all checks are done
	if _client_number != -1
	{
		client_array[@ _client_number][@ CLIENT_ARRAY.host] = _client[@ CLIENT_ARRAY.host]
		
		//show_debug_message($"library:{client_array[@ _client_number][@ CLIENT_ARRAY.hostlibrary]} | host:{client_array[@ _client_number][@ CLIENT_ARRAY.host]}")
		
		var _data = [
			[_client[CLIENT_ARRAY.host][0],buffer_u16],
			[_client[CLIENT_ARRAY.host][1],buffer_u16],
			[_client[CLIENT_ARRAY.host][2],buffer_u16],
			[_client[CLIENT_ARRAY.host][3],buffer_u16],
			[_client[CLIENT_ARRAY.host][4],buffer_u16],
			[_client[CLIENT_ARRAY.host][5],buffer_u16],
			[_client[CLIENT_ARRAY.host][6],buffer_u16],
			[_client[CLIENT_ARRAY.host][7],buffer_u16],
			[_client[CLIENT_ARRAY.host][8],buffer_u16],
			[_client[CLIENT_ARRAY.host][9],buffer_u16],
			[_client[CLIENT_ARRAY.host][10],buffer_u16],
			[_client[CLIENT_ARRAY.host][11],buffer_u16],
			[_client[CLIENT_ARRAY.host][12],buffer_u16],
			[_client[CLIENT_ARRAY.host][13],buffer_u16],
			[_client[CLIENT_ARRAY.host][14],buffer_u16],
			[_client[CLIENT_ARRAY.host][15],buffer_u16],
			[_client[CLIENT_ARRAY.host][16],buffer_u16],
			[_client[CLIENT_ARRAY.host][17],buffer_u16],
			[_client[CLIENT_ARRAY.host][18],buffer_u16],
			[_client[CLIENT_ARRAY.host][19],buffer_u16],
			[_client[CLIENT_ARRAY.host][20],buffer_u16],
			[_client[CLIENT_ARRAY.host][21],buffer_u16],
			[_client[CLIENT_ARRAY.host][22],buffer_u16],
			[_client[CLIENT_ARRAY.host][23],buffer_u16],
			[_client[CLIENT_ARRAY.host][24],buffer_u16],
			[_client[CLIENT_ARRAY.host][25],buffer_u16],
			[_client[CLIENT_ARRAY.host][26],buffer_u16]
		]
		
		send_packet_server(PACKET.room_host,_data,_client[CLIENT_ARRAY.socket])
	}
}