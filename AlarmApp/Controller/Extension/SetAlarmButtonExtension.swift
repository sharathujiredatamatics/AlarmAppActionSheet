//
//  AddSetViewControllerExtension.swift
//  GoogleNotification
//
//  Created by Datamatics on 19/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
extension AlarmViewController{
    func setAlarmButtonAction(){
        datePickerOutlet.frame = CGRect(x: 75, y: 15, width: 270, height: 200)
        let alertController = UIAlertController(title: "\n\n\n\n\n\n", message: "\n\n\n\n\n\n", preferredStyle: .actionSheet)
        datePickerOutlet.datePickerMode = UIDatePicker.Mode.time
        let alarmTypeLabel = UILabel(frame:CGRect(x: 120, y: 220, width: 100, height: 20))
        alarmTypeLabel.text = "Repeat :"
        alarmTypeLabel.font.withSize(30)
        let alarmType = UISwitch(frame:CGRect(x: 240, y: 220, width: 0, height: 0))
        alarmType.isOn = false
        alarmType.setOn(false, animated: false)
        alarmType.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
        alertController.view.addSubview(datePickerOutlet)
        alertController.view.addSubview(alarmTypeLabel)
        alertController.view.addSubview(alarmType)
        let selectAction = UIAlertAction(title: "Set Alarm", style: .default, handler: { _ in
            self.saveNotificationButton()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { _ in
            alertController.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    @objc func switchValueDidChange(_ sender: UISwitch!) {
        if (sender.isOn){
            StorageClass.shared.type = true
        }
        else{
            StorageClass.shared.type = false
        }
    }
    func saveNotificationButton(){
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let entity = Alarm(context: context)
        entity.time = datePickerOutlet.date
        entity.type = StorageClass.shared.type
        entity.state = true
        entity.identifier = "Identifier\(StorageClass.shared.identifier)"
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = "HH"
        let hour: String = dateFormatter.string(from: self.datePickerOutlet.date)
        dateFormatter.dateFormat = "mm"
        let min: String = dateFormatter.string(from: self.datePickerOutlet.date)
        var type = String()
        if StorageClass.shared.type == true{
            type = "Repeat"
        }
        else if StorageClass.shared.type == false{
            type = "Once"
        }
        setNotification(title : "Alarm", subTitle : type, hour : Int(hour)!, minute : Int(min)!, type: StorageClass.shared.type, identifier: "Identifier\(StorageClass.shared.identifier)")
        do
        {
            try context.save()
            print("Details Stored Sucessfully")
            
            StorageClass.shared.type = false
            StorageClass.shared.state = false
            StorageClass.shared.identifier = StorageClass.shared.identifier + 1
            StorageClass.shared.fetchAlarmData()
            alarmTableView.reloadData()
        }
        catch
        {
            let Fetcherror = error as NSError
            print("error", Fetcherror.localizedDescription)
        }
    }
}
