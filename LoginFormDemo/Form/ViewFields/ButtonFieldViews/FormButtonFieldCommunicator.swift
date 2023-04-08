//
//  FormButtonFieldCommunicator.swift
//  LoginFormDemo
//
//  Created by Satish Vekariya on 08/04/2023.
//

import SwiftUI

struct FormButtonFieldCommunicator {
    typealias Action = () -> Void
    typealias Actions = [Action]
    
    let keyStore: [String: Store]
    
    init(_ store: [String: Store] = [:]) {
        self.keyStore = store
    }
    
    subscript(key: String) -> Store? {
        keyStore[key]
    }
    
    struct Store {
        let actions: Actions
        let isLoading: Binding<Bool>
        
        init(
            actions: FormButtonFieldCommunicator.Actions = [],
            isLoading: Binding<Bool> = .constant(false)
        ) {
            self.actions = actions
            self.isLoading = isLoading
        }
    }
}

struct FormButtonFieldCommunicatorEnvironmentKey: EnvironmentKey {
    static var defaultValue: FormButtonFieldCommunicator = .init()
}

extension EnvironmentValues {
    var formButtonFieldCommunicator: FormButtonFieldCommunicator {
        get { self[FormButtonFieldCommunicatorEnvironmentKey.self] }
        set {
            let oldValue = self[FormButtonFieldCommunicatorEnvironmentKey.self]
            let newDic = oldValue.keyStore.merging(newValue.keyStore) { (old, new) in
                    .init(actions: old.actions + new.actions, isLoading: old.isLoading)
            }
            self[FormButtonFieldCommunicatorEnvironmentKey.self] = .init(newDic)
        }
    }
}

extension View {
    /// Create communication link between Form's button field and form builder view
    /// - Parameter communicator: An object to create communication link
    /// - Returns: `some View`
    func formButtonFieldCommunicator(_ communicator: FormButtonFieldCommunicator) -> some View {
        environment(\.formButtonFieldCommunicator, communicator)
    }
    
    /// Listen primary button action
    /// - Parameters:
    ///   - id: An identifier given in initialiser of `PrimaryButtonFieldView`
    ///   - action: An action that will be performed on button click
    /// - Returns: `some View`
    func primaryButtonFieldAction(_ id: String, action: @escaping (() -> Void)) -> some View {
        formButtonFieldCommunicator(.init([id: .init(actions: [action])]))
    }
    
    /// Set primary button field loading binding
    /// - Parameters:
    ///   - id: An identifier given in initialiser of `PrimaryButtonFieldView`
    ///   - isLoading: A binding for button's loading state
    /// - Returns: `some View`
    func setButtonFieldLoading(_ id: String, isLoading: Binding<Bool>) -> some View {
        formButtonFieldCommunicator(.init([id: .init(isLoading: isLoading)]))
    }
    
    /// Listen primary button action
    /// - Parameters:
    ///   - id: An identifier given in initialiser of `SecondaryButtonFieldView`
    ///   - action: An action that will be performed on button click
    /// - Returns: `some View`
    func secondaryButtonFieldAction(_ id: String, action: @escaping (() -> Void)) -> some View {
        formButtonFieldCommunicator(.init([id: .init(actions: [action])]))
    }
}
