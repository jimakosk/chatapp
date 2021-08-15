//
//  MessageViewModel.swift
//  chatapp
//
//  Created by dimitris kontos on 6/7/20.
//  Copyright © 2020 dimitris kontos. All rights reserved.
//

import UIKit


struct MessageViewModel {
    private let message : Message
    
    
    var messageBackColor : UIColor
    {
        return message.isFromCurrentUser ? .lightGray : .systemRed
    }
    var messageColor : UIColor
    {
        return message.isFromCurrentUser ?  .black : .white
    }
    var shouldHIdeProfileImage : Bool {
        return message.isFromCurrentUser
    }
    
    //var prodileImageUrl : URL? {
      //  guard let user =
    //}
    init(message: Message) {
        self.message = message
    }
    
}
