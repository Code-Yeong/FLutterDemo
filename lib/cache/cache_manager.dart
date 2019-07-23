import 'dart:io';

import 'package:flutter_demo/cache/cache.dart';

class CacheManager with Cache{

  CacheManager(CacheType type, String directory, { String fileName }){
    assert(type != null);
    assert(directory != null);
    this.fileName = fileName;
    this.directory = directory;
    this.cacheType = type;
  }

  @override
  download(List<dynamic> urls) async{

  }


  @override
  cache(sourcePath, dstFileName) {
    if(sourcePath==null || dstFileName == null)
      return null;
    File file = new File(sourcePath);
    if(cacheType == CacheType.temporary){
      if(directory!= null){
        Directory dir = new Directory('$cacheDir/$directory');
        if(!dir.existsSync()){
          dir.createSync();
        }
        file = file.copySync('${dir.path}/$dstFileName');
      }else{
        file = file.copySync('$cacheDir/$dstFileName');
      }
    }else{
      if(directory!= null){
        Directory dir = new Directory('$docDir/$directory');
        if(!dir.existsSync()){
          dir.createSync();
        }
        file = file.copySync('${dir.path}/$dstFileName');
      }else{
        file = file.copySync('$docDir/$dstFileName');
      }
    }
    return file.path;
  }

  @override
  writeCache(fileName) async{
    File file;
    if(cacheType == CacheType.temporary){
      if(directory!=null){
        Directory dir = new Directory('$cacheDir/$directory');
        if(!dir.existsSync()){
          dir.createSync();
        }
        file = new File('$cacheDir/$directory/$fileName');
      }else{
        file = new File('$cacheDir/$fileName');
      }
    }else{
      if(directory!=null){
        Directory dir = new Directory('$docDir/$directory');
        if(!dir.existsSync()){
          dir.createSync();
        }
        file = new File('$docDir/$directory/$fileName');
      }else{
        file = new File('$docDir/$fileName');
      }
    }
    assert(file != null);
    file = await file.create();
    return file.path;
  }

  @override
  readCache(fileName) {
    String filePath;
    assert(fileName != null);
    if(directory != null) {
      filePath = "$cacheDir/$directory/$fileName";
    }else{
      filePath = "$cacheDir/$fileName";
    }

    if(isCached(filePath)){
      return filePath;
    }else{
      if(directory != null) {
        filePath = "$docDir/$directory/$fileName";
      }else{
        filePath = "$docDir/$fileName";
      }
      if(isCached(filePath)){
        return filePath;
      }
    }
    return null;
  }
}