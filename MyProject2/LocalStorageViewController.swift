//
//  LocalStorageViewController.swift
//  MyProject2
//
//  Created by P090MMCTSE015 on 19/10/23.
//

import UIKit
import CoreData

class LocalStorageViewController: UIViewController {

    private let userCell = "UserCell"
    
    @IBOutlet weak var userViewTable: UITableView!
    
    var userViewModel: UserViewModel!
    
    var users: [UserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userViewTable.register(
            UINib(
                nibName: "UserTableViewCell",
                bundle: nil
            ),
            forCellReuseIdentifier: userCell
        )
        
        userViewTable.dataSource = self
        userViewTable.delegate = self
        
        userViewTable.rowHeight = UITableView.automaticDimension
        userViewTable.estimatedRowHeight = 216
        
        userViewModel = UserViewModel()
        userViewModel.bindDataToVC = {
            self.userViewTable.reloadData()
        }
        self.userViewModel.fetchData()
        self.users = userViewModel.userData

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "New Employee", message: "Fill the form below to add new employee", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { tf in
            tf.placeholder = "id"
        })
        
        alert.addTextField(configurationHandler: { tf in
            tf.placeholder = "Name"
        })
        
        alert.addTextField(configurationHandler: { tf in
            tf.placeholder = "Salary"
        })
        
        alert.addAction(UIAlertAction(title: "Tambah", style: .default, handler: { action in
            if alert.textFields![0].text!.isEmpty || alert.textFields![1].text!.isEmpty || alert.textFields![2].text!.isEmpty{
                let warning = UIAlertController(title: "Warning", message: "Fill all the textfields", preferredStyle: .alert)
                warning.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(warning, animated: true)
            }else{
                
                guard let convertedID = Int(alert.textFields![0].text!) else {
                    let warning = UIAlertController(title: "Warning", message: "ID must be a number", preferredStyle: .alert)
                    warning.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    self.present(warning, animated: true)
                    return
                }
                
                guard let convertedSalary = Int(alert.textFields![2].text!) else {
                    let warning = UIAlertController(title: "Warning", message: "Salary must be a number", preferredStyle: .alert)
                    warning.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    self.present(warning, animated: true)
                    return
                }
                
                self.userViewModel.createData(id: convertedID, name: alert.textFields![1].text!, salary: convertedSalary)
                let success = UIAlertController(title: "Success", message: "Data User Added", preferredStyle: .alert)
                success.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(success, animated: true)
                
                self.userViewModel.fetchData()
                self.users = self.userViewModel.userData
                self.userViewTable.reloadData()
            }
        }))
        
        self.present(alert, animated: true)

    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LocalStorageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: userCell, for: indexPath) as! UserTableViewCell
        
        let cellData = users
        
        cell.setValue(id: cellData[indexPath.row].id, name: cellData[indexPath.row].name, salary: cellData[indexPath.row].salary)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var user = users[indexPath.row]
        
        let alert = UIAlertController(title: "Edit Employee", message: "Edit the form below to edit employee", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { tf in
            tf.placeholder = "id"
            tf.text = String(user.id)
            tf.isUserInteractionEnabled = false
        })
        
        alert.addTextField(configurationHandler: { tf in
            tf.placeholder = "Name"
            tf.text = user.name
        })
        
        alert.addTextField(configurationHandler: { tf in
            tf.placeholder = "Salary"
            tf.text = String(user.salary)
        })
        
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { action in
            if alert.textFields![0].text!.isEmpty || alert.textFields![1].text!.isEmpty || alert.textFields![2].text!.isEmpty{
                let warning = UIAlertController(title: "Warning", message: "Fill all the textfields", preferredStyle: .alert)
                warning.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(warning, animated: true)
            }else{
                
                guard let convertedID = Int(alert.textFields![0].text!) else { 
                    let warning = UIAlertController(title: "Warning", message: "ID must be a number", preferredStyle: .alert)
                    warning.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    self.present(warning, animated: true)
                    return
                }
                
                guard let convertedSalary = Int(alert.textFields![2].text!) else {
                    let warning = UIAlertController(title: "Warning", message: "Salary must be a number", preferredStyle: .alert)
                    warning.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    self.present(warning, animated: true)
                    return
                }
                
                self.userViewModel.updateData(id: convertedID, name: alert.textFields![1].text!, salary: convertedSalary)
                let success = UIAlertController(title: "Success", message: "Data User Edited", preferredStyle: .alert)
                success.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(success, animated: true)
                
                self.userViewModel.fetchData()
                self.users = self.userViewModel.userData
                self.userViewTable.reloadData()
            }
        }))
        
        self.present(alert, animated: true)

        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            print(users[indexPath.row].id)
            self.userViewModel.deleteData(id: users[indexPath.row].id)
            self.userViewModel.fetchData()
            self.users = self.userViewModel.userData
            self.userViewTable.reloadData()
        }
    }
    
}

extension LocalStorageViewController {
    
//    func create(id:Int, name: String) {
//        
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        
//        let managedContext = appDelegate.persistentContainer.viewContext
//        
//        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)
//        
//        let insert = NSManagedObject(entity: userEntity!, insertInto: managedContext)
//        
//        insert.setValue(id, forKey: "id")
//        insert.setValue(name, forKey: "name")
//        
//        do{
//            try managedContext.save()
//        }catch let err {
//            print(err)
//        }
//    }
//    
//    func read() -> [UserModel] {
//        
//        var users = [UserModel]()
//        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        
//        let managedContext = appDelegate.persistentContainer.viewContext
//        
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(
//            entityName: "User"
//        )
//        
//        do{
//            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
//            
//            result.forEach{ user in
//                users.append(
//                    UserModel (
//                        id: user.value(forKey: "id") as! Int,
//                        name: user.value(forKey: "name") as! String
//                    )
//                )
//            }
//            
//        }catch let err {
//            print(err)
//        }
//        
//        return users
//    }
//    
//    func delete(id: Int) {
//        
//        debugPrint(id)
//        
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        
//        let managedContext = appDelegate.persistentContainer.viewContext
//        
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
//        
//        fetchRequest.predicate = NSPredicate(format: "id = %@" , String(id))
//        
//        do{
//            let dataToDelete = try managedContext.fetch(fetchRequest)[0] as! NSManagedObject
//            
//            print(dataToDelete)
//            
//            managedContext.delete(dataToDelete)
//            
//            try managedContext.save()
//        }catch let err {
//            print(err)
//        }
//        
//    }
//    
//    func update(id: Int, name: String){
//        
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        
//        let managedContext = appDelegate.persistentContainer.viewContext
//        
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
//        fetchRequest.predicate = NSPredicate(format: "id = %@" , String(id))
//        
//        do{
//            let fetch = try managedContext.fetch(fetchRequest)
//            let dataToUpdate = fetch[0] as! NSManagedObject
//            dataToUpdate.setValue(id, forKey: "id")
//            dataToUpdate.setValue(name, forKey: "name")
//            
//            try managedContext.save()
//        }catch let err {
//            print(err)
//        }
//        
//    }
}
