module dart.native;

import dart.api;
import std.stdint;

//Dart_CObject_Type
enum CObjectType {
  Null = 0,
  Bool,
  Int32,
  Int64,
  Bigint,
  Double,
  String,
  Array,
  TypedData,
  ExternalTypedData,
  SendPort,
  Capability,
  Unsupported,
  NumberOfTypes
}

//Dart_CObject
struct CObject {
  CObjectType type;
  private union Value{
    bool as_bool;
    int32_t as_int32;
    int64_t as_int64;
    double as_double;
    char* as_string;
	
    private struct BigInt{
      bool neg;
      intptr_t used;
      CObject* digits;
    } 
	BigInt as_bigint;
	
    private struct SendPort{
      Port id;
      Port origin_id;
    }
	SendPort as_send_port;
    
	private struct Capability {
      int64_t id;
    }
	Capability as_capability;
    
	private struct ARRAY{
      intptr_t length;
      CObject** values;
    }
	ARRAY as_array;
	
    private struct TypedData{
      DartType type;
      intptr_t length;
      uint8_t* values;
    }
	TypedData as_typed_data;
	
    private struct ExternalTypedData{
      DartType type;
      intptr_t length;
      uint8_t* data;
      void* peer;
      WeakPersistentHandleFinalizer callback;
    }
	ExternalTypedData as_external_typed_data;
  }
  Value value;
}

extern(C){
	pragma(mangle, "Dart_PostCObject")
	bool postCObject(Port port_id, CObject* message);

	pragma(mangle, "Dart_PostInteger")
	bool postInteger(Port port_id, long message);

	alias NativeMessageHandler= void function(Port dest_port_id, CObject* message);

	pragma(mangle, "Dart_NewNativePort")
	Port newNativePort(const char* name, NativeMessageHandler handler, bool handle_concurrently);

	pragma(mangle, "Dart_CloseNativePort")
	bool closeNativePort(Port native_port_id);

	pragma(mangle, "Dart_CompileAll")
	Handle compileAll();

	pragma(mangle, "Dart_ParseAll")
	Handle parseAll();
}