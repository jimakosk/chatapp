//
//  RegistrationViewModel.swift
//  chatapp
//
//  Created by dimitris kontos on 6/6/20.
//  Copyright © 2020 dimitris kontos. All rights reserved.
//
import Foundation

protocol AuthenticationProtocol {
    var formIsValid: Bool {get }
}


struct  RegistrationViewModel {
    var email : String?
    var password : String?
    var fullname : String?
    var useraname : String?

    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && useraname?.isEmpty == false
    }
 
    
}
