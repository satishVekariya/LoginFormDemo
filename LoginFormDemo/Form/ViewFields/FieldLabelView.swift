//
//  FieldLabelView.swift
//  LoginFormDemo
//
//  Created by Satish Vekariya on 07/04/2023.
//

import SwiftUI

struct FieldLabelView: View {
    let title: String
    let font: Font
    let alignment: Alignment
    
    init(
        title: String,
        font: Font = .system(size: 14, weight: .semibold),
        alignment: Alignment = .leading
    ) {
        self.title = title
        self.font = font
        self.alignment = alignment
    }
    var body: some View {
        Text(title)
            .font(font)
            .frame(maxWidth: .infinity, alignment: alignment)
            .padding(.horizontal, 16)
    }
}

struct FieldLabelView_Previews: PreviewProvider {
    static var previews: some View {
        FieldLabelView(title: "Email")
    }
}
