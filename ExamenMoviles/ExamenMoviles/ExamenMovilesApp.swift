//
//  ExamenMovilesApp.swift
//  ExamenMoviles
//
//  Created by Leví Diaz on 21/11/24.
//

import SwiftUI
import ParseCore

@main
struct ExamenMovilesApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    /// Parse setup and initial app launch configuration.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        /// Initializes Parse with the provided configuration.
        Parse.initialize(with: ParseClientConfiguration {
            /// Assigns `applicationId`, `clientKey`, and `server` obtained from the configuration file.
            $0.applicationId = "APP_ID"
            $0.clientKey = "MASTER_KEY"
            $0.server = "https://examenes.meeplab.com/parse"
        })
        
        print("Connected to parse")

        return true
    }

    /// Function called when the device is successfully registered for remote notifications.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Device token: \(deviceToken)")
    }

    /// Function called if the remote notification registration fails.
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error)")
    }

    /// Function to handle remote notifications when they are received in the background.
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Received remote notification: \(userInfo)")
        completionHandler(.newData)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    /// Configuration to show notifications when the app is in the foreground.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound, .list])  // Show notification in various formats.
    }
    
    /// Handles the response when the user interacts with the notification.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response.notification.request.content.userInfo)
        completionHandler()
    }
}
