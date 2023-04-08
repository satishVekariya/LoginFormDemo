//
//  LoginPasswordValidator.swift
//  LoginFormDemo
//
//  Created by Satish Vekariya on 09/04/2023.
//

import Foundation

struct LoginPasswordValidator: TextValidator {
    func validate(input text: String?) -> TextValidationResult {
        if text == nil || text!.isEmpty {
            return .invalid(reason: "Please enter a valid password")
        }
        return .valid
    }
}
