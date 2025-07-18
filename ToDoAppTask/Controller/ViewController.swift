//
//  ViewController.swift
//  ToDoAppTask
//
//  Created by Aya Salman on 18/07/2025.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tasksTableView: UITableView!
    
    var tasksArray : [TaskModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tasksArray = StorageManager.getData()
        tasksTableView.dataSource = self
        tasksTableView.delegate =  self
        tasksTableView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTasks), name: NSNotification.Name("NewTaskAdded"), object: nil)

        tasksTableView.rowHeight = 100

    }
    @objc func reloadTasks() {
        tasksArray = StorageManager.getData()
        tasksTableView.reloadData()
    }

}
extension ViewController : UITableViewDelegate,UITableViewDataSource {    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        
        let titleLabel = cell.viewWithTag(1) as? UILabel
        let detailsLabel = cell.viewWithTag(2) as? UILabel
        
        let task = tasksArray[indexPath.row]
        
        if task.isDone {
                let attributedTitle = NSAttributedString(
                    string: task.title,
                    attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
                )
                titleLabel?.attributedText = attributedTitle
            } else {
                titleLabel?.text = task.title
            }
        
        detailsLabel?.text = task.details
 
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            
            StorageManager.deleteData(index: indexPath.row)
            
            self.tasksArray.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
        
            completionHandler(true)
        }
        
        
        deleteAction.backgroundColor = UIColor.red
        
    
        let task = tasksArray[indexPath.row]
            
        let toggleAction = UIContextualAction(style: .normal, title: task.isDone ? "Undo":"Done") { action, view, completionHandler in
                
                self.tasksArray[indexPath.row].isDone.toggle()
                
                let updatedTask = self.tasksArray[indexPath.row]
                StorageManager.updateData(todo: updatedTask, index: indexPath.row)
                
                tableView.reloadRows(at: [indexPath], with: .automatic)
                
                completionHandler(true)
            }
        toggleAction.backgroundColor = task.isDone ? UIColor.gray : UIColor.systemBlue
        
        return UISwipeActionsConfiguration(actions: [deleteAction,toggleAction])
            
    }
 
    
}

