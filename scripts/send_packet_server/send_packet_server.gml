function send_packet_server(_packet_id,_data,_specific_client = false){
	
	var _buffer = buffer_create(32,buffer_grow,1)
	buffer_seek(_buffer,buffer_seek_start,0)
	buffer_write(_buffer,buffer_u8,_packet_id);

	//write buffers
	for (var i=0;i<array_length(_data);i++)
	{		
		buffer_write(_buffer,_data[i][1],_data[i][0])
	}

	if !_specific_client
	{
		//send buffer to all clients
		for (var i=0;i < array_length(client_array);i++)
		{
			network_send_packet(client_array[i][CLIENT_ARRAY.socket],_buffer,buffer_tell(_buffer))
		}
	}
		else
	{
		//send to specific client
		network_send_packet(_specific_client,_buffer,buffer_tell(_buffer))
	}

	buffer_delete(_buffer)
}