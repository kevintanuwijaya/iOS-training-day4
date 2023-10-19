//
//  APIService.swift
//  MyProject2
//
//  Created by P090MMCTSE015 on 19/10/23.
//

import Foundation
import Alamofire

class APIService: NSObject {
    
    func fetchEmployees (
        onSuccess: @escaping ([Employee]) -> Void,
        onError: @escaping (Error?) -> Void
    ) {
        guard let url = URL(string: "https://dummy.restapiexample.com/api/v1/employees") else {return}
        let urlConv :URLConvertible = url
        
        AF.request(urlConv, method: .get).response { response in
            if let responseData = response.data {
                do {
                    let result = try JSONDecoder().decode(EmployeeData.self, from: responseData)
                    
                    DispatchQueue.main.async {
                        onSuccess(result.data ?? [])
                    }
                    
                } catch let jsonErr {
                    onError(jsonErr)
                }
            }
            
        }
    }
}
