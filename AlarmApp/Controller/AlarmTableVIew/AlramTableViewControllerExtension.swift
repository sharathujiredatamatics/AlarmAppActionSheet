//
//  AlramTableViewControllerExtension.swift
//  AlarmApp
//
//  Created by Sharath on 19/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
import UserNotifications
extension AlarmViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StorageClass.shared.alramData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AlarmTableViewCell
        let time = StorageClass.shared.alramData[indexPath.row].time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = "HH"
        let hour: String = dateFormatter.string(from: time)
        let intHour = Int(hour)
        dateFormatter.dateFormat = "mm"
        let min: String = dateFormatter.string(from: time)
        if intHour! >= 12{
            let hourDisplay = intHour! - 12
            cell.alarmTime.text = "\(hourDisplay) : \(min) PM"
        }
        else{
            cell.alarmTime.text = "\(hour) : \(min) AM"
        }
        let type = StorageClass.shared.alramData[indexPath.row].type
        if type == true{
            cell.alarmType.text = "Repeat"
        }
        else if type == false{
            cell.alarmType.text = "Once"
        }
        let state = StorageClass.shared.alramData[indexPath.row].state
        if state == true{
            cell.alarmState.isOn = true
        }
        else if state == false{
            cell.alarmState.isOn = false
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [StorageClass.shared.alramData[indexPath.row].identifier])
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [StorageClass.shared.alramData[indexPath.row].identifier])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == UITableViewCell.EditingStyle.delete {
                // Delete the row from the data source
                managerContext.delete(StorageClass.shared.alarmCoreData[indexPath.row])
                do{
                    try managerContext.save()
                }catch{
                    print("Error :")
                }
                // delete from arrays
                StorageClass.shared.alramData.remove(at: indexPath.row)
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [StorageClass.shared.alramData[indexPath.row].identifier])
                UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [StorageClass.shared.alramData[indexPath.row].identifier])
                // delete row from tableview
                alarmTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
                alarmTableView.reloadData()
        }
    }
    // GestureHandler function to delete the CollectionViewCell and also from coredata and array.
    func gestureHandler(){
        let removeTableViewCell = UITapGestureRecognizer(target: self, action:  #selector(self.handleLongPressCollectionViewCell))
        self.alarmTableView.addGestureRecognizer(removeTableViewCell)
    }
    
    @objc func handleLongPressCollectionViewCell(gesture : UILongPressGestureRecognizer!) {
            if gesture.state != .ended {
                return
            }
        let alertController = UIAlertController(title: "\n", message: nil, preferredStyle: .alert)
        let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            let p = gesture.location(in: self.alarmTableView)
            if let indexPath = self.alarmTableView.indexPathForRow(at: p) {
                // Delete the row from the data source
                self.managerContext.delete(StorageClass.shared.alarmCoreData[indexPath.row])
                do{
                    try self.managerContext.save()
                }catch{
                    print("Error :")
                }
                // delete from arrays
                StorageClass.shared.alramData.remove(at: indexPath.row)
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [StorageClass.shared.alramData[indexPath.row].identifier])
                UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [StorageClass.shared.alramData[indexPath.row].identifier])
                // delete row from tableview
                self.alarmTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
                self.alarmTableView.reloadData()
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }

}
