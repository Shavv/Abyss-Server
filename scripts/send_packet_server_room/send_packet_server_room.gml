function send_packet_server_room(_packet_id,_data,_session_id,_room_id,_except = false){
	
	var _buffer = buffer_create(32,buffer_grow,1)
	buffer_seek(_buffer,buffer_seek_start,0)
	buffer_write(_buffer,buffer_u8,_packet_id);

	//write buffers
	for (var i=0;i<array_length(_data);i++)
	{		
		buffer_write(_buffer,_data[i][1],_data[i][0])
	}

	//send buffer to all clients in same session and same room
	for (var i=0;i < array_length(client_array);i++)
	{
		if  client_array[i][CLIENT_ARRAY.session_id] = _session_id
		{
			if client_array[i][CLIENT_ARRAY.room_id] = _room_id
			{				
				if _except=false
				{
					network_send_packet(client_array[i][CLIENT_ARRAY.socket],_buffer,buffer_tell(_buffer))
				}
					else
				{
					if client_array[i][CLIENT_ARRAY.socket]!=_except
					{
						network_send_packet(client_array[i][CLIENT_ARRAY.socket],_buffer,buffer_tell(_buffer))
					}
				}
			}
		}
	}

	buffer_delete(_buffer)
}