//
//  Service.swift
//  chatapp
//
//  Created by dimitris kontos on 23/6/20.
//  Copyright © 2020 dimitris kontos. All rights reserved.
//

import Foundation
import Firebase


struct Service {
    static func fetchUsers(complection: @escaping([User]) -> Void){
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments
            { snapshot , error in snapshot?.documents.forEach({document in
                
                let dictionary = document.data()
                let user  = User(dictionary: dictionary)
                users.append(user)
                complection(users)
                
            })
        }
        
    }
    func uploadMessage(_ message: String, to user: User, completion: ((Error?) -> Void)?) {
        guard let currentId = Auth.auth().currentUser?.uid else { return }
        let data = ["text": message, "fromId": currentId, "toId": user.uid, "timestamp":  Timestamp(date: Date())] as [String: Any]
       COLLECTION_MESSAGES.document(currentId).collection(user.uid).addDocument(data: data){ _ in
        
        COLLECTION_MESSAGES.document(currentId).collection(user.uid).addDocument(data: data, completion: completion)
        }
    }
}
