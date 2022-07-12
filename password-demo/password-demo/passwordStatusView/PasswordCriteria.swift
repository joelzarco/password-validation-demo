//
//  PasswordCriteria.swift
//  password-demo
//
//  Created by Johel Zarco on 11/07/22.
//

import Foundation

struct PasswordCriteria{
    // check for lenght
    static func lengthCriteriaMet(_ text : String) -> Bool {
        return text.count >= 8 && text.count <= 32
    }
    // check for no whitespaces
    static func noSpaceCriteriaMet(_ text : String) -> Bool{
        // if no white spaces equals to nill, return true
        return text.rangeOfCharacter(from: NSCharacterSet.whitespaces) == nil
    }
    // check previous funcz to validate first criteria
    static func lengthAndNoSpaceMet(_ text : String) -> Bool{
        // booth need to be true
        return lengthCriteriaMet(text) && noSpaceCriteriaMet(text)
    }
    // uppercase regex
    static func uppercaseMet(_ text : String) -> Bool{
        return text.range(of: "[A-Z]+", options: .regularExpression) != nil
    }
    // lowercase regex
    static func lowercaseMet(_ text : String) -> Bool{
        return text.range(of: "[a-z]+", options: .regularExpression) != nil
    }
    // digit regex
    static func digitMet(_ text : String) -> Bool{
        return text.range(of: "[0-9]+", options: .regularExpression) != nil
    }
    static func specialMet(_ text : String) -> Bool{
        return text.range(of: ".*[^A-Za-z0-9].*", options: .regularExpression) != nil
    }
}
