module dart.mirrors;

import dart.api;

extern(C){
	pragma(mangle, "Dart_TypeName")
	Handle typeName(Handle type);
	
	pragma(mangle, "Dart_QualifiedTypeName")
	Handle qualifiedTypeName(Handle type);

	pragma(mangle, "Dart_GetFunctionNames")
	Handle getFunctionNames(Handle target);

	pragma(mangle, "Dart_LookupFunction")
	Handle lookupFunction(Handle target, Handle function_name);

	pragma(mangle, "Dart_FunctionName")
	Handle functionName(Handle function_);

	pragma(mangle, "Dart_FunctionOwner")
	Handle functionOwner(Handle function_);
	
	pragma(mangle, "Dart_FunctionIsStatic")
	Handle functionIsStatic(Handle function_, bool* is_static);
	
	pragma(mangle, "Dart_FunctionIsConstructor")
	Handle functionIsConstructor(Handle function_, bool* is_constructor);
	
	pragma(mangle, "Dart_FunctionIsGetter")
	Handle functionIsGetter(Handle function_, bool* is_getter);
	
	pragma(mangle, "Dart_FunctionIsSetter")
	Handle functionIsSetter(Handle function_, bool is_setter);
	
	pragma(mangle, "Dart_LibraryNames")
	Handle libraryName(Handle library);

	pragma(mangle, "Dart_LibraryGetClassNames")
	Handle libraryGetClassName(Handle library);
	
	pragma(mangle, "Dart_ClosureFunction")
	Handle closureFunction(Handle closure);
	
}