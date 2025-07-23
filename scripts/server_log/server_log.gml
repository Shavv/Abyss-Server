// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function server_log(_string,_debug = false){	
	
	//cancel debug info 
	if _debug and !SERVER_DEBUG { exit }
	
	//import text to array
	array_insert(server_logs,0,date_time_string(date_current_datetime())+": "+string(_string))
	if array_length(server_logs) > server_log_max_size { array_pop(server_logs) }
}