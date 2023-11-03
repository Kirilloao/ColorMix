//
//  ColorView.swift
//  ColorMix
//
//  Created by Kirill Taraturin on 03.11.2023.
//

import UIKit

final class ColorView: UIView {
    
    // MARK: - Private UI Properties
    private lazy var mainColorView: UIView = {
        var main = UIView()
        main.backgroundColor = .systemGray4
        main.layer.cornerRadius = 15
        return main
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setupConstraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setViews() {
        addSubview(mainColorView)
    }
    
    
    private func setupConstraints() {
        mainColorView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(200)
        }
    }
    

    
}
