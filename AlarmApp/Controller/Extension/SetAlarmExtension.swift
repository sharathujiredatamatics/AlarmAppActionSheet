//
//  SaveNotificationAction.swift
//  GoogleNotification
//
//  Created by Datamatics on 19/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
import UserNotifications
extension AlarmViewController : UNUserNotificationCenterDelegate {
    func setNotification(title : String, subTitle : String, hour : Int, minute : Int, type :Bool, identifier : String){
        var dateComponent = DateComponents()
//        dateComponent.year = year
//        dateComponent.month = month
//        dateComponent.day = day
        dateComponent.hour = hour
        dateComponent.minute = minute
        let content = UNMutableNotificationContent()
        let snooze = UNNotificationAction(identifier: "snooze", title: "Snooze", options: UNNotificationActionOptions.foreground)
        let delete = UNNotificationAction(identifier: "delete", title: "Delete", options: UNNotificationActionOptions.destructive)
        
        let category = UNNotificationCategory(identifier: identifier, actions: [snooze, delete], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        content.title = title
        content.subtitle = subTitle
        content.categoryIdentifier = identifier
        content.sound = UNNotificationSound.default
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: type)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        if response.actionIdentifier == "snooze"
        {
//            let showOnMap = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisplayPlaceOnMapViewController") as! DisplayPlaceOnMapViewController
//            showOnMap.identifier = response.notification.request.identifier
//            present(showOnMap, animated: true)
        }
        else if response.actionIdentifier == "delete"{
//            let displayPlaceViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisplayPlaceViewController") as! DisplayPlaceViewController
//            present(displayPlaceViewController, animated: true)
            
        }
        else
        {
//            let displayPlaceViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisplayPlaceViewController") as! DisplayPlaceViewController
//            present(displayPlaceViewController, animated: true)
        }
        
        completionHandler()
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
};
