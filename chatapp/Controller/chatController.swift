//
//  chatController.swift
//  chatapp
//
//  Created by dimitris kontos on 26/6/20.
//  Copyright © 2020 dimitris kontos. All rights reserved.
//

import UIKit



private let  reuseIdentifier  =  "MessageCell"

class ChatController: UICollectionViewController{
   

    private let user: User
    private var messages = [Message]()
    var fromCurretUser = false
    
    private lazy var  customInputView : CustominputAccessView = {
        let iv  = CustominputAccessView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
        iv.delegate = self 
        return iv
    }( )
    
    
    init (user: User){
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override var inputAccessoryView: UIView?{
        get { return customInputView }
    }
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    func configureUI(){
        collectionView.backgroundColor = .white
        confifureNavigatiorBar(withTitle: user.username, prefersLargeTitles: false)
        
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true

    }
}
extension ChatController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        cell.message = messages[indexPath.row]
        return cell
    }
}

extension ChatController : UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
}
extension ChatController : CustomInputAccessViewDelegate {
    func inputView(_ inputView: CustominputAccessView, wantsToSend message: String) {
        
     inputView.messageInputTextView.text = nil

        
 /*       Service.uploadMessage(message, to: user) {
            error in
            if let error = error{
                print("debu")
        return
            }*/
             inputView.messageInputTextView.text = nil
        }
    }
//}
