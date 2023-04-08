//
//  FormSpacer.swift
//  LoginFormDemo
//
//  Created by Satish Vekariya on 07/04/2023.
//

import SwiftUI

struct FormSpacer: View {
    let height: CGFloat
    
    init(_ height: CGFloat) {
        self.height = height
    }
    
    var body: some View {
        Spacer()
            .frame(height: height)
    }
}

struct FormSpacer_Previews: PreviewProvider {
    static var previews: some View {
        FormSpacer(10)
    }
}
