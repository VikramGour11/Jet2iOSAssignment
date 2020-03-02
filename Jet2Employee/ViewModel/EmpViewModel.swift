//
//  EmpViewModel.swift
//  Jet2Employee
//
//  Created by Vikram on 01/03/20.
//  Copyright © 2020 Vikram. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func reloadTable(type: Int)
}

class EmpViewModel {
    
    var dataItems:[ItemsObjectList] = []
    var repository: EmpRepsository?
    weak var delegate: ViewModelDelegate?
    
    init() {
        repository = EmpRepsository()
    }
    
    func getEmployee(type: ListType) {
        guard let repo = repository else { return }
        
        repo.getEmployee(listType: type, page: 0) { [weak self](response) in
            guard let strongSelf = self else { return }
            switch response {
            case .success(var result):
                result.itemType = type
                print(result)
                strongSelf.dataItems.append(result)
                strongSelf.delegate?.reloadTable(type: strongSelf.dataItems.count - 1)
            case.failure:
                break
            }
        }
    }
}
