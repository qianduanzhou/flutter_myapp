import 'package:encrypt/encrypt.dart';

class AESUtil {
  String key;

  AESUtil(this.key);

  encrypt(text) {
    final utf8Key = Key.fromUtf8(key != '' ? key : 'kunceschmczcxtps');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(utf8Key, mode: AESMode.ecb));
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base64;
  }

  decrypt(text) {
    final utf8Key = Key.fromUtf8(key != '' ? key : 'kunceschmczcxtps');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(utf8Key, mode: AESMode.ecb));
    final decrypted = encrypter.decrypt(text, iv: iv);
    return decrypted;
  }
}