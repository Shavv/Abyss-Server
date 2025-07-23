function received_packet_server(_client_socket){
	
	//ID of the network package
	var _client_buffer = async_load[? "buffer"]
	buffer_seek(_client_buffer,buffer_seek_start,0)		
	var _packet_id = buffer_read(_client_buffer,buffer_u8)
	
	switch(_packet_id)
	{
		#region Ping
			
			case PACKET.ping:
		
				//receive time and send it back straight away
				var _client = buffer_read(_client_buffer,buffer_u8)
				var _current_time = buffer_read(_client_buffer,buffer_u32)
				send_packet_server(PACKET.ping,[[_current_time,buffer_u32]],_client)
		
			break;
		
		#endregion
		#region Room Info
		
			case PACKET.room_join:									
			
				//add to array
				var _client;
				
				_client[CLIENT_ARRAY.socket]		= buffer_read(_client_buffer,buffer_u8)
				_client[CLIENT_ARRAY.session_id]	= buffer_read(_client_buffer,buffer_u8)
				_client[CLIENT_ARRAY.room_id]		= buffer_read(_client_buffer,buffer_u16)
				_client[CLIENT_ARRAY.host]			= false
				
				var _existing = false					
				
				//failsafe update if already exists on server
				if array_length(client_array)>0
				{				
					for(var _i=0;_i<array_length(client_array);_i++)
					{
						if client_array[_i][CLIENT_ARRAY.socket] = _client[CLIENT_ARRAY.socket]
						{							
							client_array[_i][CLIENT_ARRAY.session_id] = _client[CLIENT_ARRAY.session_id]
							client_array[_i][CLIENT_ARRAY.room_id] = _client[CLIENT_ARRAY.room_id]	
							client_array[_i][CLIENT_ARRAY.host] = false
							_existing = true
						}
					}
				}				
				
				//client doesnt exist on server				
				if _existing = false { array_push(client_array,_client) }

				//check and update host
				server_update_room_host(_client)
				
				//server log
				server_log($"Client[{_client[CLIENT_ARRAY.socket]}] joined room <{_client[CLIENT_ARRAY.room_id]}>",true)
			
			break;	

			case PACKET.room_join_sandbox:									
			
				//add to array
				var _client;
				
				_client[CLIENT_ARRAY.socket]		= buffer_read(_client_buffer,buffer_u8)
				_client[CLIENT_ARRAY.session_id]	= buffer_read(_client_buffer,buffer_u8)
				_client[CLIENT_ARRAY.room_id]		= buffer_read(_client_buffer,buffer_u16)
				_client[CLIENT_ARRAY.host]			= []
				
				//add rooms to potential host check
				array_push(_client[CLIENT_ARRAY.host],_client[CLIENT_ARRAY.room_id])
				repeat(26) { array_push(_client[CLIENT_ARRAY.host],buffer_read(_client_buffer,buffer_u16)) }
									
				//update host library
				_client[@ CLIENT_ARRAY.hostlibrary] = _client[@ CLIENT_ARRAY.host]
									
				//failsafe update if already exists on server
				var _existing = false
				
				if array_length(client_array)>0
				{				
					for(var _i=0;_i<array_length(client_array);_i++)
					{
						if client_array[_i][CLIENT_ARRAY.socket] = _client[CLIENT_ARRAY.socket]
						{							
							client_array[@ _i] = _client
							_existing = true
						}
					}
				}				
				
				//client doesnt exist on server				
				if _existing = false
				{
					array_push(client_array,_client)
				}				
				
				//update room client new room host
				//server_update_room_host(_client)
				
				//update room host for all other in same session
				for(var _i=0;_i<array_length(client_array);_i++)
				{			
					if client_array[_i][CLIENT_ARRAY.session_id] = _client[CLIENT_ARRAY.session_id]
					{
						server_update_room_host(client_array[_i])
					}
				}				
				
				//server log
				server_log($"Client[{_client[CLIENT_ARRAY.socket]}] joined room <{_client[CLIENT_ARRAY.room_id]}>",true)
			
			break;
			
			case PACKET.room_leave:									
			
				//add to array
				var _client;
				
				_client[CLIENT_ARRAY.socket]		= buffer_read(_client_buffer,buffer_u8)
				_client[CLIENT_ARRAY.session_id]	= buffer_read(_client_buffer,buffer_u8)
				//_client[CLIENT_ARRAY.room_id]		= buffer_read(_client_buffer,buffer_u16)
				
				if array_length(client_array)>0
				{
					//delete client from room
					for(var _i=0;_i<array_length(client_array);_i++)
					{
						if client_array[_i][CLIENT_ARRAY.socket] = _client[CLIENT_ARRAY.socket]
						{	
							//array_delete(client_array,_i,1)
						}
					}				
				}									
			
				//server_log("Client["+string(_client[CLIENT_ARRAY.socket])+"] left room <"+string(_client[CLIENT_ARRAY.room_id])+">",true)
			
			break;
			
		#endregion
		#region Player Sync
		
			case PACKET.player_movement:
			
				var _client;
				_client[CLIENT_ARRAY.socket]		= buffer_read(_client_buffer,buffer_u8)
				_client[CLIENT_ARRAY.session_id]	= buffer_read(_client_buffer,buffer_u8)
				_client[CLIENT_ARRAY.room_id]		= buffer_read(_client_buffer,buffer_u16)
				
				var _x = buffer_read(_client_buffer,buffer_f16)
				var _y = buffer_read(_client_buffer,buffer_f16)
				var _z = buffer_read(_client_buffer,buffer_f16)
				var _zfloor = buffer_read(_client_buffer,buffer_f16)
				var _ramp_zfloor = buffer_read(_client_buffer,buffer_f16)
				var _xdir = buffer_read(_client_buffer,buffer_bool)
				
				send_packet_server_session(PACKET.player_movement,
				[				
					[_client[CLIENT_ARRAY.socket],buffer_u8],
					
					[_client[CLIENT_ARRAY.room_id],buffer_u16],
					[_x,buffer_f16],
					[_y,buffer_f16],
					[_z,buffer_f16],
					[_zfloor,buffer_f16],
					
					[_ramp_zfloor,buffer_f16],
					[_xdir,buffer_bool],
				],
					
				_client[CLIENT_ARRAY.session_id],_client[CLIENT_ARRAY.socket])
			
			break;
			case PACKET.player_animation:
			
				var _client;
				_client[CLIENT_ARRAY.socket]		= buffer_read(_client_buffer,buffer_u8)
				_client[CLIENT_ARRAY.session_id]	= buffer_read(_client_buffer,buffer_u8)
				_client[CLIENT_ARRAY.room_id]		= buffer_read(_client_buffer,buffer_u16)
				
				var _animation   = buffer_read(_client_buffer,buffer_string)
				var _framespeed  = buffer_read(_client_buffer,buffer_u16)
				var _stop_at_end = buffer_read(_client_buffer,buffer_bool)
				
				send_packet_server_session(PACKET.player_animation,
				[
				
					[_client[CLIENT_ARRAY.socket],buffer_u8],
					
					[_animation,buffer_string],
					[_framespeed,buffer_u16],
					[_stop_at_end,buffer_bool],
				],
					
				_client[CLIENT_ARRAY.session_id],_client[CLIENT_ARRAY.socket])
				//server_log("Client["+string(_client[CLIENT_ARRAY.socket])+"] switched to animation: '"+string(_animation)+"' at <"+string(_framespeed)+"> framespeed",true)
			
			break;			
		
		#endregion
		#region NPC sync
		
			case PACKET.npc_movement:
			
					var _client;
					_client[CLIENT_ARRAY.socket]		= buffer_read(_client_buffer,buffer_u8)
					_client[CLIENT_ARRAY.session_id]	= buffer_read(_client_buffer,buffer_u8)
					_client[CLIENT_ARRAY.room_id]		= buffer_read(_client_buffer,buffer_u16)		
					
					var _sandbox_id = buffer_read(_client_buffer,buffer_u16)
					var _x = buffer_read(_client_buffer,buffer_f16)
					var _y = buffer_read(_client_buffer,buffer_f16)
					var _z = buffer_read(_client_buffer,buffer_f16)
					var _zfloor = buffer_read(_client_buffer,buffer_f16)
					var _ramp_zfloor = buffer_read(_client_buffer,buffer_f16)
					var _xdir = buffer_read(_client_buffer,buffer_bool)	
					
					send_packet_server_session(PACKET.npc_movement,
					[										
						[_client[CLIENT_ARRAY.room_id],buffer_u16],
						[_sandbox_id,buffer_u16],
						[_x,buffer_f16],
						[_y,buffer_f16],
						[_z,buffer_f16],
						[_zfloor,buffer_f16],
						
						[_ramp_zfloor,buffer_f16],
						[_xdir,buffer_bool],
					],
						
					_client[CLIENT_ARRAY.session_id],_client[CLIENT_ARRAY.socket])		
				
			break;
		
		#endregion		
	}
}