#macro PORT 7676
#macro MAX_CLIENTS 12
#macro SERVER_DEBUG true

enum CLIENT_ARRAY{
	socket,
	session_id,
	room_id,
	host,
	hostlibrary
}

enum PACKET{
	
	connect,
	ping,
	
	client_set_id,
	client_list,
	
	room_join,
	room_join_sandbox,
	room_leave,
	room_host,
	
	player_movement,
	player_animation,
	player_destroy,
	
	npc_movement,
	npc_animation,
	npc_destroy,
	
	unit_create,
	unit_sync,
	
	start_command,
	
		command_instance_create,
		
	end_command,
	
	disconnect	
}