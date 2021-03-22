//
//  ViewController.swift
//  AlarmApp
//
//  Created by Sharath on 19/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
import UserNotifications
class AlarmViewController: UIViewController {
    @IBOutlet weak var alarmTableView: UITableView!
    let datePickerOutlet: UIDatePicker = UIDatePicker()
    let managerContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
        UNUserNotificationCenter.current().delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        StorageClass.shared.fetchAlarmData()
        print(StorageClass.shared.alramData.count)
    }
    @IBAction func setAlarm(_ sender: UIButton) {
        setAlarmButtonAction()
    }
    
}

