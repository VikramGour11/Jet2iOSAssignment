//
//  EmpDetailsViewController.swift
//  Jet2Employee
//
//  Created by Vikram on 02/03/20.
//  Copyright © 2020 Vikram. All rights reserved.
//

import Foundation
import UIKit
class EmpDetailsViewController: UIViewController {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblSalary: UILabel!
    
    var emoInfo : ItemObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI (){
        if let empData = self.emoInfo {
            self.lblName.text = empData.employee_name
            self.lblAge.text = empData.employee_age
            self.lblSalary.text = empData.employee_salary
        }
        
    }
    
}
