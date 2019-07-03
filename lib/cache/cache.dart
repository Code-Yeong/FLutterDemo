enum CacheType{
  temporary,
  semiPermanent,
  permanent,
}

abstract class Cache{

  ///缓存类型
  CacheType _cacheType;

  get cacheType => _cacheType;

  set cacheType(cacheType){
    _cacheType = cacheType;
  }

  download(List<dynamic> urls);

  ///清除非permanent缓存
  clean();

  ///清除temporary缓存
  cleanTemp();

  ///强制清除所有类型缓存
  forceClean();
}