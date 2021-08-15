//
//  RegistrationController.swift
//  chatapp
//
//  Created by dimitris kontos on 25/5/20.
//  Copyright © 2020 dimitris kontos. All rights reserved.
//

import UIKit
import Firebase



class RegistrationController: UIViewController {
    
    
    private var viewModel = RegistrationViewModel()
    
    private var  profileImge: UIImage?
    private let plusPhotoButton : UIButton =
    {
        let button  = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo") , for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handlePhoto), for: .touchUpInside)
        button.clipsToBounds = true
        button.imageView?.clipsToBounds = true
        return button
    }()
    private lazy var passwordContainerView: inputContainerView = {
          let containerView = inputContainerView(image: UIImage(systemName: "lock"), textfield: passwordTextField)
          return containerView
         }()
    
    private let passwordTextField: CustomtextField = {
           let tf = CustomtextField( placeholder: "Password")
           tf.isSecureTextEntry = true
           return tf
       }()
    override func viewDidLoad() {
        super.viewDidLoad()
      configureUI()//ftiaxnei to  backgroung color
        
        configureNotificationobserver()
    }
    @objc func handlePhoto(){
    let imagePickerController  = UIImagePickerController()
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
        
    }
       private lazy var emailContainerView: UIView = {
             let containerView = inputContainerView(image: UIImage(systemName: "envelope"), textfield: emailTextField)
    
        
           
           return containerView
       }()
     private lazy var fullnameContainerView: UIView = {
             let containerView = inputContainerView(image: UIImage(systemName: "envelope"), textfield: fullnameTextField)
    
        
           
           return containerView
       }()
     private lazy var usernameContainerView: UIView = {
             let containerView = inputContainerView(image: UIImage(systemName: "envelope"), textfield: usernameTextField)
    
        
           
           return containerView
       }()
    
      private let emailTextField = CustomtextField( placeholder: "Email")
      private let fullnameTextField = CustomtextField( placeholder: "Full Name")
      private let usernameTextField = CustomtextField( placeholder: "Username")
    
    private let singupButton : UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("Sing Up", for: .normal)
         button.layer.cornerRadius = 10
         button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
         button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
         button.setTitleColor(.white, for: .normal)
         button.setHeight(height: 50)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
         return button
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
    @objc func handleShowSingUp()
    {
        navigationController?.popViewController(animated: true)
    }
    @objc func  keyboardWillShow(){
        if view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 88
        }
    }
    @objc func  keyboardWillHide(){
        if view.frame.origin.y != 0 {
                  self.view.frame.origin.y  = 0
              }
    }
    @objc func handleRegistration()
       {
        guard let  email = emailTextField.text else { return}
        guard let  password = passwordTextField.text else { return}
        guard let  fullname = fullnameTextField.text else { return}
        guard let  username = usernameTextField.text?.lowercased() else { return}
        guard let  profileImage =  profileImge else { return}
        let credintial  = RegistrationCrentials(email: email, password: password, fullname: fullname, username: username, profileImge: profileImage)
      
        showLoader(true)
        
        
       
                    
                      
                        
                    
    AuthService.shared.createUser(credentials: credintial) { error in
        if  let error = error {
        
             print("debug failed to upload0!!!\(error.localizedDescription)")
            self.showLoader(false)

            return
         }
            self.showLoader(false)

            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField{
            viewModel.email = sender.text
        }else if sender == passwordTextField{
            viewModel.password = sender.text

        }else if sender == fullnameTextField{
            viewModel.fullname = sender.text

        }else if sender == usernameTextField{
            viewModel.useraname = sender.text

        }
        checkFormStatus()
    }
    
      func checkFormStatus()  {
          if viewModel.formIsValid {
              singupButton.isEnabled = true
              singupButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
          }
          else
          {
              singupButton.isEnabled = false
                         singupButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
              
          }
          
      }
    func configureUI()   {
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
       configureGradintienLayer()
        
         view.addSubview(plusPhotoButton)
         let stack = UIStackView(arrangedSubviews: [emailContainerView,passwordContainerView,fullnameContainerView,usernameContainerView,singupButton])
            view.addSubview(stack)
        
        stack.axis = .vertical
        stack.spacing = 16
    
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor , right: view.rightAnchor, paddingTop: 32 ,paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,  paddingTop: 32)
        plusPhotoButton.setDimensions(height: 200, width: 200)
        
             view.addSubview(dontHaveAccount)
             dontHaveAccount.anchor(left : view.leftAnchor, bottom:  view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingLeft: 32, paddingBottom: 32,paddingRight: 32)
    }
    func configureNotificationobserver()  {
        
             emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
             passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
             fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
             usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}


extension RegistrationController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image  = info[.originalImage ] as? UIImage
        profileImge = image
        plusPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhotoButton.layer.borderColor =  UIColor(white: 1 ,alpha: 0.7).cgColor
        plusPhotoButton.layer.borderWidth = 3.0
        plusPhotoButton.layer.cornerRadius = 200 / 2
        
        
        
        dismiss(animated: true, completion: nil)
        
        
    }
}
