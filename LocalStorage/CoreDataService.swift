//
//  CoreDataService.swift
//  MyProject2
//
//  Created by P090MMCTSE015 on 19/10/23.
//

import Foundation
import CoreData
import UIKit

class CoreDataService: NSObject {
    
    func create(
        id:Int,
        name: String,
        salary: Int,
        onSucess: @escaping () -> Void,
        onError: @escaping (Error?) -> Void
    ) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)
        
        let insert = NSManagedObject(entity: userEntity!, insertInto: managedContext)
        
        insert.setValue(id, forKey: "id")
        insert.setValue(name, forKey: "name")
        insert.setValue(salary, forKey: "salary")
        
        do{
            try managedContext.save()
        }catch let err {
            print(err)
        }
    }
    
    func read(
        onSucess: @escaping ([UserModel]) -> Void,
        onError: @escaping (Error?) -> Void
    ){
        
        var users = [UserModel]()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(
            entityName: "User"
        )
        
        do{
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            result.forEach{ user in
                users.append(
                    UserModel (
                        id: user.value(forKey: "id") as! Int,
                        name: user.value(forKey: "name") as! String,
                        salary: user.value(forKey: "salary") as! Int
                    )
                )
            }
            
            print(users)
            
            onSucess(users)
            
        }catch let err {
           onError(err)
        }
    }
    
    func delete(
        id: Int,
        onSucess: @escaping () -> Void,
        onError: @escaping (Error?) -> Void
    ) {
        
        debugPrint(id)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        
        fetchRequest.predicate = NSPredicate(format: "id = %@" , String(id))
        
        do{
            let dataToDelete = try managedContext.fetch(fetchRequest)[0] as! NSManagedObject
            
            print(dataToDelete)
            
            managedContext.delete(dataToDelete)
            
            try managedContext.save()
        }catch let err {
            onError(err)
        }
        
    }
    
    func update(
        id: Int,
        name: String,
        salary: Int,
        onSucess: @escaping () -> Void,
        onError: @escaping (Error?) -> Void
    ){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "id = %@" , String(id))
        
        do{
            let fetch = try managedContext.fetch(fetchRequest)
            let dataToUpdate = fetch[0] as! NSManagedObject
            dataToUpdate.setValue(id, forKey: "id")
            dataToUpdate.setValue(name, forKey: "name")
            dataToUpdate.setValue(salary, forKey: "salary")
            
            print(salary)
            print(dataToUpdate)
            
            try managedContext.save()
        }catch let err {
            onError(err)
        }
        
    }
    
}
