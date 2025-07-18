//
//  AddTaskViewController.swift
//  ToDoAppTask
//
//  Created by Aya Salman on 18/07/2025.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var detailsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty else {
                    showAlert(message: "Please enter a title")
                    return
                }
                
                let details = detailsTextView.text ?? ""
                
                // إنشاء وحفظ المهمة في Core Data
                let newTask = TaskModel(title: title, details: details, isDone: false)
                StorageManager.storeData(todo: newTask)
                
                // نبعث Notification علشان الـ TableView يتحدث
                NotificationCenter.default.post(name: NSNotification.Name("NewTaskAdded"), object: nil)
                
                // نظهر رسالة
                showAlert(message: "Task Added")
    }
    private func showAlert(message: String) {
           let alert = UIAlertController(title: "Done", message: message, preferredStyle: .alert)
           present(alert, animated: true, completion: nil)
           
           let closeAction = UIAlertAction(title: "OK", style: .default) { _ in
               // نرجع تلقائيًا للـ ViewController
               self.navigationController?.popViewController(animated: true)
           }
           alert.addAction(closeAction)
       }
    


}
