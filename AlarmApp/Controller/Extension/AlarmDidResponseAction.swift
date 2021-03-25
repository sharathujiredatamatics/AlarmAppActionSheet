//
//  AlarmDidResponseAction.swift
//  AlarmApp
//
//  Created by Datamatics on 22/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
// AlarmViewController to manage notification response.
extension AlarmViewController{
    // Function to off alarm from response.
    func resetResponseActionOnce(identity : String){
        let context = app.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName : "Alarm")
        fetchRequest.predicate = NSPredicate(format: "identifier = %@",identity)
        do
        {
            let alarm = try context.fetch(fetchRequest)
            let objectUpdate = alarm[0] as! NSManagedObject
            objectUpdate.setValue(false, forKey: "state")
            do{
                try context.save()
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identity])
                UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [identity])
                StorageClass.shared.fetchAlarmData()
                alarmTableView.reloadData()
            }
            catch
            {
                let Fetcherror = error as NSError
                print("error", Fetcherror.localizedDescription)
            }
        }
        catch{
            print(error)
        }
    }
    // Function to off snooze alarm from response.
    func resetResponseActionRepeat(identity : String){
        let context = app.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName : "Alarm")
        fetchRequest.predicate = NSPredicate(format: "identifier = %@",identity)
        do
        {
            let alarm = try context.fetch(fetchRequest)
            let objectUpdate = alarm[0] as! NSManagedObject
            objectUpdate.setValue(true, forKey: "state")
            let time = objectUpdate.value(forKey: "time") as! Date
            //            let time = StorageClass.shared.alramData[indexPath.row].time
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.dateFormat = "HH"
            let hour: String = dateFormatter.string(from: time)
            dateFormatter.dateFormat = "mm"
            let min: String = dateFormatter.string(from: time)
            do{
                try context.save()
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identity])
                UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [identity])
                setNotification(title : "Alarm", subTitle : "Repeat", hour : Int(hour)!, minute : Int(min)!, type: true, identifier: identity)
            }
            catch
            {
                let Fetcherror = error as NSError
                print("error", Fetcherror.localizedDescription)
            }
        }
        catch{
            print(error)
        }
    }
}
