//
//  ViewController.swift
//  password-demo
//
//  Created by Johel Zarco on 30/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    let newPasswordTextField = PasswordTextField(placeHolderText: "New password")

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
    }
}

extension ViewController{
    
    func style(){
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout(){
        view.addSubview(newPasswordTextField)
        newPasswordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newPasswordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
