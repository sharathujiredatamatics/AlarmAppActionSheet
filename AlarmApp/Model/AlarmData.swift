//
//  AlarmData.swift
//  AlarmApp
//
//  Created by Datamatics on 19/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
import CoreData
struct AlarmData {
    var time: Date
    var type : Bool
    var state : Bool
    var identifier : String
    init?(time : Date, type : Bool, state: Bool, identifier : String) {
        self.time = time
        self.type = type
        self.state = state
        self.identifier = identifier
    }
}

class StorageClass{
    static let shared = StorageClass()
    init() {
    }
    var time = Date()
    var type = Bool()
    var state = Bool()
    var identifier = Int()
    var snoozeidentifier = Int()
    var alramData = [AlarmData]()
    var alarmCoreData = [NSManagedObject]()
    var alarmSnoozeData = [NSManagedObject]()
    let managerContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func fetchAlarmData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Alarm")
        do {
            let results = try managerContext.fetch(request)
            alarmCoreData = results as! [NSManagedObject]
            identifier = alarmCoreData.count
            // clean up of array to avoid doubled data
            self.alramData.removeAll()
            // Retrieving data 1 by 1
            for alarm in alarmCoreData {
                // Append data to arrays
                let time = alarm.value(forKey: "time")
                let type = alarm.value(forKey: "type")
                let state = alarm.value(forKey: "state")
                let identity = alarm.value(forKey : "identifier")
                let newAlram = AlarmData(time: time as! Date, type: type as! Bool, state: state as! Bool, identifier: identity as! String)
                self.alramData.append(newAlram!)
            }
        }catch {
            print("Caught an error: \(error)")
        }
        
    }
    
}
