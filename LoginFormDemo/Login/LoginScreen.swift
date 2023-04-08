//
//  LoginScreen.swift
//  LoginFormDemo
//
//  Created by Satish Vekariya on 07/04/2023.
//

import SwiftUI

struct LoginScreen: View {
    @StateObject var screenModel = LoginScreenModel()
    
    var body: some View {
        ScrollView {
            LoginFormView { action in
                switch action {
                case .login(let email, let pass):
                    Task {
                        await screenModel.performLogIn(email: email, password: pass)
                    }
                case .forgotPassword:
                    break
                }
            }
            .loginFormInfoBinding($screenModel.errorMessage)
            .setLoginButtonLoading($screenModel.isLoading)
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
