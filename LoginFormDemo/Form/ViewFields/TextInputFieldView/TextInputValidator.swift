//
//  TextInputValidator.swift
//  LoginFormDemo
//
//  Created by Satish Vekariya on 09/04/2023.
//

import Foundation

protocol TextValidator {
    func validate(input text: String?) -> TextValidationResult
}

enum TextValidationResult {
    case valid
    case invalid(reason: String?)
}

struct TextInputValidator: TextValidator {
    
    let validators: [TextValidator]
    
    func validate(input text: String?) -> TextValidationResult {
        for validator in validators {
            let result = validator.validate(input: text)
            if case .invalid = result {
                return result
            }
        }
        return .valid
    }
}
