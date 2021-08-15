//
//  AuthService.swift
//  chatapp
//
//  Created by dimitris kontos on 13/6/20.
//  Copyright © 2020 dimitris kontos. All rights reserved.
//

import Foundation
import Firebase
import UIKit
struct  RegistrationCrentials {
    let email : String
    let password : String
    let fullname : String
    let username  : String
    let profileImge : UIImage

}
struct AuthService {
    static let shared = AuthService()
    
    
    func  logUserIn(withEmail email: String ,password : String, completion: AuthDataResultCallback?) {
          Auth.auth().signIn(withEmail: email, password: password, completion: completion)
             }
    
    func  createUser(credentials: RegistrationCrentials, completion:  ((Error?) -> Void)?) {
        guard let  imageData = credentials.profileImge.jpegData(compressionQuality: 0.3) else { return}
               let filename = NSUUID().uuidString
               let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
               
               ref.putData(imageData, metadata: nil) { (meta, error)  in
               
                   if  let error = error {
                  
                   completion!(error)
                       return
                   }
                   ref.downloadURL { (url, error) in
                       guard let profileimageURL = url?.absoluteString else {return}
                       
                       
                       
                    Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result,  error) in
                           if  let error = error {
                                    
                                    completion!(error)
                                         return
                                     }
                           guard let uid = result?.user.uid else {return}
                        let data = ["email": credentials.email,
                                    "fullname": credentials.fullname,
                                       "profileImageUrl": profileimageURL,
                                       "username": credentials.username] as [String: Any]
                        
                        
                        Firestore.firestore().collection("users").document(uid).setData(data,completion: completion )
                 
                    }
                   }
        
    }
    
}

}
