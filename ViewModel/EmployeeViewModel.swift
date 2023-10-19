//
//  EmployeeViewModel.swift
//  MyProject2
//
//  Created by P090MMCTSE015 on 19/10/23.
//

import Foundation

class EmployeeViewModel: NSObject {
    private var apiService: APIService!
    private(set) var employeeData: [Employee] = [] {
        didSet{
            self.bindDataToVC()
        }
    }
    
    
    var bindDataToVC: () -> () = {}
    
    override init() {
        super.init()
        apiService = APIService()
    }
    
    func fetchData(){
        apiService.fetchEmployees { employees in
            self.employeeData = employees
        } onError: { error in
            print(error!)
        }

    }
}
