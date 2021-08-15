//
//  inputContainerView.swift
//  chatapp
//
//  Created by dimitris kontos on 27/5/20.
//  Copyright © 2020 dimitris kontos. All rights reserved.
//

import UIKit
class inputContainerView: UIView {
    init (image : UIImage?, textfield: UITextField){
        super.init(frame: .zero)
        setHeight(height: 50)
        
        let iv = UIImageView()
        iv.image = image
        iv.tintColor = .white
        iv.alpha  = 0.9
        
        addSubview(iv)
           iv.centerY(inView: self)
           iv.anchor( left: leftAnchor, paddingRight: 8 )
           iv.setDimensions(height: 20, width: 20)
        
       addSubview(textfield)
        textfield.centerY(inView: self)
        textfield.anchor(left: iv.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 8, paddingBottom: 4)
           setHeight(height: 5)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        addSubview(dividerView)
        dividerView.anchor(left: leftAnchor ,bottom: bottomAnchor, right: rightAnchor, paddingLeft: 8,height: 0.75)

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
