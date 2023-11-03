//
//  ViewController.swift
//  ColorMix
//
//  Created by Kirill Taraturin on 03.11.2023.
//

import UIKit
import SnapKit

final class ColorViewController: UIViewController {
    
    // MARK: - Private UI Properties
    private let colorView = ColorView()

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "ColorMix"
    }

    private func setViews() {
        view.backgroundColor = .white
        view.addSubview(colorView)
    }
    
    private func setupConstraints() {
        colorView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    

 
}

