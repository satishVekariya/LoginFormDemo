//
//  PrimaryButtonFieldView.swift
//  LoginFormDemo
//
//  Created by Satish Vekariya on 07/04/2023.
//

import SwiftUI

struct PrimaryButtonFieldView: View {
    let id: String, text: String
    
    init(id: String, text: String) {
        self.id = id
        self.text = text
    }
    
    @Environment(\.formButtonFieldCommunicator) var communicator
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    var body: some View {
        ZStack {
            Button(action: onClick) {
                Text(text)
                    .font(.system(size: 16, weight: .bold))
                    .frame(height: 48)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color("brandRed"))
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
            }
            .opacity(isLoading ? 0 : 1)
            .disabled(isLoading)
            
            if isLoading {
                loadingView
            }
        }
    }
    
    var loadingView: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(Color("brandRed"))
    }
    
    var isLoading: Bool {
        communicator[id]?.isLoading.wrappedValue == true
    }
    
    func onClick() {
        if let actions = communicator[id]?.actions {
            for action in actions {
                action()
            }
        }
    }
}

struct PrimaryButtonFieldView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButtonFieldView(id: "01", text: "LOG IN")
    }
}
