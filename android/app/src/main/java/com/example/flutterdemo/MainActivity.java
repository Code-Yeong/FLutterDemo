package com.example.flutterdemo;

import android.os.Bundle;
import android.util.Log;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  static String CHANNEL = "com.example.flutterdemo/test";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    Log.i("FlutterView","register Method");
    new MethodChannel(getFlutterView(),CHANNEL).setMethodCallHandler(new CustomMethodHandler());
  }

  class CustomMethodHandler implements MethodChannel.MethodCallHandler{

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
      Log.i("FlutterView","Method:"+methodCall.method);
      switch (methodCall.method){
        case "sendMsg":
          result.success("Yes, I have received your msg!");
          break;
        case "receiveMsg":
          result.success("The msg have be sent, do you received?");
          break;
        default:
          try {
            throw new Exception("The method has been not implemented!");
          } catch (Exception e) {
            e.printStackTrace();
          }
          break;
      }
    }
  }
}