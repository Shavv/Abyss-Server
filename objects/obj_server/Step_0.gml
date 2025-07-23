/// @description
#region Server Commands

	if keyboard_string == "" { used_command_number=array_length(used_command) }
	
	if keyboard_check_pressed(vk_down)
	{		
		if array_length(used_command) > 0
		{
			if used_command_number < array_length(used_command)-1
			{
				used_command_number++
				keyboard_string = used_command[used_command_number]	
			}
		}
	}
	
	if keyboard_check_pressed(vk_up)
	{	
		if used_command_number > 0
		{
			used_command_number--		
			keyboard_string = used_command[used_command_number]	
		}	
	}
	
	
	//command
	command = string_split(keyboard_string,",")	
	if keyboard_check_pressed(vk_enter)
	{		
		switch (command[0])
		{
			#region Create
			
				case "instance_create":
					
					switch (command[1])
					{	
						#region Create Instance
						
							case "instance":
								
								if array_length(command)>4
								{								
									try
									{
										var _x = real(command[3])
										var _y = real(command[4])
										var _object_name = command[2]
									
										if  is_real(_x)
										and is_real(_y)
										{												
											send_packet_server(PACKET.command_instance_create,
											[
												[_x,buffer_u16],
												[_y,buffer_u16],
												[_object_name,buffer_string]
											])
											
											server_log("Created Instance:'"+string(_object_name)+"' at x:'"+string(_x)+"' and y:'"+string(_y)+"'")
										}
											else
										{
											server_log("Failed to create instance because of invalid coördinates")	
										}
									}
										catch(_exception)
									{
										server_log("Failed to create instance: "+_exception.message)	
									}	
								}
									else
								{
									server_log("Failed to create instance because of invalid amount of arguments provided")
								}
							
							break;
						
						#endregion
							
						default: server_log("Create command not recognised") break;
					}			
					
				break;
			
			#endregion
			#region Stop
		
			case "stop":
				server_log("Stopping server...")		
				alarm[0]=100
			break;	
		
		#endregion
			#region No Command
		
				default: server_log($"{command} not recognised") break;
		
			#endregion
		}
	
		array_push(used_command,keyboard_string)
		used_command_number=array_length(used_command)
		keyboard_string = ""
	}
	
#endregion	














