//
//  SaveNotificationAction.swift
//  GoogleNotification
//
//  Created by Datamatics on 19/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData
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
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "alarm_clock_2015.mp3"))
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: type)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        let timeBefore = Date()
        let time = timeBefore.addingTimeInterval(5*60)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = "HH"
        let hour: String = dateFormatter.string(from: time)
        dateFormatter.dateFormat = "mm"
        let min: String = dateFormatter.string(from: time)
        let identifier = response.notification.request.identifier
        if response.actionIdentifier == "snooze"
        {
            if response.notification.request.content.subtitle == "Once"{
                setNotification(title : "Alarm", subTitle : response.notification.request.content.subtitle, hour : Int(hour)!, minute : Int(min)!, type: false, identifier: identifier)
            }
            if response.notification.request.content.subtitle == "Repeat"{
                setNotification(title : "Alarm", subTitle : response.notification.request.content.subtitle, hour : Int(hour)!, minute : Int(min)!, type: true, identifier: identifier)
            }
            
        }
        else if response.actionIdentifier == "delete"{
            if response.notification.request.content.subtitle == "Once"{
                resetResponseActionOnce(identity : identifier)
            }
            else if response.notification.request.content.subtitle == "Repeat"{
                resetResponseActionRepeat(identity : identifier)
            }
        }
        else
        {
            if response.notification.request.content.subtitle == "Once"{
                resetResponseActionOnce(identity : identifier)
            }
            else if response.notification.request.content.subtitle == "Repeat"{
                resetResponseActionRepeat(identity : identifier)
            }
        }
        completionHandler()
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
}
