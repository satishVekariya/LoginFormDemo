//
//  TextInputFieldDataCollector.swift
//  LoginFormDemo
//
//  Created by Satish Vekariya on 08/04/2023.
//

import SwiftUI

final class TextInputFieldDataCollector {
    var values: [String: String]
    var validator: [String: TextInputValidator]
    
    init(values: [String : String] = [:], validator: [String : TextInputValidator] = [:]) {
        self.values = values
        self.validator = validator
    }
    
    subscript(key: String) -> String? {
        get {
            values[key]
        }
        set {
            values[key] = newValue
        }
    }
    
    subscript(key: String) -> TextInputValidator? {
        validator[key]
    }
    
    func getValidatedResult(id: String) -> String? {
        let result = validator[id]?.validate(input: values[id])
        if case .valid = result {
            return values[id]
        }
        return nil
    }
}

struct TextInputFieldDataCollectorEnvironmentKey: EnvironmentKey {
    static var defaultValue: TextInputFieldDataCollector = .init()
}

extension EnvironmentValues {
    var formTextFieldDataCollector: TextInputFieldDataCollector {
        get { self[TextInputFieldDataCollectorEnvironmentKey.self] }
        set { self[TextInputFieldDataCollectorEnvironmentKey.self] = newValue }
    }
}

extension View {
    func textInputFieldDataCollector(_ collector: TextInputFieldDataCollector) -> some View {
        environment(\.formTextFieldDataCollector, collector)
    }
}
