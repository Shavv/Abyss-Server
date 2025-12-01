/// @description
server_socket = network_create_server(network_socket_tcp,PORT,MAX_CLIENTS)
server_logs = [""]
server_log_max_size = 27
client_array = []
command = ""
used_command = []
used_command_number = -1

room_list = [[]]

//Failed server creation 
if (server_socket < 0)
{
	server_log("Failed to create new Server. A server already exists on the same port")
}
	else
{
	server_log("Server Created Succesfully!")
}



