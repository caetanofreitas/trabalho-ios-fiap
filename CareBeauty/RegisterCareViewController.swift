//
//  RegisterCareViewController.swift
//  CareBeauty
//
//  Created by Caetano Freitas on 17/09/23.
//

import UIKit

class RegisterCareViewController: UIViewController {
    
    var care: Care?

    @IBOutlet weak var DpTime: UIDatePicker!
    @IBOutlet weak var TxtDesc: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let care = care{
            TxtDesc.text = care.care_description ?? ""
            DpTime.date = care.care_time ?? Date.init()
        }
    }
    
    @IBAction func handleRegisterCare(_ sender: Any) {
        if care == nil {
            care = Care(context: context)
        }
        care?.care_description = TxtDesc.text ?? ""
        care?.care_time = DpTime.date
        
        do {
            try context.save()
            createAlert(dt: care?.care_time ?? Date.init(), desc: care?.care_description ?? "")
            navigationController?.popViewController(animated: true)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func createAlert(dt: Date, desc: String) {
        let content = UNMutableNotificationContent()
        content.title = "Lembrete"
        content.body = "Realize o cuidado: \(desc)"
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dt)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: desc, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

}
