//
//  ConversationController.swift
//  chatapp
//
//  Created by dimitris kontos on 19/5/20.
//  Copyright © 2020 dimitris kontos. All rights reserved.
//

import UIKit
import  Firebase
private let reuseIdentifier = "ConversationCell"


class ConversationController: UIViewController {
    
    //Mark
    private let tableView = UITableView()
    
    private let newMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"),for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.addTarget(self, action: #selector(showNewMessage), for: .touchUpInside)
        button.imageView?.setDimensions(height: 24, width: 24)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
            view.backgroundColor = .red
    configateUI()
    }
    
    @objc func showNewMessage(){
        let controller  = NewMessageController()
        controller.delegate = self
        let nav  = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    @objc func showProfile (){
        logout()
    }
    func authenticateUser(){
        if Auth.auth().currentUser?.uid ==  nil{
            presentLoginScreen()
        
        }else{
            print("debug user is  login\(Auth.auth().currentUser?.uid)")
        }
    }
    func logout()  {
        do {
            try Auth.auth().signOut()
            presentLoginScreen()
        }catch{
            print ("debug error sing out ")
        }
    }
    func presentLoginScreen(){
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
        
    }
    func configateUI(){
        view.backgroundColor = .white
        confifureNavigatiorBar(withTitle: "Messages", prefersLargeTitles: true)
   
        configureTableView()
        let  image = UIImage(systemName: "person.circle.fill")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
        
        view.addSubview(newMessageButton)
        newMessageButton.setDimensions(height: 56, width: 56)
        newMessageButton.layer.cornerRadius = 56 / 2
        
        newMessageButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 16,paddingRight: 24 )
    }
    
    func configureTableView(){
        tableView.backgroundColor = .white
        
        tableView.rowHeight =  80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView() //to pannw dinei osa cel exw
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.frame  = view.frame
        
        
    }
 
}

extension ConversationController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
  
        
        cell.textLabel?.text  = "Text Cell "
    
        
        return cell

    }
    
    
    
}

extension ConversationController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
extension ConversationController: NewMessageControllerDelegate{
    func controller(_ controller: NewMessageController, wantsToStartChatWith user: User) {
        controller.dismiss(animated: true, completion: nil)
        let chat = ChatController(user: user)
        navigationController?.pushViewController(chat, animated: true)
        print("debug  \(user.username)")
    }
    
        
    }

