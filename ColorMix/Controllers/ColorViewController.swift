//
//  ViewController.swift
//  ColorMix
//
//  Created by Kirill Taraturin on 03.11.2023.
//

import UIKit
import SnapKit

final class ColorViewController: UIViewController {
    
    // MARK: - Public Properties
    var delegate: ColorViewControllerDelegate!
    var viewColor: UIColor!
    
    // MARK: - Builder
    private let build = ColorViewBuilder.shared
    
    // MARK: - MainView
    private var mainView = UIView()
    
    // MARK: - Color Labels
    private var redColorLabel = UILabel()
    private var greenColorLabel = UILabel()
    private var blueColorLabel = UILabel()
    
    // MARK: - Value Labels
    private var redValueLabel = UILabel()
    private var greenValueLabel = UILabel()
    private var blueValueLabel = UILabel()
    
    // MARK: - Sliders
    private var redSlider = UISlider()
    private var greenSlider = UISlider()
    private var blueSlider = UISlider()
    
    // MARK: - TextField
    private var redTextField = UITextField()
    private var greenTextField = UITextField()
    private var blueTextField = UITextField()
    
    // MARK: - Stacks
    private var mainStackView = UIStackView()
    private var colorLabelsStackView = UIStackView()
    private var valueLabelsStackView = UIStackView()
    private var slidersStackView = UIStackView()
    private var textFieldsStackView = UIStackView()
    
    // MARK: - Button
    private var doneButton = UIButton()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setMainView()
        setViews()
        setupColorLabels()
        setupValueLabels()
        setupSliders()
        setupTextFields()
        setMainStackView()
        setDoneButton()
        setupNavigationBar()
        
        mainView.backgroundColor = viewColor
        
        setValue(for: redSlider, greenSlider, blueSlider)
        setValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        setValue(for: redTextField, greenTextField, blueTextField)
    }
    
    // MARK: - Override Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Private Actions
    @objc private func rgbSlider(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setValue(for: redValueLabel)
            setValue(for: redTextField)
        case greenSlider:
            setValue(for: greenValueLabel)
            setValue(for: greenTextField)
        default:
            setValue(for: blueValueLabel)
            setValue(for: blueTextField)
        }
        
        setColor()
    }
    
    @objc private func doneButtonDidTapped() {
        delegate.setColor(mainView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func setColor() {
        mainView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel: label.text = string(from: redSlider)
            case greenValueLabel: label.text = string(from: greenSlider)
            default: label.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField: textField.text = string(from: redSlider)
            case greenTextField: textField.text = string(from: greenSlider)
            default: textField.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(for colorSliders: UISlider...) {
        let ciColor = CIColor(color: viewColor)
        colorSliders.forEach { slider in
            switch slider {
            case redSlider: redSlider.value = Float(ciColor.red)
            case greenSlider: greenSlider.value = Float(ciColor.green)
            default: blueSlider.value = Float(ciColor.blue)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = "1.00"
            textField?.becomeFirstResponder()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - Setup UI
extension ColorViewController {
    func setMainView() {
        mainView = build.mainView
        
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(200)
        }
    }
    
    private func setMainStackView() {
        mainStackView = build.getStackView(
            colorLabelsStackView, valueLabelsStackView, slidersStackView, textFieldsStackView,
            alignment: .center,
            spacing: 8,
            axis: .horizontal
        )
        
        view.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    private func setupColorLabels() {
        // setup labels
        redColorLabel = build.getLabel(with: "Red:")
        greenColorLabel = build.getLabel(with: "Green:")
        blueColorLabel = build.getLabel(with: "Blue:")
        
        // setup stackView
        colorLabelsStackView = build.getStackView(
            redColorLabel, greenColorLabel, blueColorLabel)
        
        // setup constraints
        colorLabelsStackView.snp.makeConstraints { make in
            make.width.equalTo(52)
        }
    }
    
    private func setupValueLabels() {
        // setup labels
        redValueLabel = build.getLabel(with: "1.00")
        greenValueLabel = build.getLabel(with: "1.00")
        blueValueLabel = build.getLabel(with: "1.00")
        
        // setup stackView
        valueLabelsStackView = build.getStackView(
            redValueLabel, greenValueLabel, blueValueLabel
        )
        
        // setup constraints
        valueLabelsStackView.snp.makeConstraints { make in
            make.width.equalTo(35)
        }
    }
    
    private func setupSliders() {
        // setup labels
        redSlider = build.getSlider(with: .systemRed)
        redSlider.addTarget(self, action: #selector(rgbSlider), for: .valueChanged)
        
        greenSlider = build.getSlider(with: .systemGreen)
        greenSlider.addTarget(self, action: #selector(rgbSlider), for: .valueChanged)
        
        blueSlider = build.getSlider(with: .systemBlue)
        blueSlider.addTarget(self, action: #selector(rgbSlider), for: .valueChanged)
        
        // setup stackView
        slidersStackView = build.getStackView(
            redSlider, greenSlider, blueSlider,
            spacing: 12
        )
    }
    
    private func setupTextFields() {
        // setup labels
        redTextField = build.getTextField()
        greenTextField = build.getTextField()
        blueTextField = build.getTextField()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        // setup stackView
        textFieldsStackView = build.getStackView(
            redTextField, greenTextField, blueTextField,
            spacing: 10
        )
        
        // setup constraints
        textFieldsStackView.snp.makeConstraints { make in
            make.width.equalTo(50)
        }
    }
    
    private func setDoneButton() {
        // setup button
        doneButton = build.doneButton
        view.addSubview(doneButton)
        
        // setup constraints
        doneButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalToSuperview().offset(-120)
        }
        
        // target
        doneButton.addTarget(
            self,
            action: #selector(doneButtonDidTapped),
            for: .touchUpInside
        )
    }
    
    private func setupNavigationBar() {
        title = "ColorMix"
    }
    
    private func setViews() {
        view.backgroundColor = .white
    }
}

// MARK: - UITextFieldDelegate
extension ColorViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            showAlert(title: "Wrong format!", message: "Please ender correct value")
            return
        }
        guard let currentValue = Float(text), (0...1).contains(currentValue) else {
            showAlert(title: "Wrong format!",
                      message: "Please enter correct value",
                      textField: textField
            )
            return
        }
        
        switch textField {
        case redTextField:
            redSlider.setValue(currentValue, animated: true)
            setValue(for: redValueLabel)
        case greenTextField:
            greenSlider.setValue(currentValue, animated: true)
            setValue(for: greenValueLabel)
        default:
            blueSlider.setValue(currentValue, animated: true)
            setValue(for: blueValueLabel)
        }
        
        setColor()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        textField.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: textField,
            action: #selector(resignFirstResponder))
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
}

