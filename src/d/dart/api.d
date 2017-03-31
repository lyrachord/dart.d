module dart.api;

import std.stdint;
/*
typedef unsigned __int8 bool;
typedef signed __int8 int8_t;
typedef signed __int16 int16_t;
typedef signed __int32 int32_t;
typedef signed __int64 int64_t;
typedef unsigned __int8 uint8_t;
typedef unsigned __int16 uint16_t;
typedef unsigned __int32 uint32_t;
typedef unsigned __int64 uint64_t;
*/

struct _Dart_Isolate;
struct _Dart_Handle;
struct _Dart_WeakPersistentHandle;
struct _Dart_NativeArguments;

alias Isolate = _Dart_Isolate*;
alias Handle = _Dart_Handle*;
alias PersistentHandle = _Dart_Handle*;
alias WeakPersistentHandle = _Dart_WeakPersistentHandle*;
alias NativeArguments = _Dart_NativeArguments*;

alias Port = long; //Dart_Port

enum Flag{
	CURRENT_VERSION=1,  //DART_FLAGS_CURRENT_VERSION
	INITIALIZE_PARAMS_CURRENT_VERSION=2, //DART_
}
enum long ILLEGAL_PORT = 0;

//line 2026 Dart_TypedData_Type
//FIXME change DartType
enum DartType {  
	ByteData,
	Int8,
	Uint8,
	Uint8Clamped,
	Int16,
	Uint16,
	Int32,
	Uint32,
	Int64,
	Uint64,
	Float32,
	Float64,
	Float32x4,
	Invalid,
}

//line 2415, Dart_NativeArgument_Type
enum ArgumentType{
	Bool,
	Int32,
	Uint32,
	Int64,
	Uint64,
	Double,
	String,
	Instance,
	NativeFields,
}

enum NativeArg{
	NumberPos =0,
	NumberSize = 8,
	TypePos = NumberPos+NumberSize,
	TypeSize = 8
}
//line 2719
enum LibraryTag{
	CanonicalizeUrl,
	Script,
	Source,
	Import,
}
enum {
	KERNEL_ISOLATE_NAME="kernel-service",
	VM_SERVICE_ISOLATE_NAME="vm-service"
}
struct IsolateFlags{
	int version_;
	bool enable_type_checks;
	bool enable_asserts;
	bool enable_error_on_bad_type;
	bool enable_error_on_bad_override;
}

//line 2427, Dart_NativeArgument_Descriptor
struct NativeArgumentDescriptor{
	ubyte type;
	ubyte index;
}

//line 2432 Dart_NativeArgument_Value
union NativeArgumentValue{
	bool as_bool;
	int as_int32;
	uint as_uint32;
	long as_int64;
	ulong as_uint64;
	double as_double;
	private struct _string_type{
		Handle dart_str;
		void* peer;
	} 
	_string_type as_string;
	
	private struct _fields_type{
		intptr_t num_fields;
		intptr_t* values;
	}
	_fields_type as_native_fields;
	
	Handle as_instance;
}

//line 3188 Dart_QualifiedFunctionName
struct QualifiedFunctionName{
	const char* library_uri;
	const char* class_name;
	const char* function_name;
}
/*
mixin template dart(name){
	pragma(mangle, "Dart_"~name)
	//ERROR, here MUST follow declaration
}
*/


//line 2457
pragma(inline, true)
T bitmask(T)(T size){
	return (1<<size)-1;
}
/**
#define BITMASK(size) ((1 << size) - 1)
#define DART_NATIVE_ARG_DESCRIPTOR(type, position)                             \
  (((type & BITMASK(kNativeArgTypeSize)) << kNativeArgTypePos) |               \
   (position & BITMASK(kNativeArgNumberSize)))
**/

extern(C){

	alias WeakPersistentHandleFinalizer = void function(void* isolate_callback_data, WeakPersistentHandle handle, void* peer);
	
	alias PeerFinalizer = void function(void* peer) ;
	/**
	* Is this an error Handler?
	* Requires there to be a current isolate.
	*/
	pragma(mangle, "Dart_IsError")
	bool isError(Handle handle);
	
	pragma(mangle, "Dart_IsApiError")
	bool isApiError(Handle handle);

	pragma(mangle, "Dart_IsUnhandledExceptionError")
	bool isUnhandledExceptionError(Handle handle);

	pragma(mangle, "Dart_IsCompilationError")
	bool isCompilationError(Handle handle);

	pragma(mangle, "Dart_IsCompilationError")
	bool isCompilationError(Handle handle);
	
	pragma(mangle, "Dart_IsFatalError")
	bool isFatalError(Handle handle);
	
	pragma(mangle, "Dart_IsVMRestartRequest")
	bool isVMRestartRequest(Handle handle);

	pragma(mangle, "Dart_GetError")
	const(char)* getError(Handle handle);
	
	pragma(mangle, "Dart_ErrorHasException")
	bool errorHasException(Handle handle);
	
	pragma(mangle, "Dart_ErrorGetException")
	Handle errorGetException(Handle handle);
	
	pragma(mangle, "Dart_ErrorGetStackTrace")
	Handle errorGetStackTrace(Handle handle);
	
	pragma(mangle, "Dart_NewApiError")
	Handle newApiError(const char* error);
	
	pragma(mangle, "Dart_NewUnhandledExceptionError")
	Handle newUnhandledExceptionError(Handle handle);

	//mixin dart!("PropagateError");
	pragma(mangle, "Dart_PropagateError")
	Handle propagateError(Handle handle);

	void _Dart_ReportErrorHandle(const char* file, int line, const char* handle_string, const char* error);
	
/*	mixin DART_CHECK_VALID(handle){
		if(handle.isError)
		_Dart_ReportErrorHandle(__FILE__, __LINE__, handle, handle.getError);
	}
*/
	pragma(mangle, "Dart_ToString")
	Handle toString(Handle object);
	
	pragma(mangle, "Dart_IdentityEquals")
	bool identityEquals(Handle obj1, Handle obj2);
	
	pragma(mangle, "Dart_IdentityHash")
	ulong identityHash(Handle object);
	
	pragma(mangle, "Dart_HandleFromPersistent")
	Handle handleFromPersistent(PersistentHandle object);
	
	pragma(mangle, "Dart_HandleFromWeakPersistent")
	Handle handleFromWeakPersistent(WeakPersistentHandle handle);
	
	pragma(mangle, "Dart_NewPersistentHandle")
	PersistentHandle newPersistentHandle(Handle object);
	
	pragma(mangle, "Dart_SetPersistentHandle")
	void setPersistentHandle(PersistentHandle object1, Handle object2);
	
	pragma(mangle, "Dart_DeletePersistentHandle")
	void deletePersistentHandle(PersistentHandle object);
	
	pragma(mangle, "Dart_NewWeakPersistentHandle")
	WeakPersistentHandle newWeakPersistentHandle(Handle object, void* peer, intptr_t external_allocation_size, WeakPersistentHandleFinalizer callback);
	
	pragma(mangle, "Dart_DeleteWeakPersistentHandle")
	void deleteWeakPersistentHandle(Isolate isolate, WeakPersistentHandle object);
	
	alias GcPrologueCallback = void function();
	alias GcEpilogueCallback = void function();
	
	pragma(mangle, "Dart_SetGcCallbacks")
	Handle setGcCallbacks(GcPrologueCallback prologueCallback, GcEpilogueCallback epilogueCallback);
	
	pragma(mangle, "Dart_VersionString")
	const(char)* versionString();
	
	alias Isolate function(const char* script_uri, const char* main, const char* package_root, const char* package_config, IsolateFlags* flags, void* callback_data, char** error) IsolateCreateCallback;
	
	alias void function(Handle error) IsolateUnhandledExceptionCallback;
	
	alias void function(void* callback_data) IsolateShutdownCallback;
	
	alias void function() ThreadExitCallback;
	
	alias void* function(const char* name, bool write) FileOpenCallback;
	
	alias void function(const ubyte** data, intptr_t* file_length, void* stream) FileReadCallback;
	
	alias void function(const void* data, intptr_t length, void* stream) FileWriteCallback;
	
	alias void function(void* stream) FileCloseCallback;
	
	alias bool function(ubyte* buffer, intptr_t length) EntropySource;
	
	alias Handle function() GetVMServiceAssetsArchive;
	
	struct InitializeParams{
		int version_;
		const ubyte* vm_snapshot_data;
		const ubyte* vm_snapshot_instructions;
		IsolateCreateCallback create;
		IsolateShutdownCallback shutdown;
		ThreadExitCallback thread_exit;
		FileOpenCallback file_open;
		FileReadCallback file_read;
		FileWriteCallback file_write;
		FileCloseCallback file_close;
		EntropySource entropy_source;
		GetVMServiceAssetsArchive get_service_assets;
	}
	
	pragma(mangle, "Dart_Initialize")
	char* initialize(InitializeParams params);
	
	pragma(mangle, "Dart_Cleanup")
	char* cleanUp();
	
	pragma(mangle, "Dart_SetVMFlags")
	bool setVMFlags(int argc, const char** argv);
	
	pragma(mangle, "Dart_IsVMFlagSet")
	bool isVMFlagSet(const char* flag_name);
	
	pragma(mangle, "Dart_CreateIsolate")
	Isolate createIsolate(
		const char* script_uri,
		const char* main,
		const ubyte* isolate_snapshot_data,
		const ubyte* isolate_snapshot_instructions,
		IsolateFlags* flags,
		void* callback_data,
		char** error
		);
	
	pragma(mangle, "Dart_CreateIsolateFromKernel")
	Isolate createIsolateFromKernel(
		const char* script_uri,
		const char* main,
		void* kernel_program,
		IsolateFlags* flags,
		void* callback_data,
		char** error
		);
	
	pragma(mangle, "Dart_ShutdownIsolate")
	void shutdownIsolate();
	
	pragma(mangle, "Dart_CurrentIsolate")
	Isolate currentIsolate();
	
	pragma(mangle, "Dart_CurrentIsolateData")
	void* currentIsolateData();
	
	pragma(mangle, "Dart_IsolateData")
	void* currentIsolate(Isolate isolate);
	
	pragma(mangle, "Dart_DebugName")
	Handle debugName();
	
	pragma(mangle, "Dart_EnterIsolate")
	void enterIsolate(Isolate isolate);
	
	pragma(mangle, "Dart_ThreadDisableProfiling")
	void threadDisableProfiling();
	
	pragma(mangle, "Dart_ThreadEnableProfiling")
	void threadEnableProfiling();

	pragma(mangle, "Dart_ExitIsolate")
	void exitIsolate();
	
	pragma(mangle, "Dart_CreateSnapshot")
	Handle createSnapshot(
		ubyte** vm_snapshot_data_buffer,
		intptr_t* vm_snapshot_data_size,
		ubyte** isolate_snapshot_data_buffer,
		intptr_t* isolate_snapshot_data_size
	);
	
	pragma(mangle, "Dart_createScriptSnapshot")
	Handle createScriptSnapshot(
		ubyte** script_snapshot_buffer,
		intptr_t* script_snapshot_size
	);
	
	pragma(mangle, "Dart_InterruptIsolate")
	void interruptIsolate(Isolate isolate);
	
	pragma(mangle, "Dart_IsolateMakeRunnable")
	bool isolateMakeRunnable(Isolate isolate);
	
	alias void function(Isolate dest_isolate) MessageNotifyCallback;
	
	pragma(mangle, "Dart_SetMessageNotifyCallback")
	void setMessageNotifyCallback(MessageNotifyCallback message_notify_callback);
	
	pragma(mangle, "Dart_GetMessageNotifyCallback")
	MessageNotifyCallback getMessageNotifyCallback();
	
	pragma(mangle, "Dart_ShouldPauseOnStart")
	bool shouldPauseOnStart();
	
	pragma(mangle, "Dart_SetShouldPauseOnStart")
	void setShouldPauseOnStart(bool should_pause);

	pragma(mangle, "Dart_IsPausedOnStart")
	bool IsPausedOnStart();

	pragma(mangle, "Dart_SetPausedOnStart")
	void setPausedOnStart(bool paused);

	pragma(mangle, "Dart_ShouldPauseOnExit")
	bool shouldPauseOnExit();
	
	pragma(mangle, "Dart_SetShouldPauseOnExit")
	void setShouldPauseOnExit(bool should_pause);

	pragma(mangle, "Dart_IsPausedOnExit")
	bool IsPausedOnExit();

	pragma(mangle, "Dart_SetPausedOnExit")
	void setPausedOnExit(bool paused);
	
	pragma(mangle, "Dart_SetStickyError")
	void setStickyError(Handle error);
	
	pragma(mangle, "Dart_SetStickyError")
	bool hasStickyError();
	
	pragma(mangle, "Dart_GetStickyError")
	Handle getStickyError();
	
	pragma(mangle, "Dart_HandleMessage")
	Handle handleMessage();
	
	pragma(mangle, "Dart_HandleMessages")
	Handle handleMessages();
	
	pragma(mangle, "Dart_HandleServiceMessages")
	bool handleServiceMessages();
	
	pragma(mangle, "Dart_HasServiceMessages")
	bool hasServiceMessages();
	
	pragma(mangle, "Dart_RunLoop")
	Handle runLoop();
	
	pragma(mangle, "Dart_GetMainPortId")
	Port getMainPortId();
	
	pragma(mangle, "Dart_HasLivePorts")
	bool hasLivePorts();
	
	pragma(mangle, "Dart_Post")
	bool post(Port port_id, Handle object);
	
	pragma(mangle, "Dart_NewSendPort")
	Handle newSendPort(Port port_id);
	
	pragma(mangle, "Dart_SendPortGetId")
	Handle sendPortGetId(Handle port, Port* port_id);
	
	pragma(mangle, "Dart_EnterScope")
	void enterScope();
	
	pragma(mangle, "Dart_ExitScope")
	void exitScope();
	
	pragma(mangle, "Dart_ScopeAllocate")
	ubyte* scopeAllocate(intptr_t size);

	//XXX: consider another name?
	pragma(mangle, "Dart_Null")
	Handle nullHandle();
	

	pragma(mangle, "Dart_EmptyString")
	Handle emptyString();
	
	pragma(mangle, "Dart_IsNull")
	bool isNull(Handle object);
	
	pragma(mangle, "Dart_ObjectEquals")
	Handle objectEquals(Handle obj1, Handle obj2, bool* equal);
	
	pragma(mangle, "Dart_ObjectIsType")
	Handle objectIsType(Handle object, Handle type, bool* instanceof);
	
	pragma(mangle, "Dart_IsInstance")
	bool isInstance(Handle object);
	
	pragma(mangle, "Dart_IsNumber")
	bool isNumber(Handle object);
	
	pragma(mangle, "Dart_IsInteger")
	bool isInteger(Handle object);

	pragma(mangle, "Dart_IsDouble")
	bool isDouble(Handle object);

	pragma(mangle, "Dart_IsBoolean")
	bool isBoolean(Handle object);

	pragma(mangle, "Dart_IsString")
	bool isString(Handle object);

	pragma(mangle, "Dart_IsStringLatin1")
	bool isStringLatin1(Handle object);

	pragma(mangle, "Dart_IsExternalString")
	bool isExternalString(Handle object);

	pragma(mangle, "Dart_IsList")
	bool isList(Handle object);

	pragma(mangle, "Dart_IsMap")
	bool isMap(Handle object);

	pragma(mangle, "Dart_IsLibrary")
	bool isLibrary(Handle object);

	pragma(mangle, "Dart_IsType")
	bool isType(Handle object);

	pragma(mangle, "Dart_IsFunction")
	bool isFunction(Handle object);

	pragma(mangle, "Dart_IsVariable")
	bool isVariable(Handle object);

	pragma(mangle, "Dart_IsClosure")
	bool isClosure(Handle object);

	pragma(mangle, "Dart_IsTypedData")
	bool isTypedData(Handle object);

	pragma(mangle, "Dart_IsByteBuffer")
	bool isByteBuffer(Handle object);

	pragma(mangle, "Dart_IsFuture")
	bool isFuture(Handle object);

	pragma(mangle, "Dart_InstanceGetType")
	Handle instanceGetType(Handle instance);

	pragma(mangle, "Dart_IntegerFitsIntoInt64")
	Handle integerFitsIntoInt64(Handle integer, bool* fits);

	pragma(mangle, "Dart_IntegerFitsIntoUint64")
	Handle integerFitsIntoUint64(Handle integer, bool* fits);

	pragma(mangle, "Dart_NewInteger")
	Handle newInteger(long value);

	pragma(mangle, "Dart_NewIntegerFromUint64")
	Handle newIntegerFromUint64(ulong value);

	pragma(mangle, "Dart_NewIntegerFromHexCString")
	Handle newInteger(const char* value);
	
	pragma(mangle, "Dart_IntegerToInt64")
	Handle integerToInt64(Handle integer, long* value);
	
	
	pragma(mangle, "Dart_IntegerToUint64")
	Handle integerToUint64(Handle integer, ulong* value);
	
	pragma(mangle, "Dart_IntegerToInt64")
	Handle integerToHexCString(Handle integer, const char** value);
	
	pragma(mangle, "Dart_NewDouble")
	Handle newDouble(double value);
	
	pragma(mangle, "Dart_DoubleValue")
	Handle doubleValue(Handle double_obj, double* value);
	
	pragma(mangle, "Dart_True")
	Handle trueHandle();
	
	pragma(mangle, "Dart_False")
	Handle falseHandle();
	
	pragma(mangle, "Dart_NewBoolean")
	Handle newBoolean(bool value);
	
	pragma(mangle, "Dart_BooleanValue")
	Handle booleanValue(Handle boolean_obj, bool* value);
	
	pragma(mangle, "Dart_StringLength")
	Handle stringLength(Handle str, intptr_t* length);
	
	pragma(mangle, "Dart_NewStringFromCString")
	Handle newStringFromCString(const char* str);
	
	pragma(mangle, "Dart_NewStringFromUTF8")
	Handle newStringFromUTF8(const ubyte* utf8_array, intptr_t length);
	
	pragma(mangle, "Dart_NewStringFromUTF16")
	Handle newStringFromUTF16(const ushort* utf16_array, intptr_t length);
	
	pragma(mangle, "Dart_NewStringFromUTF32")
	Handle newStringFromUTF32(const int* utf32_array, intptr_t length);

	pragma(mangle, "Dart_NewExternalLatin1String")
	Handle newStringFromUTF8(const ubyte* latin1_array, intptr_t length, void* peer, PeerFinalizer callback);
	
	pragma(mangle, "Dart_NewExternalUTF16String")
	Handle newExternalUTF16String(const ushort* utf16_array, intptr_t length, void* peer, PeerFinalizer callback);

	pragma(mangle, "Dart_StringToCString")
	Handle stringToCString(Handle str, const char** cstring);
	
	pragma(mangle, "Dart_StringToUTF8")
	Handle stringToUTF8(Handle str, ubyte** utf8_array, intptr_t* length);

	pragma(mangle, "Dart_StringToLatin1")
	Handle stringToCString(Handle str, ubyte** latin1_array, intptr_t* length);

	pragma(mangle, "Dart_StringToUTF16")
	Handle stringToUTF16(Handle str, ushort* utf16_array, intptr_t* length);

	pragma(mangle, "Dart_StringStorageSize")
	Handle stringStorageSize(Handle str, intptr_t* length);
	
	pragma(mangle, "Dart_MakeExternalString")
	Handle makeExternalString(Handle str, void* array, intptr_t external_allocation_size, void* peer, PeerFinalizer callback);
	
	pragma(mangle, "Dart_StringGetProperties")
	Handle stringGetProperties(Handle str, intptr_t* char_size, intptr_t* str_len, void** peer);
	
	pragma(mangle, "Dart_NewList")
	Handle newList(intptr_t length);
	
	pragma(mangle, "Dart_ListLength")
	Handle listLength(Handle list, intptr_t* length);
	
	pragma(mangle, "Dart_ListGetAt")
	Handle listGetAt(Handle list, intptr_t index);
	
	pragma(mangle, "Dart_ListGetRange")
	Handle listGetRange(Handle list, intptr_t offset, intptr_t length, Handle* result);
	
	pragma(mangle, "Dart_ListSetAt")
	Handle listSetAt(Handle list, intptr_t index, Handle value);
	
	pragma(mangle, "Dart_ListGetAsBytes")
	Handle listGetAsBytes(Handle list, intptr_t offset, ubyte* native_array, intptr_t length);
	
	pragma(mangle, "Dart_ListSetAsBytes")
	Handle listSetAsBytes(Handle list, intptr_t offset, const ubyte* native_array, intptr_t length);
	
	pragma(mangle, "Dart_MapGetAt")
	Handle mapGetAt(Handle map, Handle key);
	
	pragma(mangle, "Dart_MapContainsKey")
	Handle mapContainsKey(Handle map, Handle key);
	
	pragma(mangle, "Dart_MapKeys")
	Handle mapGetAt(Handle map);
	
	pragma(mangle, "Dart_GetTypeOfTypedData")
	DartType getTypeOfTypedData(Handle object);
	
	pragma(mangle, "Dart_GetTypeOfExternalTypedData")
	DartType getTypeOfExternalTypedData(Handle object);

	pragma(mangle, "Dart_NewTypedData")
	Handle newTypedData(DartType type, intptr_t length);

	pragma(mangle, "Dart_NewExternalTypedData")
	Handle newExternalTypedData(DartType type, void* data, intptr_t length);

	pragma(mangle, "Dart_NewByteBuffer")
	Handle newByteBuffer(Handle typed_data);
	
	pragma(mangle, "Dart_TypedDataAcquireData")
	Handle typedDataAcquireData(Handle object, DartType* type, void** data, intptr_t* len);
	
	pragma(mangle, "Dart_TypedDataReleaseData")
	Handle typedDataReleaseData(Handle object);
	
	pragma(mangle, "Dart_GetDataFromByteBuffer")
	Handle getDataFromByteBuffer(Handle byte_buffer);
	
	pragma(mangle, "Dart_New")
	Handle newObject(Handle type, Handle constructor_name, int number_of_arguments, Handle* arguments);
	
	pragma(mangle, "Dart_Allocate")
	Handle allocate(Handle type);
	
	pragma(mangle, "Dart_AllocateWithNativeFields")
	Handle allocateWithNativeFields(Handle type, intptr_t num_native_fields, const intptr_t* native_fields);
	
	pragma(mangle, "Dart_Invoke")
	Handle invoke(Handle target, Handle name, int number_of_arguments, Handle* arguments);
	
	pragma(mangle, "Dart_InvokeClosure")
	Handle invokeClosure(Handle closure, int number_of_arguments, Handle* argument);
	
	pragma(mangle, "Dart_InvokeConstructor")
	Handle invokeConstructor(Handle object, Handle name, int number_of_arguments, Handle* arguments);
	
	pragma(mangle, "Dart_GetField")
	Handle getField(Handle container, Handle name);
	
	pragma(mangle, "Dart_SetField")
	Handle setField(Handle container, Handle name, Handle value);
	
	pragma(mangle, "Dart_ThrowException")
	Handle throwException(Handle exception);
	
	pragma(mangle, "Dart_RethrowException")
	Handle rethrowException(Handle exception, Handle stacktrace);
	
	pragma(mangle, "Dart_CreateNativeWrapperClass")
	Handle createNativeWrapperClass(Handle library, Handle class_name, int field_count);
	
	pragma(mangle, "Dart_GetNativeInstanceFieldCount")
	Handle getNativeInstanceFieldCount(Handle ob, int* count);
	
	pragma(mangle, "Dart_GetNativeInstanceField")
	Handle getNativeInstanceField(Handle obj, int index, intptr_t* value);
	
	pragma(mangle, "Dart_SetNativeInstanceField")
	Handle setNativeInstanceField(Handle obj, int index, intptr_t value);
	
	pragma(mangle, "Dart_GetNativeIsolateData")
	void* getNativeIsolateData(NativeArguments args);

	pragma(mangle, "Dart_GetNativeArguments")
	Handle getNativeArguments(
		NativeArguments args,
		int num_arguments,
		const NativeArgumentDescriptor* arg_descriptor,
		NativeArgumentValue* arg_values
	);
	
	pragma(mangle, "Dart_GetNativeArgument")
	Handle getNativeArgument(NativeArguments args, int index);
	
	pragma(mangle, "Dart_GetNativeArgumentCount")
	int getNativeArgumentCount(NativeArguments args);
	
	pragma(mangle, "Dart_GetNativeFieldsOfArgument")
	Handle getNativeFieldsOfArgument(
		NativeArguments args,
		int arg_index,
		int num_fields,
		intptr_t* field_values
	);
	
	pragma(mangle, "Dart_GetNativeReceiver")
	Handle getNativeReceiver(NativeArguments args, intptr_t* value);
	
	pragma(mangle, "Dart_GetNativeStringArgument")
	Handle getNativeStringArgument(
		NativeArguments args,
		int arg_index,
		void** peer
	);
	
	pragma(mangle, "Dart_GetNativeIntegerArgument")
	Handle getNativeIntegerArgument(NativeArguments args, int index, long* value);
	
	pragma(mangle, "Dart_GetNativeBooleanArgument")
	Handle getNativeBooleanArgument(NativeArguments args, int index, bool* value);
	
	pragma(mangle, "Dart_GetNativeDoubleArgument")
	Handle getNativeDoubleArgument(NativeArguments args, int index, double* value);
	
	pragma(mangle, "Dart_SetReturnValue")
	void setReturnValue(NativeArguments args, Handle retval);
	
	
	pragma(mangle, "Dart_SetWeakHandleReturnValue")
	void setWeakHandleReturnValue(NativeArguments args, WeakPersistentHandle rval);

	pragma(mangle, "Dart_SetBooleanReturnValue")
	void setBooleanReturnValue(NativeArguments args, bool retval);

	pragma(mangle, "Dart_SetIntegerReturnValue")
	void setIntegerReturnValue(NativeArguments args, int retval);

	pragma(mangle, "Dart_SetDoubleReturnValue")
	void setDoubleReturnValue(NativeArguments args, double retval);

	alias NativeFunction = void function(NativeArguments);
	
	alias NativeEntryResolver = NativeFunction function(Handle name, int num_of_arguments, bool* auto_setup_scope);
	
	alias NativeEntrySymbol = ubyte* function(NativeFunction nf);
	
	alias EnvironmentCallback = Handle function(Handle name);
	
	pragma(mangle, "Dart_SetEnvironmentCallback")
	Handle setEnvironmentCallback(EnvironmentCallback);
	
	pragma(mangle, "Dart_SetNativeResolver")
	Handle setNativeResolver(Handle library, NativeEntryResolver resolver, NativeEntrySymbol symbol);
	
	pragma(mangle, "Dart_GetNativeResolver")
	Handle getNativeResolver(Handle library, NativeEntryResolver* resolver);
	
	pragma(mangle, "Dart_GetNativeSymbol")
	Handle getNativeSymbol(Handle library, NativeEntrySymbol* resolver);
	
	alias LibraryTagHandler = Handle function(LibraryTag tag, Handle library_or_package_map_url, Handle url);
	
	pragma(mangle, "Dart_SetLibraryTagHandler")
	Handle setLibraryTagHandle(LibraryTagHandler handler);
	
	pragma(mangle, "Dart_DefaultCanonicalizeUrl")
	Handle defaultCanonicalizeUrl(Handle base_url, Handle url);
	
	pragma(mangle, "Dart_LoadScript")
	Handle loadScript(
		Handle url, 
		Handle resolved_url,
		Handle source,
		intptr_t line_offset,
		intptr_t col_offset
	);
	
	pragma(mangle, "Dart_LoadScriptFromSnapshot")
	Handle loadScriptFromSnapshot(const ubyte* script_snapshot_buffer, intptr_t script_snapshot_size);
	
	pragma(mangle, "Dart_LoadKernel")
	Handle loadKernel(void* kernel_program);
	
	pragma(mangle, "Dart_ReadKernelBinary")
	void* readkernelBinary(const ubyte* buffer, intptr_t buffer_len);
	
	pragma(mangle, "Dart_RootLibrary")
	Handle rootLibrary();
	
	pragma(mangle, "Dart_SetRootLibrary")
	Handle setRootLibrary(Handle library);
	
	pragma(mangle, "Dart_GetType")
	Handle getType(
		Handle library, 
		Handle class_name,
		intptr_t number_of_type_arguments,
		Handle* type_arguments
	);
	
	pragma(mangle, "Dart_GetClass")
	Handle getClass(Handle library, Handle class_name);
	
	pragma(mangle, "Dart_LibraryUrl")
	Handle libraryUrl(Handle library);
	
	pragma(mangle, "Dart_GetLoadedLibraries")
	Handle getLoadedLibraries();
	
	pragma(mangle, "Dart_LookupLibrary")
	Handle lookupLibrary(Handle url);
	
	pragma(mangle, "Dart_LibraryHandleError")
	Handle libraryHandleError(Handle library, Handle error);
	
	pragma(mangle, "Dart_LoadLibrary")
	Handle loadLibrary(
		Handle url, 
		Handle resolved_url,
		Handle source,
		intptr_t line_offset,
		intptr_t column_offset
	);
	
	pragma(mangle, "Dart_LibraryImportLibrary")
	Handle libraryImportLibrary(Handle library, Handle import_, Handle prefix);
	
	pragma(mangle, "Dart_GetImportsOfScheme")
	Handle getImportsOfScheme(Handle scheme);
	
	pragma(mangle, "Dart_LoadSource")
	Handle loadSource(
		Handle library,
		Handle url,
		Handle resolved_url,
		Handle source,
		intptr_t line_offset,
		intptr_t column_offset
	);
	
	
	pragma(mangle, "Dart_LibraryLoadPatch")
	Handle libraryLoadPatch(Handle library, Handle url, Handle patch_source);
	
	pragma(mangle, "Dart_FinalizeLoading")
	Handle finalizeLoading(bool complete_futures);
	
	pragma(mangle, "Dart_GetPeer")
	Handle getPeer(Handle object, void** peer);
	
	pragma(mangle, "Dart_SetPeer")
	Handle setPeer(Handle object, void* peer);
	
	pragma(mangle, "Dart_IsKernelIsolate")
	bool isKernelIsolate(Isolate isolate);
	
	pragma(mangle, "Dart_KernelIsolateIsRunning")
	bool kernelIsolateIsRunning();
	
	pragma(mangle, "Dart_ServiceWaitForKernelPort")
	Port serviceWaitForKernelPort();
	
	pragma(mangle, "Dart_KernelPort")
	Port kernelPort();
	
	pragma(mangle, "Dart_IsServiceIsolate")
	bool isServiceIsolate(Isolate isolate);
	
	pragma(mangle, "Dart_ServiceWaitForLoadPort")
	Port serviceWaitForLoadPort();
	
	pragma(mangle, "Dart_SaveJITFeedback")
	Handle saveJITFeedback(ubyte** buffer, intptr_t* buffer_length);
	
	pragma(mangle, "Dart_Precompile")
	Handle precompile(
		QualifiedFunctionName[] entry_points,
		ubyte* jit_feedback,
		intptr_t jit_feedback_length
	);
	
	pragma(mangle, "Dart_CreateAppAOTSnapshotAsAssembly")
	Handle createApAOTSnapshotAsAssembly(ubyte** assembly_buffer, intptr_t* assembly_size);
	
	pragma(mangle, "Dart_CreateAppAOTSnapshotAsBlobs")
	Handle createAppAOTSnapshotAsBlobs(
		ubyte** vm_snapshot_data_buffer,
		intptr_t* vm_snapshot_data_size,
		ubyte** vm_snapshot_instructions_buffer,
		intptr_t* vm_snapshot_instructions_size,
		ubyte** isolate_snapshot_data_buffer,
		intptr_t* isolate_snapshot_data_size,
		ubyte** isolate_snapshot_instructions_buffer,
		intptr_t* isolate_snapshot_instructions_size
	);
	
	pragma(mangle, "Dart_CreateAppJITSnapshotAsBlobs")
	Handle createAppJITSnapshotAsBlobs(
		ubyte** isolate_snapshot_data_buffer,
		intptr_t* isolate_snapshot_data_size,
		ubyte** isolate_snapshot_instructions_buffer,
		intptr_t* isolate_snapshot_instructions_size
	);
	
	pragma(mangle, "Dart_IsPrecompiledRuntime")
	bool isPrecompiledRuntime();
	
	pragma(mangle, "Dart_DumpNativeStackTrace")
	void dumpNativeStackTrace(void* context);
	
}