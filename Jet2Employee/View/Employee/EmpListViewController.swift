//
//  MoviesViewController.swift
//  Jet2Employee
//
//  Created by Vikram on 02/03/20.
//  Copyright © 2020 Vikram. All rights reserved.
//

import UIKit

class EmpListViewController: UIViewController, ViewModelDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = EmpViewModel()
    var arrEmpList = [ItemObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        if Connectivity.isConnectedToInternet {
            viewModel.getEmployee(type: .Employee)
        } else {
            self.retrieveOfflineData()
        }
        
    }
    
    func reloadTable(type: Int) {
        DispatchQueue.main.sync {
            if viewModel.dataItems.count > 0 {
                if let dataItems = viewModel.dataItems.first {
                    self.arrEmpList = dataItems.results
                }
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func sorList(_ sender: Any) {
        let alert = UIAlertController(title: "Sort List", message: "Please Select an Option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "By Name", style: .default , handler:{ (UIAlertAction)in
            self.arrEmpList.sort { $0.employee_name < $1.employee_name }
                self.tableView.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "By Age", style: .default , handler:{ (UIAlertAction)in
           self.arrEmpList.sort { $0.employee_age < $1.employee_age }
               self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))

        self.present(alert, animated: true, completion: {
            
        })
    }
    
    func retrieveOfflineData() {
        // Get the url of Persons.json in document directory
        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentsDirectoryUrl.appendingPathComponent("Employee.json")
        // Read data from .json file and transform data into an array
        do {
            let data = try Data(contentsOf: fileUrl, options: [])
            guard let arrEmp = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else { return }
            for (_, val) in arrEmp.enumerated() {
                guard let emp = ItemObject(json: val) else { return  }
                self.arrEmpList.append(emp)
            }
            self.tableView.reloadData()
        } catch {
            print(error)
            let alert = UIAlertController(title: "", message: error.localizedDescription + "\n or Please connect internet" , preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
}

extension EmpListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmpListCell.stringRepresentation) as! EmpListCell
        if self.arrEmpList.count > 0 {
                let empData = self.arrEmpList[indexPath.row]
                cell.imgProfile.image = UIImage(named: "ic_profile_1")
                cell.lblName.text = empData.employee_name
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "EmpDetailsViewController") as! EmpDetailsViewController
            let empData = self.arrEmpList[indexPath.row]
            detailVC.emoInfo = empData
            self.navigationController?.pushViewController(detailVC, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrEmpList.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.arrEmpList.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    
   
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
}
