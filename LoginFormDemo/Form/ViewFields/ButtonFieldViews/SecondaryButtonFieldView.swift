//
//  SecondaryButtonFieldView.swift
//  LoginFormDemo
//
//  Created by Satish Vekariya on 07/04/2023.
//

import SwiftUI

struct SecondaryButtonFieldView: View {
    let id: String, text: String
    
    init(id: String, text: String) {
        self.id = id
        self.text = text
    }
    
    @Environment(\.formButtonFieldCommunicator) var communicator
    
    var body: some View {
        Button(action: onClick) {
            Text(text)
                .font(.system(size: 16, weight: .bold))
                .frame(height: 48)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color("brandRed"))
                .padding(.horizontal, 16)
        }
    }
    
    func onClick() {
        if let actions = communicator[id]?.actions {
            for action in actions {
                action()
            }
        }
    }
}

struct SecondaryButtonFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButtonFieldView(id: "01", text: "LOG IN")
    }
}
