//
//  Extension + UIFont.swift
//  ColorMix
//
//  Created by Kirill Taraturin on 03.11.2023.
//

import UIKit

extension UIFont {
    static func satisfy(size: CGFloat) -> UIFont {
        UIFont(name: "Satisfy-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

