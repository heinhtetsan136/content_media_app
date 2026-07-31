import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSession {
  FlutterSecureStorage flutterSecureStorage=FlutterSecureStorage();
   static const String _token="token";
   static const String _id="id";
   static const String _email="email";
   static const String _name="name";
  Future<void>  saveToken({required String token})async{
     await flutterSecureStorage.write(key: _token  , value: token);
   }
   Future<String?> getToken()async{
    final result= await flutterSecureStorage.read(key: _token);
    return result?.toString();
   }
  Future<void>  saveId({required String id})async{
    await flutterSecureStorage.write(key: _id  , value: id);
  }
  Future<String?> getId()async{
    final result= await flutterSecureStorage.read(key: _id);
    print(result.toString());
    return (await flutterSecureStorage.read(key: _id))?.toString();
  }
  Future<void>  saveName({required String name})async{
    await flutterSecureStorage.write(key: _name   , value: name);
  }
  Future<String?> getName()async{
    final result= await flutterSecureStorage.read(key: _name);
    return result?.toString();
  }
  Future<void>  saveEmail({required String email})async{
     flutterSecureStorage.write(key: _email  , value: email);
  }
  Future<String?> getEmail()async{
    final result= await flutterSecureStorage.read(key: _email);
    return result?.toString();
  }
  Future<void> logOut()async{
    await flutterSecureStorage.deleteAll();
  }
}