//
//  TextInputFieldView.swift
//  LoginFormDemo
//
//  Created by Satish Vekariya on 07/04/2023.
//

import SwiftUI

struct TextInputFieldView: View {
    
    let id: String, isSecureEnable: Bool
    init(
        id: String,
        isSecure: Bool = false
    ) {
        self.id = id
        self.isSecureEnable = isSecure
    }
    
    @FocusState private var isFocused: Bool
    @State private var text: String = ""
    @State private var _isSecure: Bool = true
    @State private var errorText: String? = nil
    @Environment(\.formTextFieldDataCollector) var collector
    
    var body: some View {
        Group {
            ZStack(alignment: .trailing) {
                TextField("", text: $text)
                    .disabled(isShowSecureText)
                    .opacity(!isShowSecureText ? 1 : 0)
                SecureField("", text: $text)
                    .disabled(!isShowSecureText) // Without disable focus not moving on `Tab` key press
                    .opacity(isShowSecureText ? 1 : 0)
            }
            .focused($isFocused)
            .tint(Color("brandRed"))
            .padding(.init(top: 16, leading: 16, bottom: 16, trailing: isSecureEnable ? 48 : 16))
            .background(
                borderRing
                    .padding(.trailing, 0)
            )
            .overlay(alignment: .trailing) {
                eyeButton
            }
            .padding(.horizontal, 16)
            .onChange(of: text) { newValue in
                collector[id] = newValue
            }
            .onChange(of: isFocused, perform: performValidation(isFocused:))
            .onReceive(NotificationCenter.default.publisher(for: .resignKeyboard)) { _ in
                isFocused = false
            }
            .onReceive(NotificationCenter.default.publisher(for: .forceValidation)) { _ in
                performValidation(isFocused: isFocused)
            }
            
            inlineErrorView
        }
    }
    
    var isShowSecureText: Bool {
        isSecureEnable && _isSecure
    }
    
    var borderRing: some View {
        RoundedRectangle(cornerRadius: 8)
            .stroke(
                isFocused ? Color.black : errorText == nil ? .gray : Color("brandRed"),
                lineWidth: isFocused ? 3 : 2.5
            )
            .shadow(color: isFocused ? Color(.sRGBLinear, white: 0, opacity: 0.33) : .clear, radius: 4, x: 0, y: 1)
            .animation(.easeInOut(duration: 0.15), value: isFocused)
    }
    
    @ViewBuilder
    var eyeButton: some View {
        if !isSecureEnable || (text.isEmpty && _isSecure) {
            EmptyView()
        } else {
            Button {
                _isSecure.toggle()
            } label: {
                VStack {
                    Spacer()
                    Image(systemName: _isSecure ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.black)
                        .frame(width: 18)
                        .animation(.easeInOut(duration: 0.20), value: _isSecure)
                    Spacer()
                }.frame(maxWidth: 48, maxHeight: .infinity)
            }
            .buttonStyle(.plain)
        }
    }
    
    @ViewBuilder
    var inlineErrorView: some View {
        if let errorText {
            Spacer()
                .frame(height: 8)
            Text("\(Image(systemName: "exclamationmark.circle.fill")) \(errorText)")
                .font(.system(size: 11))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .foregroundColor(Color("brandRed"))
                .transition(.opacity)
                .animation(.easeInOut, value: errorText)
        } else {
            EmptyView()
        }
    }
    
    func performValidation( isFocused: Bool) {
        var message: String?
        if !isFocused, let validator: TextInputValidator = collector[id] {
            switch validator.validate(input: collector[id]) {
            case .invalid(let reason):
                message = reason
            case .valid:
                message = nil
            }
        } else {
            message = nil
        }
        withAnimation {
            errorText = message
        }
    }
}

struct TextInputFieldView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TextInputFieldView(id: "02")
            TextInputFieldView(id: "02", isSecure: true)
        }
    }
}

extension TextInputFieldView {
    /// Dismiss keyboard for any`TextInputFieldView`
    static func resignKeyboardFocus() {
        NotificationCenter.default.post(name: .resignKeyboard, object: nil)
    }
    
    /// Force to validate all `TextInputFieldView`
    static func forceTextInputValidation() {
        NotificationCenter.default.post(name: .forceValidation, object: nil)
    }
}

fileprivate extension Notification.Name {
    static let resignKeyboard = Notification.Name("resinKeyboard")
    static let forceValidation = Notification.Name("forceValidation")
}
