//
//  ViewController.swift
//  MyProject2
//
//  Created by P090MMCTSE015 on 18/10/23.
//

import UIKit
import Alamofire



class ViewController: UIViewController {
    
    private let employeeCell = "EmployeeCell"
    
    
    var employees: [Employee] = []

    @IBOutlet weak var employeeTableView: UITableView!
    
    var employeeViewModel: EmployeeViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeTableView.register(
            UINib(
                nibName: "EmployeeTableViewCell", 
                bundle: nil
            
            )
            , forCellReuseIdentifier: employeeCell
        )
        
        employeeTableView.dataSource = self
        employeeTableView.delegate = self
        
        employeeTableView.rowHeight = UITableView.automaticDimension
        employeeTableView.estimatedRowHeight = 216
        
        employeeViewModel = EmployeeViewModel()
        employeeViewModel.bindDataToVC = {
            self.employeeTableView.reloadData()
        }
        employeeViewModel.fetchData()
        
//        getEmployee()
    }
    
//    func getEmployee() {
//        guard let url = URL(string: "https://dummy.restapiexample.com/api/v1/employees") else {return}
//        let urlConv :URLConvertible = url
//        
//        AF.request(urlConv, method: .get).response { response in
//            if let responseData = response.data {
//                do {
//                    let result = try JSONDecoder().decode(EmployeeData.self, from: responseData)
//                    debugPrint(result)
//                    
//                    DispatchQueue.main.async { [weak self] in
//                        self?.employees = result.data!
//                        self?.employeeTableView.reloadData()
//                    }
//                    
//                } catch let jsonErr {
//                    debugPrint(jsonErr)
//                }
//            }
//            
//        }
//    }
}



extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeViewModel.employeeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: employeeCell, for: indexPath) as! EmployeeTableViewCell
        
        let cellData = employeeViewModel.employeeData
        
        cell.setValue(name: cellData[indexPath.row].nama, age: cellData[indexPath.row].age, salary: cellData[indexPath.row].salary)
        
        return cell
    }
}

