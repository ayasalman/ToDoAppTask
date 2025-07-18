//
//  StorageManger.swift
//  ToDoAppTask
//
//  Created by Aya Salman on 18/07/2025.
//

import UIKit
import CoreData

class StorageManager {
    
    // MARK: - Create
    static func storeData(todo: TaskModel) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        guard let taskEntity = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        
        let task = NSManagedObject(entity: taskEntity, insertInto: context)
        task.setValue(todo.title, forKey: "title")
        task.setValue(todo.details, forKey: "details")
        task.setValue(todo.isDone, forKey: "isDone") // أضفنا isDone
        
        do {
            try context.save()
            print("Task saved successfully")
        } catch {
            print("Error saving task: \(error)")
        }
    }
    
    // MARK: - Read
    static func getData() -> [TaskModel] {
        var tasksArray: [TaskModel] = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        do {
            let result = try context.fetch(fetchRequest) as? [NSManagedObject] ?? []
            for managedTask in result {
                let title = managedTask.value(forKey: "title") as? String
                let details = managedTask.value(forKey: "details") as? String
                let isDone = managedTask.value(forKey: "isDone") as? Bool ?? false
                
        
                
                let task = TaskModel(title: title ?? "", details: details ?? "", isDone: isDone)
                tasksArray.append(task)
            }
        } catch {
            print("Error fetching tasks: \(error)")
        }
        return tasksArray
    }
    
    
    // MARK: - Updaate
       
       static func updateData(todo: TaskModel, index: Int) {
           guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else {return}
           
           let context  =  appDelegate.persistentContainer.viewContext
           
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
           
           do {
               let result = try context.fetch(fetchRequest) as? [NSManagedObject]
               
               result?[index].setValue(todo.title, forKey: "title")
               result?[index].setValue(todo.details, forKey: "details")
               
               try context.save()
               
           } catch {
               print("======error======")
           }
           
       }
    
    
    // MARK: - Delete
    static func deleteData(index: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        do {
            let result = try context.fetch(fetchRequest) as? [NSManagedObject]
            if let taskToDelete = result?[index] {
                context.delete(taskToDelete)
                try context.save()
            }
        } catch {
            print("Error deleting task: \(error)")
        }
    }
}
