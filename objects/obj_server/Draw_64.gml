/// @description
#region Connected Clients

	draw_set_color(c_white)
	draw_set_alpha(1)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	draw_set_font(font_client_box)
	
	var _width = 140
	var _height = 130
	var _x = 10
	var _y = 10
	var _hmargin = 10
	
	for(var _i=0;_i < array_length(client_array);_i++)
	{
		var _x1 = _x + ((_width)*_i)+((_hmargin)*_i)
		var _y1 = _y
		var _x2 = _x + ((_width)*(_i+1))+((_hmargin)*(_i))
		var _y2 = _y + _height
		
		draw_set_alpha(0.1)	
		draw_rectangle(_x1,_y1,_x2,_y2,0)
		draw_set_alpha(1)
		draw_rectangle(_x1,_y1,_x2,_y2,1)
		
		var _hostcount = 0
		var _librarycount = 0
		
		for(var _j=0;_j<array_length(client_array[_i][CLIENT_ARRAY.host]);_j++)
		{
			if client_array[_i][CLIENT_ARRAY.host][_j] != 0 { _hostcount++ }
		}
		
		for(var _j=0;_j<array_length(client_array[_i][CLIENT_ARRAY.hostlibrary]);_j++)
		{
			if client_array[_i][CLIENT_ARRAY.hostlibrary][_j] != 0 { _librarycount++ }
		}		
		
		draw_text(_x1+5,_y1+5,"Client: "+string(client_array[_i][CLIENT_ARRAY.socket]))
		draw_text(_x1+5,_y1+25,"Session: "+string(client_array[_i][CLIENT_ARRAY.session_id]))
		draw_text(_x1+5,_y1+45,"Room: "+string(client_array[_i][CLIENT_ARRAY.room_id]))
		draw_text(_x1+5,_y1+65,"Detected Chunks: "+string(_librarycount))		
		draw_text(_x1+5,_y1+85,"Hosted Chunks: "+string(_hostcount))
		//draw_text(_x1+5,_y1+65,"Hosts: "+string(client_array[_i][CLIENT_ARRAY.host]))		
		draw_text(_x1+5,_y1+105,"Name: Client["+string(client_array[_i][CLIENT_ARRAY.socket])+"]")

	}
	
	//draw_text(10,10,string(client_array))	

#endregion
#region Server Logs

	draw_set_alpha(1)
	draw_set_color(c_white)
	draw_set_halign(fa_left)
	draw_set_valign(fa_bottom)
	draw_set_font(font_log)

	//draw server logs
	for(var _i=0;_i<array_length(server_logs);_i++)
	{
		var _x = 10
		var _y = (window_get_height()-35) - (22 * _i)
		draw_text(_x,_y,string_hash_to_newline(server_logs[_i]))
	}
	
	//commands
	draw_set_color(c_dkgray)
	draw_rectangle(10,window_get_height()-30,window_get_width()-10,window_get_height()-10,0)
	draw_set_color(c_white)
	draw_text(10,window_get_height()-10,string(keyboard_string)+"_")

#endregion





