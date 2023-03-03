//Thread safe FIFO array buffer manager
//It can be instanciated simply like below
//	fifo				:FB_FIFOQueue := (S_bufferSize:=SIZEOF(fifoQueue) / SIZEOF(fifoQueue[1]));
//	fifoQueue			:ARRAY[0..10] OF DWORD;
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 15-02-22 | Creation
FUNCTION_BLOCK FB_FIFOArray
VAR_INPUT
	S_startIndex	:DWORD;					//Index of first element in array, only positive indexes are supported
	S_bufferSize	:DWORD;					//Maximum amount of elements in buffer array
END_VAR
VAR
	S_amount		:DWORD;					//How many elements are in the queue
	S_input			:DWORD := 4294967295;	//Last input/push index
	S_output		:DWORD := 4294967295;	//Last output/unshift index 
	S_block			:DWORD;					//Block for threadsafeness
	S_blockInput	:DWORD;					//Block for threadsafeness
	S_blockOutput	:DWORD;					//Block for threadsafeness
END_VAR
(*%!%__DELIMITER__%!%*)
