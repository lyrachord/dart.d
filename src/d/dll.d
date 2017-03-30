import dart;

import core.sys.windows.windows;
import core.sys.windows.dll;


mixin SimpleDllMain;

export 
Handle sample_extension_Init(Handle parentLibrary){
	if(parentLibrary.isError) return parentLibrary;
	return nullHandle;
}