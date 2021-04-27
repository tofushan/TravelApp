//
//  AppDelegate.swift
//  CS207
//
//  Created by Hugh Thomas on 1/20/21.
//

import UIKit
import CoreLocation
import UserNotifications
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //print("My App didFinishLaunchingWithOptions")
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        // request user authorization for notifications
        center.requestAuthorization(options: options) { (granted, error) in
            if granted {
                print("Permission Granted")
                DispatchQueue.main.async() {
                    application.registerForRemoteNotifications()
                }
                self.setUpNotification()
            }
        }
        
        FirebaseApp.configure()
        
        return true
    }

    // MARK: Notifications
    
    func setUpNotification() {
        
        // create the notification content attributes
        let content = UNMutableNotificationContent()
        content.title = "CS207 Class"
        content.body = "Every Wednesday at 3:30pm on Zoom"
        content.categoryIdentifier = "myUniqueCategory"

        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.weekday = 4  // Wednesday
        dateComponents.hour = 15  // 15:00 hours
        dateComponents.minute = 53   // 40 minutes
           
        // Create the trigger as a repeating event.
        // 1.
        //let timeTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        //2.
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false) // 10 seconds from now
        
//        let chapelCoords = CLLocationCoordinate2D(latitude: 36.001678, longitude: -78.939767)
//        let region = CLCircularRegion(center: chapelCoords, radius: 275.0, identifier: "DukeChapel")
//        region.notifyOnEntry = true;
//        region.notifyOnExit = true;
//        let locationTrigger = UNLocationNotificationTrigger(region: region, repeats: true)

        let notificationAction = UNNotificationAction(identifier: "remindLater", title: "Remind me later", options: [])
        let myCategory = UNNotificationCategory(identifier: "myUniqueCategory", actions: [notificationAction], intentIdentifiers: [], options: [])

        //content.categoryIdentifier = myCategory
        
        UNUserNotificationCenter.current().setNotificationCategories([myCategory])
        
        // Create the request
        let request = UNNotificationRequest(identifier: "myUniqueIdentifierString1234",
                    content: content, trigger: timeTrigger)
        
        // Add the request to the main Notification center.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
              // Handle any errors.
           } else {
                print("Notification created")
            }
        }
        
    }

    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let content = notification.request.content
        // Process notification content
        print("Received Notification with \(content.title) -  \(content.body)")

        //completionHandler([])
        //3.
        completionHandler([.badge, .sound]) // Display notification as regular alert and play sound
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let actionIdentifier = response.actionIdentifier
         
        switch actionIdentifier {
        case UNNotificationDismissActionIdentifier: // Notification was dismissed by user
            // Do something
            completionHandler()
        case UNNotificationDefaultActionIdentifier: // App was opened from notification
            // Do something
            completionHandler()
        case "remindLater": do {
                let newDate = Date(timeInterval: 10, since: Date())
                print("Rescheduling notification until \(newDate)")
                // TODO: reschedule the notification
            
            }
            completionHandler()
        default:
            completionHandler()
        }
    }
    
    // MARK: Remote Notifications Protocol
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
      let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
      let token = tokenParts.joined()
      print("Push Notification Device Token: \(token)")
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
      print("Push Notification Error : Failed to register: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        guard let aps = userInfo["aps"] as? [String: AnyObject] else {
            completionHandler(.failed)
            return
          }

//         Here is the second example of the apns.json message :
//         {
//          "aps": {
//          "CS207-Grades-available": 1
//          }
//         }

        if aps["CS207-Grades-available"] as? Int == 1 {
            print("Your grades have been published")
            completionHandler(.newData)
        }

    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

