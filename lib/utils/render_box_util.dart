//获取组件对应的RenderBox，方便拿到组件的位置参数
import 'dart:ui';

Rect getRect(context) {
  var object = context.findRenderObject();
  var translation = object?.getTransformTo(null)?.getTranslation();
  var size = object?.semanticBounds?.size;

  if (translation != null && size != null) {
    return new Rect.fromLTWH(translation.x, translation.y, size.width, size.height);
  } else {
    return null;
  }
}
