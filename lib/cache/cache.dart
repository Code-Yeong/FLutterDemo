import 'dart:io';

import 'package:path_provider/path_provider.dart';

enum CacheType{
  temporary,
  semiPermanent,
  permanent,
}

abstract class Cache{

  ///缓存类型
  CacheType _cacheType;

  String _directory;

  String _fileName;

  String _cacheDir;

  String _docDir;

  get cacheType => _cacheType;

  set cacheType(cacheType){
    _cacheType = cacheType;
  }

  get directory => _directory;

  set directory(directory){
    _directory = directory;
  }

  get fileName => _fileName;

  set fileName(fileName){
    _fileName = fileName;
  }

  get cacheDir => _cacheDir;

  get docDir => _docDir;

  ///初始化
  init() async{
    Directory _dataDirectory;
    if(Platform.isAndroid){
      _dataDirectory = await getExternalStorageDirectory();
    }else if(Platform.isIOS){
      _dataDirectory = await getApplicationDocumentsDirectory();
    }
    Directory _tempDir = await getTemporaryDirectory();
    _docDir = _dataDirectory.path;
    _cacheDir = _tempDir.path;
  }

  download(List<dynamic> urls);

  cache(sourcePath, dstFileName);

  writeCache(fileName);

  readCache(fileName);

  ///清除非permanent缓存
  clean({String dir, String fileName}) async{
    print('cleaning non permanent cache...');
    try{
      String path;
      if(fileName!=null){
        path = '$_cacheDir/$dir/$fileName';
        File file = File(path);
        if(file.existsSync()){
          return file.deleteSync();
        }else{
          path = '$_docDir/$dir/$fileName';
          File file = File(path);
          if(file.existsSync()){
            return file.deleteSync();
          }
        }
      }else{
        if(dir != null){
          path = '$_cacheDir/$dir';
          Directory directory = Directory(path);
          if(directory.existsSync()){
            return directory.deleteSync(recursive: true);
          }
        }else {
          path = '$_docDir/$dir';
          Directory directory = Directory(path);
          if (directory.existsSync()) {
            return directory.deleteSync(recursive: true);
          }
        }
      }
    }catch(e){
      print('Exception: $e');
      return false;
    }
    print('clean finished!');
    return false;
  }

  ///清除temporary缓存
  cleanTemp({String dir, String fileName}){
    print('cleaning non permanent cache...');
    try{
      String path;
      if(fileName!=null){
        path = '$_cacheDir/$dir/$fileName';
        File file = File(path);
        if(file.existsSync()){
          return file.deleteSync();
        }
      }else{
        if(dir != null){
          path = '$_cacheDir/$dir';
          Directory directory = Directory(path);
          if(directory.existsSync()){
            return directory.deleteSync(recursive: true);
          }
        }
      }
    }catch(e){
      print('Exception: $e');
      return false;
    }
    print('clean finished!');
    return false;
  }

  ///强制清除所有类型缓存
  forceClean({String dir, String fileName}){}

  isCached(String path){
    File file = File(path);
    return file.existsSync();
  }
}