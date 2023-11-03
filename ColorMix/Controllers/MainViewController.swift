//
//  MainViewController.swift
//  ColorMix
//
//  Created by Kirill Taraturin on 03.11.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Private Properties
    private let colorManager = ColorManager.shared
    
    // MARK: - Private UI Properties
    private lazy var welcomeLabel: UILabel = {
        let welcomeLabel = UILabel()
        welcomeLabel.font = UIFont.satisfy(size: 55)
        welcomeLabel.text = "Mix Colors"
        welcomeLabel.isUserInteractionEnabled = true
        welcomeLabel.textColor = colorManager.getRandomColor()
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(animateWelcomeLabel)
        )
        welcomeLabel.addGestureRecognizer(tapGesture)
        return welcomeLabel
    }()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    // MARK: - Private Actions
    @objc private func changeColor() {
        navigationController?.navigationBar.tintColor = colorManager.getRandomColor()
        
        // navigation
        let colorVC = ColorViewController()
        colorVC.modalPresentationStyle = .fullScreen
        present(colorVC, animated: true)
    }
    
    @objc private func animateWelcomeLabel() {
        UIView.animate(withDuration: 1.0, animations: {
            self.welcomeLabel.alpha = 0.0
            self.welcomeLabel.transform = CGAffineTransform(translationX: 0, y: -50)
        }) { _ in
            UIView.animate(withDuration: 1.0) {
                self.welcomeLabel.alpha = 1.0
                self.welcomeLabel.transform = CGAffineTransform.identity
                self.welcomeLabel.textColor = self.colorManager.getRandomColor()
            }
        }
    }
    
    // MARK: - Private Methods
    private func setupConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
    }
    
    private func setupNavigationBar() {
        let newColorButton = UIBarButtonItem(
            barButtonSystemItem: .compose,
            target: self,
            action: #selector(changeColor)
        )
        
        navigationItem.rightBarButtonItem = newColorButton
        navigationController?.navigationBar.tintColor = colorManager.getRandomColor()
        
    }
    
    private func setViews() {
        view.backgroundColor = .white
        view.addSubview(welcomeLabel)
    }
    
//    private func applyMulticolorToLabel(_ label: UILabel) {
//        let text = "Mix Colors"
//        let attributedText = NSMutableAttributedString(string: text)
//
//        // Массив цветов для букв
//        let colors: [UIColor] = [
//            UIColor(red: 0.11, green: 0.82, blue: 0.63, alpha: 1.00),
//            UIColor(red: 1.00, green: 0.62, blue: 0.26, alpha: 1.00),
//            UIColor(red: 0.28, green: 0.86, blue: 0.98, alpha: 1.00),
//            .white,
//            UIColor(red: 0.37, green: 0.15, blue: 0.80, alpha: 1.00),
//            UIColor(red: 1.00, green: 0.79, blue: 0.34, alpha: 1.00),
//            UIColor(red: 1.00, green: 0.62, blue: 0.95, alpha: 1.00),
//            UIColor(red: 1.00, green: 0.42, blue: 0.42, alpha: 1.00),
//            UIColor(red: 0.77, green: 0.90, blue: 0.22, alpha: 1.00),
//            UIColor(red: 0.02, green: 0.32, blue: 0.87, alpha: 1.00)
//        ]
//
//        // Применить цвет к каждой букве
//        for (index, _) in text.enumerated() {
//            let range = NSRange(location: index, length: 1)
//            let color = colors[index % colors.count]  // Повторение массива цветов, если он короче текста
//            attributedText.addAttribute(.foregroundColor, value: color, range: range)
//        }
//
//        label.attributedText = attributedText
//    }
    
    
}
