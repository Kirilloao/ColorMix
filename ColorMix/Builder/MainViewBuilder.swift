//
//  ViewBuilder.swift
//  ColorMix
//
//  Created by Kirill Taraturin on 04.11.2023.
//

import UIKit

final class MainViewBuilder {
    
    static let shared = MainViewBuilder()
    
    private let colorManager = ColorManager.shared
    
    private init() {}
    
    lazy var welcomeLabel: UILabel = {
        let welcomeLabel = UILabel()
        welcomeLabel.font = UIFont.satisfy(size: 55)
        welcomeLabel.text = "Mix Colors"
        welcomeLabel.isUserInteractionEnabled = true
        welcomeLabel.textColor = colorManager.getRandomColor()
        return welcomeLabel
    }()
}
