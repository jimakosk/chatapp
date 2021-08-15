//
//  LoginController.swift
//  chatapp
//
//  Created by dimitris kontos on 25/5/20.
//  Copyright © 2020 dimitris kontos. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD
class LoginController: UIViewController {
    
    private var viewModel = LoginViewModel()
    
    private let iconImage : UIImageView = {
       let iv = UIImageView()

    iv.image  = UIImage(systemName: "bubble.right")
        iv.tintColor = .white
        return iv
    }()
    private lazy var emailContainerView: UIView = {
          let containerView = inputContainerView(image: UIImage(systemName: "envelope"), textfield: emailTextField)
 
        
        return containerView
    }()
    private lazy var passwordContainerView: inputContainerView = {
        let containerView = inputContainerView(image: UIImage(systemName: "lock"), textfield: passwordTextField)
        return containerView
       }()
    private let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50)
       
              button.isEnabled = false
              button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    private let emailTextField = CustomtextField( placeholder: "Email")
    
    private let passwordTextField: CustomtextField = {
          let tf = CustomtextField( placeholder: "Password")
          tf.isSecureTextEntry = true
          return tf
      }()
    private let dontHaveAccount: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle  = NSMutableAttributedString(string: "Don t have an account???",
                                                    attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: "Sing Up", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
         button.addTarget(self, action: #selector(handleShowSingUp), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func handleShowSingUp(){
        print("Show handleShowSingUp")
        let controller  = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
        
    }
    @objc func handleLogin ()
    {
        guard let  email = emailTextField.text else { return}
        guard let  password = passwordTextField.text else { return}
       
        showLoader(true,withText: "Logging in")
        
        
        AuthService.shared.logUserIn(withEmail: email,password : password) {  result, error in
                    if  let error = error {
                    
                         print("debug failed to upload0!!!\(error.localizedDescription)")
                        self.showLoader(false)
                        return
                     }
                  self.showLoader(false)
                self.dismiss(animated: true, completion: nil)

  
        }
    }
    @objc func textDidChange(sender : UITextField){
        if sender == emailTextField{
            viewModel.email = sender.text
        }else {
            viewModel.password = sender.text
        }
        checkFormStatus()
    }
    
    func checkFormStatus()  {
        if viewModel.formIsValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
        else
        {
            loginButton.isEnabled = false
                       loginButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            
        }
        
    }
    
    func configureUI( ){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
     configureGradintienLayer()
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor,  paddingTop: 32)
        iconImage.setDimensions(height: 60    , width: 60)

        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView,loginButton])

        stack.axis = .vertical
        stack.spacing = 50
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor , right: view.rightAnchor, paddingTop: 32 ,paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccount)
        dontHaveAccount.anchor(left : view.leftAnchor, bottom:  view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingLeft: 32, paddingBottom: 32,paddingRight: 32)
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    
    }
    
 



}

