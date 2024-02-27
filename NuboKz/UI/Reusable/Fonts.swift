//
//  Fonts.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 26.02.2024.
//

import UIKit

struct Fonts {
    enum fontType {
        case regular, medium, bold
    }
    
    static func fontCreator(font: fontType, size: CGFloat) -> UIFont {
        switch font {
        case .regular: return UIFont(name: "OpenSans-Regular", size: size) ?? UIFont.systemFont(ofSize: 14)
        case .medium: return UIFont(name: "OpenSans-Medium", size: size) ?? UIFont.systemFont(ofSize: 14)
        case .bold: return UIFont(name: "OpenSans-Bold", size: size) ?? UIFont.systemFont(ofSize: 14)
        }
    }
}
