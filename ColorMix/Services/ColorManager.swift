//
//  ColorManager.swift
//  ColorMix
//
//  Created by Kirill Taraturin on 03.11.2023.
//

import UIKit

class ColorManager {
    static let shared = ColorManager()
    
    private init() {}
    
    let colors: [UIColor] = [
        UIColor(red: 0.11, green: 0.82, blue: 0.63, alpha: 1.00),
        UIColor(red: 1.00, green: 0.62, blue: 0.26, alpha: 1.00),
        UIColor(red: 0.28, green: 0.86, blue: 0.98, alpha: 1.00),
        UIColor(red: 0.37, green: 0.15, blue: 0.80, alpha: 1.00),
        UIColor(red: 1.00, green: 0.79, blue: 0.34, alpha: 1.00),
        UIColor(red: 1.00, green: 0.62, blue: 0.95, alpha: 1.00),
        UIColor(red: 1.00, green: 0.42, blue: 0.42, alpha: 1.00),
        UIColor(red: 0.77, green: 0.90, blue: 0.22, alpha: 1.00),
        UIColor(red: 0.02, green: 0.32, blue: 0.87, alpha: 1.00),
        UIColor(red: 0.50, green: 0.56, blue: 0.61, alpha: 1.00),
        UIColor(red: 0.02, green: 0.77, blue: 0.42, alpha: 1.00),
        UIColor(red: 0.24, green: 0.25, blue: 0.78, alpha: 1.00),
        UIColor(red: 1.00, green: 0.69, blue: 0.26, alpha: 1.00),
        UIColor(red: 0.70, green: 0.22, blue: 0.22, alpha: 1.00),
        UIColor(red: 0.20, green: 0.67, blue: 0.88, alpha: 1.00),
        .black,
        .brown,
        .orange,
        .purple
    ]
    
    func getRandomColor() -> UIColor {
        colors.randomElement() ?? UIColor.black
    }
}


