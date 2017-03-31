module dart.tools;

import dart.api;
import std.stdint;

private struct _Dart_BreakPoint{}
private struct _Dart_StackTrace{}
private struct _Dart_ActivationFrame{}

alias BreakPoint = _Dart_BreakPoint*;
alias StrackTrace = _Dart_StackTrace*;
alias ActivationFrame = _Dart_ActivationFrame*;

alias IsolateId = Port;

enum {
	ILLEGAL_BREAKPOINT_ID = 0,
	ILLEGAL_ISOLATE_ID = ILLEGAL_PORT,
}

enum IsolateEvent {
	kCreated = 0,
	kInterrupted,
	kShutdown,
}

//On which exceptions to pause. line 334
enum ExceptionPauseInfo{
	kNoPauseOnExceptions = 1,
	kPauseOnUnhandledExceptions,
	kPauseOnAllExceptions,
	kInvalidExceptionPauseInfo
}
//line 924
enum TimeLineStream{
	DISABLE=0,
	API = 1,
	COMPILER = 1<<1,
	DART=1<<2,
	DEBUGGER = 1<<3,
	EMBEDDER = 1<<4,
	GC = 1<<5,
	ISOLATE = 1<<6,
	VM=1<<7, 
	ALL = 254
}
enum StreamConsumerState {
  /** Indicates a new stream is being output */
  Start = 0,
  /** Data for the current stream */
  Data = 1,
  /** Indicates stream is finished */
  Finish = 2,
}
//line 1013
enum TimeLineEventType {
  Begin,          // Phase = 'B'.
  End,            // Phase = 'E'.
  Instant,        // Phase = 'i'.
  Duration,       // Phase = 'X'.
  Async_Begin,    // Phase = 'b'.
  Async_End,      // Phase = 'e'.
  Async_Instant,  // Phase = 'n'.
  Counter,        // Phase = 'C'.
}

struct CodeLocation {
	Handle script_url;  // Url (string) of the script.
	int library_id;      // Library in which the script is loaded.
	int token_pos;       // Code address.
}

extern(C){

alias ExceptionThrownHandler=void function(IsolateId isolate_id, Handle exception_object, StrackTrace strack_trace);

alias IsolateEventHandler = void function(IsolateId isolate_id, IsolateEvent kind);

//ref const CodeLocation&
alias PausedEventHandler = void function(IsolateId isolate_id, intptr_t bp_id, ref CodeLocation location);

alias BreakPointResolvedHandler = void function(IsolateId isolate_id, intptr_t bp_id, ref CodeLocation location);

pragma(mangle, "Dart_CacheObject")
intptr_t cacheObject(Handle object_in);

pragma(mangle, "Dart_GetCachedObject")
Handle getCachedObject(intptr_t obj_id);

pragma(mangle, "Dart_GetLibraryIds")
Handle getLibraryIds();

pragma(mangle, "Dart_GetLibraryDebuggable")
Handle getLibraryDebuggable(intptr_t library_id, bool* is_debuggable);

pragma(mangle, "Dart_SetLibraryDebuggable")
Handle setLibraryDebuggable(intptr_t library_id, bool is_debuggable);

pragma(mangle, "Dart_GetScriptURLs")
Handle getScriptURLs(Handle library_url);

pragma(mangle, "Dart_ScriptGetSource")
Handle scriptGetSource(intptr_t library_id, Handle script_url_in);

pragma(mangle, "Dart_ScriptGetTokenInfo")
Handle scriptGetTokenInfo(intptr_t library_id, Handle script_url_in);

pragma(mangle, "Dart_GenerateScriptSource")
Handle generateScriptSource(Handle library_url_id, Handle script_url_in);

pragma(mangle, "Dart_SetBreakpoint")
Handle setBreakpoint(Handle script_url, intptr_t line_number);

pragma(mangle, "Dart_RemoveBreakpoint")
Handle removeBreakpoint(intptr_t bp_id);

pragma(mangle, "Dart_GetBreakpointURL")
Handle getBreakpointURL(intptr_t bp_id);

pragma(mangle, "Dart_GetBreakpointLine")
Handle getBreakpointLine(intptr_t bp_id);

pragma(mangle, "Dart_SetBreakpointAtEntry")
Handle setBreakpointAtEntry(Handle library, Handle class_name, Handle function_name);

pragma(mangle, "Dart_OneTimeBreakAtEntry")
Handle oneTimeBreakAtEntry(Handle library, Handle class_name, Handle function_name);

pragma(mangle, "Dart_SetStepOver")
Handle setStepOver();

pragma(mangle, "Dart_SetStepInto")
Handle setStepInto();

pragma(mangle, "Dart_SetStepOut")
Handle setStepOut();

pragma(mangle, "Dart_SetPausedEventHandler")
void setPausedEventHandler(PausedEventHandler handler);

pragma(mangle, "Dart_SetBreakpointResolvedHandler")
void setBreakpointResolvedHandler(BreakPointResolvedHandler handler);

pragma(mangle, "Dart_SetExceptionThrownHandler")
void setExceptionThrownHandler(ExceptionThrownHandler handler);

pragma(mangle, "Dart_SetIsolateEventHandler")
void setIsolateEventHandler(IsolateEventHandler handler);

pragma(mangle, "Dart_SetExceptionPauseInfo")
Handle setExceptionPauseInfo(ExceptionPauseInfo pause_info);

pragma(mangle, "Dart_GetExceptionPauseInfo")
ExceptionPauseInfo getExceptionPauseInfo();

pragma(mangle, "Dart_GetStackTrace")
Handle getStackTrace(StrackTrace* trace);

pragma(mangle, "Dart_GetStackTraceFromError")
Handle getStackTraceFromError(Handle error, StrackTrace* trace);

pragma(mangle, "Dart_StackTraceLength")
Handle stackTraceLength(StrackTrace trace, intptr_t* length);

pragma(mangle, "Dart_GetActivationFrame")
Handle getActivationFrame(StrackTrace trace, int frame_index, ActivationFrame* frame);

pragma(mangle, "Dart_ActivationFrameInfo")
Handle activationFrameInfo(ActivationFrame activation_frame, Handle* function_name, Handle script_url, intptr_t* line_number, intptr_t* column_number);

pragma(mangle, "Dart_ActivationFrameGetLocation")
Handle activationFrameGetLocation(ActivationFrame activation_frame, Handle* function_name, Handle* function_, CodeLocation* location);

pragma(mangle, "Dart_ActivationFrameGetFramePointer")
Handle activationFrameGetFramePointer(ActivationFrame activation_frame, uintptr_t* frame_pointer);

pragma(mangle, "Dart_GetLocalVariables")
Handle getLocalVariables(ActivationFrame activation_frame);

pragma(mangle, "Dart_GetFunctionOrigin")
Handle getFunctionOrigin(Handle function_);

pragma(mangle, "Dart_GetGlobalVariables")
Handle getGlobalVariables(intptr_t library_id);

pragma(mangle, "Dart_ActivationFrameEvaluate")
Handle activationFrameEvaluate(ActivationFrame activation_frame, Handle expr_in);

pragma(mangle, "Dart_EvaluateExpr")
Handle evaluateExpr(Handle target, Handle expr);

pragma(mangle, "Dart_GetObjClass")
Handle getObjClass(Handle object);

pragma(mangle, "Dart_GetObjClassId")
Handle getObjClassId(Handle object, intptr_t* class_id);

pragma(mangle, "Dart_GetSupertype")
Handle getSupertype(Handle type);

pragma(mangle, "Dart_GetClassFromId")
Handle getClassFromId(intptr_t class_id);

pragma(mangle, "Dart_GetClassInfo")
Handle getClassInfo(
	intptr_t class_id,
	Handle* class_name,
	intptr_t* library_id,
	intptr_t* super_class_id,
	Handle* static_fields
);

pragma(mangle, "Dart_GetClosureInfo")
Handle getClosureInfo(Handle closure, Handle* name, Handle* signature, CodeLocation* location);

pragma(mangle, "Dart_GetInstanceFields")
Handle getInstanceFields(Handle object);

pragma(mangle, "Dart_GetStaticFields")
Handle getStaticFields(Handle target);

pragma(mangle, "Dart_GetLibraryFromId")
Handle getLibraryFromId(intptr_t library_id);

pragma(mangle, "Dart_LibraryId")
Handle libraryId(Handle library, intptr_t* library_id);

pragma(mangle, "Dart_GetLibraryFields")
Handle getLibraryFields(intptr_t library_id);

pragma(mangle, "Dart_GetLibraryImports")
Handle getLibraryImports(intptr_t library_id);

pragma(mangle, "Dart_GetLibraryURL")
Handle getLibraryURL(intptr_t library_id);

pragma(mangle, "Dart_GetIsolate")
Isolate getIsolate(IsolateId isolate_id);

pragma(mangle, "Dart_GetIsolateId")
IsolateId getIsolateId(Isolate isolate);

alias ServiceRequestCallback =bool function(
	const char* method, 
	const char** param_keys,
	const char** param_values,
	intptr_t num_params,
	void* user_data,
	const char** json_object
	);

pragma(mangle, "Dart_RegisterIsolateServiceRequestCallback")
void registerIsolateServiceRequestCallback(const char* method, ServiceRequestCallback callback, void* user_data);

pragma(mangle, "Dart_RegisterRootServiceRequestCallback")
void registerRootServiceRequestCallback(const char* method, ServiceRequestCallback callback, void* user_data);

alias ServiceStreamListenCallback=bool function(const char* stream_id);

alias ServiceStreamCancelCallback = void function(const char* stream_id);

pragma(mangle, "Dart_SetServiceStreamCallbacks")
Handle setServiceStreamCallbacks(ServiceStreamListenCallback listen_callback,
ServiceStreamCancelCallback cancel_callback);

pragma(mangle, "Dart_ServiceSendDataEvent")
Handle serviceSendDataEvent(
	const char* stream_id,
	const char* event_kind,
	const ubyte* bytes,
	intptr_t bytes_length
);

alias FileModifiedCallback = bool function(const char* url, long since);

pragma(mangle, "Dart_SetFileModifiedCallback")
Handle setFileModifiedCallback(FileModifiedCallback file_modified_callback);

pragma(mangle, "Dart_TimelineGetMicros")
long timelineGetMicros();

pragma(mangle, "Dart_GlobalTimelineSetRecordedStreams")
void globalTimelineSetRecordedStreams(long stream_mask);

alias StreamConsumer= void function(StreamConsumerState state, const char* stream_name, const ubyte* buffer, intptr_t buffer_length, void* stream_callback_data);

pragma(mangle, "Dart_GlobalTimelineGetTrace")
bool globalTimelineGetTrace(StreamConsumer consumer, void* user_data);

pragma(mangle, "Dart_TimelineEvent")
void timelineEvent(
	const char* label,
	long timestamp0,
	long timestamp1_or_async_id,
	TimeLineEventType type,
	intptr_t argument_count,
	const char** argument_names,
	const char** argument_values
);

pragma(mangle, "Dart_SetThreadName")
void setThreadName(const char* name);

alias void function()  EmbedderTimelineStartRecording;
alias void function() EmbedderTimelineStopRecording;
pragma(mangle, "Dart_SetEmbedderTimelineCallbacks")
void setEmbedderTimelineCallbacks(
	EmbedderTimelineStartRecording start_recording,
	EmbedderTimelineStopRecording stop_recording
);

}
