/// @description
var _type_event = async_load[? "type"]
var _client_id = async_load[? "socket"]

switch(_type_event)
{
	case network_type_connect:
		
		//add client to connection array
		var _client = [_client_id,0,0,false,false]		
		array_push(client_array,_client)
		
		server_log("Client["+string(_client_id)+"] connected to server")
		
		//update player list on every client
		send_packet_server(PACKET.client_set_id,[[_client_id,buffer_u8]],_client_id)
		send_packet_server(PACKET.client_list,[[array_length(client_array),buffer_u8]])
	
	break;
	case network_type_disconnect:
		
		var _session = -1
		var _room = -1
		var _socket = -1
		
		//remove client from connection array		
		for (var _i=0;_i<array_length(client_array);_i++)
		{
			if client_array[_i][CLIENT_ARRAY.socket] = _client_id
			{
				_session = client_array[_i][CLIENT_ARRAY.session_id]
				_room = client_array[_i][CLIENT_ARRAY.room_id]
				
				array_delete(client_array,_i,1)
				server_log($"Client[{_client_id}] disconnected from server")
			}
		}		
		
		//update player list on every client
		send_packet_server(PACKET.client_list,[[array_length(client_array),buffer_u8]])		
		
		//remove player objects on clients with same sesion_id and room_id
		for (var _i = 0; _i < array_length(client_array); _i++)
		{ 
			if  client_array[_i][CLIENT_ARRAY.session_id] = _session
			//and client_array[_i][CLIENT_ARRAY.room_id] = _room
			{
				_socket = client_array[_i][CLIENT_ARRAY.socket]
				server_log("Removing Client["+string(_client_id)+"] objects on Client["+string(_socket)+"]",true)
				send_packet_server(PACKET.player_destroy,[[_client_id,buffer_u8]],_socket)	
			}
			
			//update server list
			server_update_room_host(client_array[_i])	
		}	
		
	break;	
	case network_type_data:
	
		//send any sort of data
		received_packet_server(_client_id)
	
	break;
}







