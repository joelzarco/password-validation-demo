//
//  ViewController.swift
//  password-demo
//
//  Created by Johel Zarco on 30/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    let newPasswordTextField = PasswordTextField(placeHolderText: "New password")
    let stackView = UIStackView()
//    let criteriaView = PasswordCriteriaView(text: "upperCase letter (A-Z)")
    let statusView = PasswordStatusView()
    let confirmPassword = PasswordTextField(placeHolderText: "Re-enter new password")
    let resetButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setup()
        hideKeyboard()
    }
}

extension ViewController{
    
    func setup(){
        // in order to dissmiss keyboard when user taps in view
        setupDismissKeyboardGesture()
    }
    
    private func setupDismissKeyboardGesture(){
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    @objc func viewTapped(_ recognizer : UITapGestureRecognizer){
        view.endEditing(true) // force to resign first responder
    }
    
    // brute force approach, move view's origin when keyboard is detected
    private func hideKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func style(){
        // register to receive from text field
        newPasswordTextField.delegate = self
        
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPassword.translatesAutoresizingMaskIntoConstraints = false
        
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.layer.cornerRadius = 10
        statusView.clipsToBounds = true

        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20

        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset password", for: [])
//        resetButton.addTarget(self, action: #selector(resetPasswordButton), for: .primaryActionTriggered)
    }
    
    func layout(){
        //
        stackView.addArrangedSubview(newPasswordTextField)
        stackView.addArrangedSubview(statusView)
        stackView.addArrangedSubview(confirmPassword)
        stackView.addArrangedSubview(resetButton)

        view.addSubview(stackView)
        
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2).isActive = true

    }
}

extension ViewController : PasswordDelegate{
    // delegate implementation
    func editingChanged(_ sender: PasswordTextField) {// to differentiate between text fields
        if sender === newPasswordTextField{
            statusView.updateDisplay(sender.textField.text ?? "")
        }
    }
    
    func editingDidEnd(_ sender: PasswordTextField) {
        print("editingDidEnd!")
        print(sender.textField.text!)
    }
}

// MARK: KEYBOARD
extension ViewController{
    @objc func keyboardWillShow(sender : NSNotification){
        view.frame.origin.y = view.frame.origin.y - 200 // -200 is movin' up view
    }
    
    @objc func keyboardWillHide(sender : NSNotification){
        view.frame.origin.y = 0
    }
}
