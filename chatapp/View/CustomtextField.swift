//
//  ContainerTextField.swift
//  chatapp
//
//  Created by dimitris kontos on 27/5/20.
//  Copyright © 2020 dimitris kontos. All rights reserved.
//

import UIKit

class CustomtextField : UITextField {
    
    init(placeholder: String)  {
        super.init(frame: .zero)
        borderStyle = .none
        font = UIFont.systemFont(ofSize: 16)
        textColor = .white
        keyboardAppearance = .dark
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
