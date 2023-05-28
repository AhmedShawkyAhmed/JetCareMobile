import UIKit
import Flutter
import GoogleMaps
import FirebaseCore
import FirebaseMessaging
import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyA4LqOxrIrI4oZXDAU1vWMUGoE5xuWTY5s")
      FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
        GeneratedPluginRegistrant.register(with: registry)
      }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      // Pass device token to messaging
      Messaging.messaging().apnsToken = deviceToken

      return super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
  }
  override func application(_ application: UIApplication,
                            didReceiveRemoteNotification notification: [AnyHashable : Any],
                            fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

      // Handle it for firebase messaging analytics
      if ((notification["gcm.message_id"]) != nil) {
          Messaging.messaging().appDidReceiveMessage(notification)
      }

      return super.application(application, didReceiveRemoteNotification: notification, fetchCompletionHandler: completionHandler)
  }
}
