//
//  Employee.swift
//  MyProject2
//
//  Created by P090MMCTSE015 on 18/10/23.
//

import Foundation

struct Employee: Codable {
    var nama: String
    var age: Int
    var salary: Int
    
    enum CodingKeys: String, CodingKey {
        case nama = "employee_name"
        case age = "employee_age"
        case salary = "employee_salary"
    }
}

struct EmployeeData: Codable {
    var status: String?
    var data: [Employee]?
    var message: String?
}
