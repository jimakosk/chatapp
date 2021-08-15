
//
//  LoginViewModel.swift
//  chatapp
//
//  Created by dimitris kontos on 4/6/20.
//  Copyright © 2020 dimitris kontos. All rights reserved.
//

import Foundation

struct  LoginViewModel {
    var email : String?
    var password : String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
 
    
}
