//
//  NewMessageController.swift
//  chatapp
//
//  Created by dimitris kontos on 19/6/20.
//  Copyright © 2020 dimitris kontos. All rights reserved.
//

import UIKit



private let  reuseIdentifier = "UserCell"

protocol NewMessageControllerDelegate: class  {
    func controller(_  controller : NewMessageController, wantsToStartChatWith user: User  )
    
    
}

class NewMessageController: UITableViewController{
    
    private var users = [User]()
    
    weak var  delegate: NewMessageControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
    }
    
    @objc func handleDismissal(){
        dismiss(animated: true, completion: nil)
    }
    func fetchUsers() {
        Service.fetchUsers {
            users in self.users = users
            self.tableView.reloadData()
        }
    }
        func configureUI(){
    confifureNavigatiorBar(withTitle: "New Messages", prefersLargeTitles: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismissal))
            
            
            tableView.tableFooterView = UIView()
            tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
            tableView.rowHeight = 80
            
    }
    

}
extension NewMessageController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
      }
      
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
          
    
        cell.user = users[indexPath.row]

          
          return cell
    }
}

extension NewMessageController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.controller(self, wantsToStartChatWith: users[indexPath.row])
    }
}
