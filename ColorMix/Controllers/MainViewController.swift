//
//  MainViewController.swift
//  ColorMix
//
//  Created by Kirill Taraturin on 03.11.2023.
//

import UIKit

protocol ColorViewControllerDelegate {
    func setColor(_ color: UIColor)
}

final class MainViewController: UIViewController {
    
    // MARK: - Private UI Properties
    private var welcomeLabel = UILabel()
    
    // MARK: - Private Properties
    private let colorManager = ColorManager.shared
    private let build = MainViewBuilder.shared

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setWelcomeLabel()
        setViews()
        setupNavigationBar()
    }
    
    // MARK: - Private Actions
    @objc private func changeColor() {
        navigationController?.navigationBar.tintColor = colorManager.getRandomColor()
        
        // navigation
        let colorVC = ColorViewController()
        colorVC.modalPresentationStyle = .fullScreen
        colorVC.delegate = self
        colorVC.viewColor = view.backgroundColor
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
    private func setWelcomeLabel() {
        welcomeLabel = build.welcomeLabel
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(animateWelcomeLabel)
        )
        
        welcomeLabel.addGestureRecognizer(tapGesture)
        view.addSubview(welcomeLabel)
        
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
    }
}

// MARK: - ColorViewControllerDelegate
extension MainViewController: ColorViewControllerDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
