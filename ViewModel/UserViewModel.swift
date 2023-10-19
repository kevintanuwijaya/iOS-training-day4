//
//  UserViewModel.swift
//  MyProject2
//
//  Created by P090MMCTSE015 on 19/10/23.
//

import Foundation

class UserViewModel: NSObject {
    private var coreDataService: CoreDataService!
    private(set) var userData: [UserModel] = [] {
        didSet{
            self.bindDataToVC()
        }
    }
    
    
    var bindDataToVC: () -> () = {}
    
    override init() {
        super.init()
        coreDataService = CoreDataService()
    }
    
    func fetchData() {
        coreDataService.read { users in
            print(users)
            self.userData = users
        } onError: { error in
            print(error!)
        }

    }
    
    func updateData(id: Int, name: String, salary: Int){
        coreDataService.update(id: id, name: name, salary: salary) {
            
        } onError: { error in
            print(error!)
        }

    }
    
    func createData(id: Int, name: String, salary: Int) {
        coreDataService.create(id: id, name: name, salary: salary) {
            
        } onError: { error in
            print(error!)
        }

    }
    
    func deleteData(id: Int){
        coreDataService.delete(id: id) {
            
        } onError: { error in
            print(error!)
        }

    }
}
