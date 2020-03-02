//
//  MoviesRepository.swift
//  Jet2Employee
//
//  Created by Vikram on 01/03/20.
//  Copyright © 2020 Vikram. All rights reserved.
//

import Foundation

enum  ItemDataResponse {
    case success(result: ItemsObjectList)
    case failure
}

class EmpRepsository: BaseService {
    
    func getEmployee(listType: ListType, page:Int, completion: @escaping (ItemDataResponse) -> Void ) {
        let endPoint = setEndPoint(type: listType)
        super.callEndPoint(endPoint:endPoint.rawValue) { [weak self] (response) in
            guard let strongSelf = self else { return }
            switch response {
            case .success(let result):
                strongSelf.parseResult(result: result, completion: completion)
                break
            default:
                completion(.failure)
                break
            }
            
        }
    }
    
    private func parseResult(result: JsonDictionay,completion: @escaping (ItemDataResponse) -> Void) {
        
        guard let data = ItemsObjectList(json: result) else {
            completion(.failure)
            return
        }
        let arrData = data.results
        saveToJsonFile(data: arrData)
        completion(.success(result: data))
    }
    
    private func setEndPoint(type: ListType) -> EmpEndPoint {
        var endPoint: EmpEndPoint
        switch type {
        case .Employee:
            endPoint = .getEmployees
        
        }
        return endPoint
    }
    
    func getDictFromItemObject(data : ItemObject) -> Dictionary<String, Any> {
        var dict = [String : Any] ()
        dict["id"] = data.id
        dict["employee_name"] = data.employee_name
        dict["employee_salary"] = data.employee_salary
        dict["employee_age"] = data.employee_age
        dict["profile_image"] = data.profile_image
        return dict
    }
    func saveToJsonFile(data: [ItemObject]) {
        // Get the url of Persons.json in document directory
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent("Employee.json")
        var arrData = [[String : Any]]()
        for (_,val) in data.enumerated() {
            let dict = self.getDictFromItemObject(data: val)
            arrData.append(dict)
        }
        // Transform array into data and save it into file
        do {
            let data = try JSONSerialization.data(withJSONObject: arrData, options: [])
            try data.write(to: fileUrl, options: [])
        } catch {
            print(error)
        }
    }
    
    
}
