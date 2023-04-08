//
//  LoginFormView+ViewExtension.swift
//  LoginFormDemo
//
//  Created by Satish Vekariya on 08/04/2023.
//

import SwiftUI

extension View {
    func loginFormInfoBinding(_ message: Binding<String?>) -> some View {
        infoErrorMessageFieldData(LoginFormView.Ids.infoMessage.rawValue, message: message)
    }
    
    func setLoginButtonLoading(_ isLoading: Binding<Bool>) -> some View {
        setButtonFieldLoading(LoginFormView.Ids.login.rawValue, isLoading: isLoading)
    }
}
