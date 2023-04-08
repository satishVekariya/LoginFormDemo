//
//  InfoErrorMessageField.swift
//  LoginFormDemo
//
//  Created by Satish Vekariya on 07/04/2023.
//

import SwiftUI

struct InfoErrorMessageField: View {
    static let bgColor = Color("lightPink")
    static let redColor = Color(uiColor: UIColor(red: 0.835, green: 0, blue: 0, alpha: 1))
    
    let id: String
    init(id: String) {
        self.id = id
    }
    
    @Environment(\.infoErrorMessageFieldCommunicator) var communicator
    @State private var messageStr: String? = nil
    
    var body: some View {
        Group {
            if let message = messageStr {
                HStack(alignment: .firstTextBaseline) {
                    exclamationImage
                    Text(message)
                }
                .frame(maxWidth: .infinity)
                .padding(.init(top: 12, leading: 8, bottom: 12, trailing: 8))
                .background(background)
                .padding(.horizontal, 16)
                .onTapGesture(perform: onTap)
            } else {
                EmptyView()
            }
        }
        .transition(.popInOut())
        .onChange(of: communicator.errorMessage.wrappedValue) { newValue in
            withAnimation(.linear(duration: 0.20)) {
                messageStr = newValue
            }
        }
    }
    
    var background: some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(Self.bgColor)
    }
    
    var exclamationImage: some View {
        Image(systemName: "exclamationmark.circle.fill")
            .foregroundColor(Self.redColor)
    }
    
    func onTap() {
        if let action = communicator[id] {
            action()
        }
    }
}

struct InfoErrorMessageField_Previews: PreviewProvider {
    static let message = "It looks like your email and/or password do not match. Please try again."
    static var previews: some View {
        InfoErrorMessageField(id: "123")
            .infoErrorMessageFieldData("123", message: .constant(message))
            .infoErrorMessageFieldAction("123") {
                print("Info message tapped")
            }
    }
}

extension AnyTransition {
    static func popInOut() -> AnyTransition {
        AnyTransition.asymmetric(
            insertion: .opacity.combined(with: .move(edge: .top).combined(with: .scale(scale: 0.35))),
            removal: .opacity.combined(with: .move(edge: .top).combined(with: .scale(scale: 0.35)))
        )
    }
}
