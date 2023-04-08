//
//  LoginFormView.swift
//  LoginFormDemo
//
//  Created by Satish Vekariya on 07/04/2023.
//

import SwiftUI

struct LoginFormView: View {
    typealias FormAction = (Action) -> Void
    let action: FormAction
    
    init(_ action: @escaping FormAction) {
        self.action = action
    }
    
    @State private var collector = TextInputFieldDataCollector(
        validator: [
            Ids.email.rawValue: .init(validators: [EmailTextValidator()]),
            Ids.password.rawValue: .init(validators: [LoginPasswordValidator()])
        ]
    )
    
    var body: some View {
        Group {
            ImageFieldView()
            Group {
                FormSpacer(16)
                InfoErrorMessageField(id: Ids.infoMessage.rawValue)
            }
            Group {
                FormSpacer(16)
                FieldLabelView(title: "Email")
                FormSpacer(8)
                TextInputFieldView(id: Ids.email.rawValue)
            }
            Group {
                FormSpacer(28)
                FieldLabelView(title: "Password")
                FormSpacer(8)
                TextInputFieldView(id: Ids.password.rawValue, isSecure: true)
            }
            Group {
                FormSpacer(44)
                PrimaryButtonFieldView(id: Ids.login.rawValue, text: "LOG IN")
                SecondaryButtonFieldView(id: Ids.forgotPassword.rawValue, text: "Forgot password?")
            }
        }
        .textInputFieldDataCollector(collector)
        .primaryButtonFieldAction(Ids.login.rawValue) {
            /// 1. Dismiss keyboard
            TextInputFieldView.resignKeyboardFocus()
            TextInputFieldView.forceTextInputValidation()
            
            let email = collector.getValidatedResult(id: Ids.email.rawValue)
            let pass = collector.getValidatedResult(id: Ids.password.rawValue)
            
            /// 2. Notify parent
            if let email, let pass {
                action(.login(email: email, pass: pass))
            }
        }
        .secondaryButtonFieldAction(Ids.forgotPassword.rawValue) {
            TextInputFieldView.resignKeyboardFocus()
            action(.forgotPassword)
        }
    }
}

extension LoginFormView {
    enum Ids: String {
        case infoMessage
        case email
        case password
        case login
        case forgotPassword
    }
    
    enum Action {
        case login(email: String, pass: String)
        case forgotPassword
    }
}

struct LoginFormView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            LoginFormView { _ in
            }
        }
    }
}
