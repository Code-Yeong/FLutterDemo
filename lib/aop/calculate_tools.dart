
import 'package:aspectd/aspectd.dart';

@Aspect()
@pragma('vm:entry-point')
class Calculate{

  @Execute("package:flutter_demo/aop/test_aop.dart", "TestAopDemo", "-add")
  @pragma('vm:entry-point')
  add(PointCut pointCut){
    print('before proceed');
    var result = pointCut.proceed();
    print('after proceed');
    return result;
  }

  mul(a, b){
    return a * b;
  }
}