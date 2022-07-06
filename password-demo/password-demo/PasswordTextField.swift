//
//  PasswordTextField.swift
//  password-demo
//
//  Created by Johel Zarco on 01/07/22.
//

import Foundation
import UIKit

class PasswordTextField: UIView {
    
    let lockImageView = UIImageView(image: UIImage(systemName: "lock.fill"))
    let textField = UITextField()
    let placeHolderText : String
    let eyeButton = UIButton(type: .custom)
    let dividerView = UIView()
    let errorLabel = UILabel()
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        style()
//        layout()
//    }
    init(placeHolderText : String){
        self.placeHolderText = placeHolderText// called before super.init
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 90)
    }
}

extension PasswordTextField {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemFill
        
        lockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = false // change to true in prod
        textField.placeholder = placeHolderText
//        textField.delegate = self
        textField.keyboardType = .asciiCapable// ascii capable, no emojis :(
        textField.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor : UIColor.secondaryLabel])
        //eye
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash.circle"), for: .selected)
        eyeButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        // dividerView
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .separator
        // errorLabel
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        errorLabel.textColor = .systemPink
        errorLabel.text = "Something went wrong. Your password must meet the requierements below"
        //errorLabel.textAlignment = .center
        //errorLabel.adjustsFontSizeToFitWidth = true// affects accesibility, not recomended
        //errorLabel.minimumScaleFactor = 0.8// if set to zero autolaout will reduce it until all fits
        errorLabel.isHidden = false
        errorLabel.numberOfLines = 0 // multiline
        errorLabel.lineBreakMode = .byWordWrapping
        
    }
    
    func layout() {
        addSubview(lockImageView)
        addSubview(textField)
        addSubview(eyeButton)
        addSubview(dividerView)
        addSubview(errorLabel)
        // lock
        lockImageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
        lockImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        // textField
        textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textField.leadingAnchor.constraint(equalToSystemSpacingAfter: lockImageView.trailingAnchor, multiplier: 1).isActive = true
        // eyeButton
        eyeButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
        eyeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 1).isActive = true
        eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        // CHCR to avoid lock stretching
        lockImageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)// defaultHigh should hugged
        textField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)// defaultLow, can stretch
        eyeButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        // dividerView
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        dividerView.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 1).isActive = true
        dividerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        dividerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        // errorLabel
        errorLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 4).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
// MARK: Actions
extension PasswordTextField{
    
    @objc func togglePasswordView(){
        textField.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
    
}
