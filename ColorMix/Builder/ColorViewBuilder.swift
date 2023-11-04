//
//  ColorViewBuilder.swift
//  ColorMix
//
//  Created by Kirill Taraturin on 04.11.2023.
//

import UIKit

final class ColorViewBuilder {
    static let shared = ColorViewBuilder()
    
    private init() {}
    
    // MARK: - Public Properties
    lazy var mainView: UIView = {
        var main = UIView()
        main.backgroundColor = .systemGray4
        main.layer.cornerRadius = 15
        return main
    }()
    
    lazy var doneButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        return button
    }()
    
    // MARK: - Public Methods
    func getLabel(with title: String) -> UILabel {
        let customLabel = UILabel()
        customLabel.text = title
        return customLabel
    }
    
    func getSlider(with color: UIColor) -> UISlider {
        let customSlider = UISlider()
        customSlider.thumbTintColor = color
        return customSlider
    }
    
    func getTextField() -> UITextField {
        let customTF = UITextField()
        customTF.placeholder = "1.00"
        customTF.borderStyle = .roundedRect
        return customTF
    }
    
    func getStackView(_ view: UIView..., alignment: UIStackView.Alignment = .fill, spacing: CGFloat = 25, axis: NSLayoutConstraint.Axis = .vertical) -> UIStackView {
        let stackView = UIStackView()
        view.forEach { view in
            stackView.addArrangedSubview(view)
        }
        
        stackView.alignment = alignment
        stackView.distribution = .fill
        stackView.spacing = spacing
        stackView.axis = axis
        return stackView
    }
}
