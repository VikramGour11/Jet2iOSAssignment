//
//  AppConstants.swift
//  Jet2Employee
//
//  Created by Vikram on 01/03/20.
//  Copyright © 2020 Vikram. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
struct AppConstants {
    
    static let protocolo    : String = "http://"
    static let apiVersion   : String = "/api/v1"
    static let domain       : String = "dummy.restapiexample.com"
   
    static let baseUrl      : String = AppConstants.protocolo + AppConstants.domain + AppConstants.apiVersion
     

}

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
