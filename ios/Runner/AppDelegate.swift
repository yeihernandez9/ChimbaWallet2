import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
      let controller:  FlutterViewController =  window?.rootViewController as! FlutterViewController
      let methodChannel =  FlutterMethodChannel(name:"samples.flutter.io/battery",binaryMessenger: controller.binaryMessenger)
      
      methodChannel.setMethodCallHandler({(call: FlutterMethodCall, result: FlutterResult)-> Void in
          if(call.method == "getBatteryLevel"){
              let getBatteryLevel =  UIDevice().batteryLevel
              result(getBatteryLevel)
          }else{
              result(FlutterMethodNotImplemented)
          }
      })
      
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
