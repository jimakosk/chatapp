//
//  MessageCell.swift
//  chatapp
//
//  Created by dimitris kontos on 30/6/20.
//  Copyright © 2020 dimitris kontos. All rights reserved.
//

import UIKit


class MessageCell: UICollectionViewCell {
 
    
    var  message : Message?{
        didSet { configure() }
        
    }
    var bubbleLeftAnchor: NSLayoutConstraint!
        var bubbleRoghtAnchor: NSLayoutConstraint!
    
    private let  profileImageView : UIImageView = {
          let iv =  UIImageView()
          iv.backgroundColor = .lightGray
          iv.contentMode = .scaleAspectFill
          iv.clipsToBounds = true
          return iv
      }()
    private let  textView : UITextView = {
             let tv =  UITextView()
             tv.backgroundColor = .clear
             tv.font    = .systemFont(ofSize: 16)
             tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .white
        tv.text = "Some test message"

             return tv
         }()
    private let  bubbleContainer:  UIView = {
             let view =  UIView()
             view.backgroundColor = .systemBlue
             

             return view
         }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      //  backgroundColor = .red
        
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 8, paddingBottom: -4)
        profileImageView.setDimensions(height: 32, width: 32   )
        profileImageView.layer.cornerRadius = 32 / 2
        
        addSubview(bubbleContainer)
        bubbleContainer.layer.cornerRadius = 12
        bubbleContainer.anchor(top: topAnchor)
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        bubbleLeftAnchor =  bubbleContainer.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12)
        bubbleLeftAnchor.isActive = false
             bubbleRoghtAnchor =  bubbleContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
                bubbleRoghtAnchor.isActive = false
        
        bubbleContainer.addSubview(textView)
        textView.anchor(top: bubbleContainer.topAnchor,left: bubbleContainer.leftAnchor,bottom: bubbleContainer.bottomAnchor ,right: bubbleContainer.rightAnchor,paddingTop: 4,paddingLeft: 12,paddingBottom: 4,paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure()  {
        guard let message = message else { return }
           let viewModel = MessageViewModel(message: message)
            
            
        bubbleContainer.backgroundColor = viewModel.messageBackColor
            
        textView.textColor = viewModel.messageColor
        textView.text = message.text
        
   //     bubbleLeftAnchor.isActive = viewModel.leftAnchorActive
        profileImageView.isHidden = viewModel.shouldHIdeProfileImage
    }
    
}
