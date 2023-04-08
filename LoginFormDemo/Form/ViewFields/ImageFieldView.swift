//
//  ImageFieldView.swift
//  LoginFormDemo
//
//  Created by Satish Vekariya on 07/04/2023.
//

import SwiftUI

struct ImageFieldView: View {
    let image: Image
    let size: CGSize
    
    init(
        image: Image = Image("brandLogoRed"),
        size: CGSize = .init(width: 160, height: 160)
    ) {
        self.image = image
        self.size = size
    }
    
    var body: some View {
        image
            .resizable()
            .frame(height: size.height)
            .frame(width: size.width)
    }
}

struct ImageFieldView_Previews: PreviewProvider {
    static var previews: some View {
        ImageFieldView()
    }
}
