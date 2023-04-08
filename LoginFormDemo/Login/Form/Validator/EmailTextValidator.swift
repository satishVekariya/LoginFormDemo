//
//  EmailTextValidator.swift
//  LoginFormDemo
//
//  Created by Satish Vekariya on 09/04/2023.
//

import Foundation

struct EmailTextValidator: TextValidator {
    let regexs: [String]
    
    init(regexs: [String] = [RegxConstant.email]) {
        self.regexs = regexs
    }
    
    func validate(input text: String?) -> TextValidationResult {
        if text == nil || text!.isEmpty {
            return .invalid(reason: "Please enter a valid email")
        }
        for regex in regexs {
            if NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: text) == false {
                return .invalid(reason: "Invalid email format")
            }
        }
        return .valid
    }
}
