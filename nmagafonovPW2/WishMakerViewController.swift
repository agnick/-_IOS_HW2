//
//  WishMakerViewController.swift
//  nmagafonovPW2
//
//  Created by Никита Агафонов on 25.10.2024.
//

import UIKit

final class WishMakerViewController: UIViewController {
    // MARK: - Enums
    enum Constants {
        // Slider settings.
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        static let defaultAlpha: CGFloat = 1
        
        // String.
        static let titleText: String = "WishMaker"
        static let descriptionText: String = "This app will bring you jou and will fulfill three of your wishes!\n   \u{22C5} The first wish is to change the background color."
        static let buttonInactiveText: String = "Hide color slider"
        static let buttonActiveText: String = "Show color slider"
        static let whiteHex: String = "#FFFFFF"
        static let blackHex: String = "#000000"
        static let red: String = "Red"
        static let green: String = "Green"
        static let blue: String = "Blue"
        static let alpha: String = "Alpha"
        
        // Stack positioning.
        static let stackRadius: CGFloat = 20
        static let stackBottom: CGFloat = 40
        static let stackLeading: CGFloat = 20
        
        // Title positioning
        static let titleFontSize: CGFloat = 32
        static let titleTop: CGFloat = 30
        
        // Description positioning
        static let descriptionFontSize: CGFloat = 16
        static let descriptionLeading: CGFloat = 20
        static let descriptionTop: CGFloat = 20
        static let descriptionLines: Int = 0
        
        // Button positioning
        static let buttonRadius: CGFloat = 20
        static let buttonLeading: CGFloat = 20
        static let buttonTop: CGFloat = 20
        static let buttonWidth: CGFloat = 200
        static let buttonHeight: CGFloat = 70
    }
    
    // MARK: - Variables
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let presentBtn = UIButton()
    private let sliderStack = UIStackView()
    
    private var currentRed: CGFloat = 0
    private var currentGreen: CGFloat = 0
    private var currentBlue: CGFloat = 0
    private var currentAlpha: CGFloat = 1
    
    // MARK: - Lifecycle
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(parameters:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Actions
    @objc private func presentButtonPressed() {
        if sliderStack.isHidden {
            presentBtn.setTitle(Constants.buttonInactiveText, for: .normal)
            sliderStack.isHidden = false
        } else {
            presentBtn.setTitle(Constants.buttonActiveText, for: .normal)
            sliderStack.isHidden = true
        }
    }
    
    // MARK: - Private methods
    private func configureUI() {
        view.backgroundColor = UIColor(hex: Constants.blackHex)
        
        configureTitle()
        configureDescription()
        configurePresentButton()
        configureSliders()
    }
    
    private func configureTitle() {
        view.addSubview(titleLabel)
        
        titleLabel.text = Constants.titleText
        // Making it bold.
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        // Using extension from the previous homework to change color with hex number.
        titleLabel.textColor = UIColor(hex: Constants.whiteHex)

        titleLabel.pinCenterX(to: view)
        titleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.titleTop)
    }
    
    private func configureDescription() {
        view.addSubview(descriptionLabel)
        
        descriptionLabel.text = Constants.descriptionText
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        descriptionLabel.textColor = UIColor(hex: Constants.whiteHex)
        descriptionLabel.numberOfLines = Constants.descriptionLines
        descriptionLabel.lineBreakMode = .byWordWrapping
        
        descriptionLabel.pinCenterX(to: view)
        descriptionLabel.pinLeft(to: view, Constants.descriptionLeading)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, Constants.descriptionTop)
    }
    
    private func configurePresentButton() {
        view.addSubview(presentBtn)
        
        presentBtn.layer.cornerRadius = Constants.buttonRadius
        presentBtn.setTitle(Constants.buttonInactiveText, for: .normal)
        presentBtn.backgroundColor = UIColor(hex: Constants.whiteHex)
        presentBtn.setTitleColor(UIColor(hex: Constants.blackHex), for: .normal)
    
        presentBtn.addTarget(self, action: #selector(presentButtonPressed), for: .touchUpInside)
        
        presentBtn.pinCenterX(to: view)
        presentBtn.pinTop(to: descriptionLabel.bottomAnchor, Constants.buttonTop)
        presentBtn.setWidth(Constants.buttonWidth)
        presentBtn.setHeight(Constants.buttonHeight)
    }
    
    private func configureSliders() {
        sliderStack.axis = .vertical
        view.addSubview(sliderStack)
        sliderStack.layer.cornerRadius = Constants.stackRadius
        sliderStack.clipsToBounds = true
        
        let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax, defaultValue: Constants.sliderMin)
        let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax, defaultValue: Constants.sliderMin)
        let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax, defaultValue: Constants.sliderMin)
        let sliderAlpha = CustomSlider(title: Constants.alpha, min: Constants.sliderMin, max: Constants.sliderMax, defaultValue: Constants.defaultAlpha)
        
        for slider in [sliderRed, sliderGreen, sliderBlue, sliderAlpha] {
            sliderStack.addArrangedSubview(slider)
        }
        
        sliderStack.pinCenterX(to: view)
        sliderStack.pinLeft(to: view, Constants.stackLeading)
        sliderStack.pinBottom(to: view, Constants.stackBottom)
        
        sliderRed.valueChanged = { [weak self] value in
            guard let self = self else { return }
            self.view.backgroundColor = UIColor(red: value, green: self.currentGreen, blue: self.currentBlue, alpha: self.currentAlpha)
            self.currentRed = value
            setOtherComponentsColor()
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            guard let self = self else { return }
            self.view.backgroundColor = UIColor(red: self.currentRed, green: value, blue: self.currentBlue, alpha: self.currentAlpha)
            self.currentGreen = value
            setOtherComponentsColor()
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            guard let self = self else { return }
            self.view.backgroundColor = UIColor(red: self.currentRed, green: self.currentGreen, blue: value, alpha: self.currentAlpha)
            self.currentBlue = value
            setOtherComponentsColor()
        }
        
        sliderAlpha.valueChanged = { [weak self] value in
            guard let self = self else { return }
            self.view.backgroundColor = UIColor(red: self.currentRed, green: self.currentGreen, blue: self.currentBlue, alpha: value)
            self.currentAlpha = value
        }
    }
    
    private func setOtherComponentsColor() {
        let oppositeColor = UIColor(red: Constants.sliderMax - currentRed, green: Constants.sliderMax - currentGreen, blue: Constants.sliderMax - currentBlue, alpha: Constants.defaultAlpha)
        
        titleLabel.textColor = oppositeColor
        descriptionLabel.textColor = oppositeColor
        presentBtn.backgroundColor = oppositeColor
        presentBtn.setTitleColor(view.backgroundColor, for: .normal)
    }
}
