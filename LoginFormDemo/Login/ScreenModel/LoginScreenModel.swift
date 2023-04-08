//
//  LoginScreenModel.swift
//  LoginFormDemo
//
//  Created by Satish Vekariya on 07/04/2023.
//

import Foundation

final class LoginScreenModel: ObservableObject {
    
    @MainActor @Published var errorMessage: String?
    @MainActor @Published var isLoading = false
    
    func performLogIn(email: String, password: String) async {
        await MainActor.run {
            isLoading =  true
            errorMessage = nil // Reset
        }
        
        try? await Task.sleep(for: .seconds(1))
        
        let detailsDoNotMatch = "It looks like your email and/or password do not match. Please try again."
        let accountLocked = "Your Account Is Now Locked\nThis is due to repeated unsuccessful log in attempts. Please try again later."
        
        let errors: [String?] = [detailsDoNotMatch, accountLocked, nil]
        await MainActor.run {
            errorMessage = errors.randomElement()!
            if errorMessage != nil {
                print("Login error: email:\(email), pass: \(password)")
            } else {
                print("Login success: email:\(email), pass: \(password)")
            }
        }
        
        await MainActor.run { isLoading =  false }
    }
}
