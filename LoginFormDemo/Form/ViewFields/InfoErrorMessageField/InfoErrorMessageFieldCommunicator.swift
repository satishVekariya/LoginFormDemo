//
//  InfoErrorMessageFieldCommunicator.swift
//  LoginFormDemo
//
//  Created by Satish Vekariya on 08/04/2023.
//

import SwiftUI

struct InfoErrorMessageFieldCommunicator {
    typealias Action = () -> Void
    
    let actions: [String: Action]
    let errorMessage: Binding<String?>
    
    init(
        actions: [String : InfoErrorMessageFieldCommunicator.Action] = [:],
        errorMessage: Binding<String?> = .constant(nil)
    ) {
        self.actions = actions
        self.errorMessage = errorMessage
    }
    
    subscript(key: String) -> Action? {
        actions[key]
    }
}

struct InfoErrorMessageFieldCommunicatorEnvironmentKey: EnvironmentKey {
    static var defaultValue: InfoErrorMessageFieldCommunicator = .init()
}

extension EnvironmentValues {
    var infoErrorMessageFieldCommunicator: InfoErrorMessageFieldCommunicator {
        get { self[InfoErrorMessageFieldCommunicatorEnvironmentKey.self] }
        set {
            let oldValue = self[InfoErrorMessageFieldCommunicatorEnvironmentKey.self]
            let newDic = oldValue.actions.merging(newValue.actions) { (_, new) in new }
            let newData = InfoErrorMessageFieldCommunicator(actions: newDic, errorMessage: newValue.errorMessage)
            self[InfoErrorMessageFieldCommunicatorEnvironmentKey.self] = newData
        }
    }
}

extension View {
    /// Create communication link between Form's button field and form builder view
    /// - Parameter communicator: An object to create communication link
    /// - Returns: `some View`
    func infoErrorFieldCommunicator(_ communicator: InfoErrorMessageFieldCommunicator) -> some View {
        environment(\.infoErrorMessageFieldCommunicator, communicator)
    }
    
    /// Listen info error message tap action
    /// - Parameters:
    ///   - id: An identifier given in initialiser of `InfoErrorMessageField`
    ///   - action: An action that will be performed on tap
    /// - Returns: `some View`
    func infoErrorMessageFieldAction(_ id: String, action: @escaping (() -> Void)) -> some View {
        infoErrorFieldCommunicator(.init(actions: [id : action]))
    }

    /// Set info error message & view's visibility
    /// - Parameters:
    ///   - id: An identifier given in initialiser of `InfoErrorMessageField`
    ///   - action: An action that will be performed on button click
    /// - Returns: `some View`
    func infoErrorMessageFieldData(_ id: String, message: Binding<String?>) -> some View {
        infoErrorFieldCommunicator(.init(errorMessage: message))
    }
}
