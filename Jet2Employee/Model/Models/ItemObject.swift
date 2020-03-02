//
//  Item.swift
//  Jet2Employee
//
//  Created by Vikram on 01/03/20.
//  Copyright © 2020 Vikram. All rights reserved.
//

import Foundation


/// Model for objet Employee
struct ItemObject: CreateFromArray{
    
    let id              : String
    let employee_name           : String
    let employee_salary    : String
    let employee_age        : String
    let profile_image    : String
    
    
    
    ///Receive parameters for initializer the struct from api, is called from init JSON
    init(id:String,employee_name:String,employee_salary:String,employee_age:String,profile_image:String) {
        self.id            = id
        self.employee_name         = employee_name
        self.employee_salary  = employee_salary
        self.employee_age      = employee_age
        self.profile_image  = profile_image
    }
    
    /**
     This init receive and validate data from Json, return nil in case the struct not is available, if all data is true  call super init fof the struct
     - Parameter json : Data from Api Rest
     */
    init?(json: JsonDictionay) {
        guard let id            = json["id"] as? String else { return nil }
        let employee_name       = json["employee_name"] as? String ?? ""
        let employee_salary     = json["employee_salary"] as? String  ?? ""
        let employee_age        = json["employee_age"] as? String  ?? ""
        let profile_image       = json["profile_image"] as? String ?? ""
       
        
        self.init(id:id,employee_name:employee_name,employee_salary:employee_salary ,employee_age:employee_age,profile_image:profile_image)
    }
    
    
}
