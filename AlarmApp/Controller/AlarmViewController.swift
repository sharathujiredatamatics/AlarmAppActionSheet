//
//  ViewController.swift
//  AlarmApp
//
//  Created by Datamatics on 19/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData
// AlarmViewController which is the main ViewController for interacting with user inputs and coredata.
class AlarmViewController: UIViewController {
    @IBOutlet weak var alarmTableView: UITableView!
    let datePickerOutlet: UIDatePicker = UIDatePicker()
    var alarmCoreData = [NSManagedObject]()
    let app = UIApplication.shared.delegate as! AppDelegate
    let managerContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
        UNUserNotificationCenter.current().delegate = self
        gestureHandler()
    }
    override func viewWillAppear(_ animated: Bool) {
        StorageClass.shared.fetchAlarmData()
    }
    // Button function to set alarm.
    @IBAction func setAlarm(_ sender: UIButton) {
        setAlarmButtonAction()
    }
    
}

