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
        
        // Title positioning.
        static let titleFontSize: CGFloat = 32
        static let titleTop: CGFloat = 30
        
        // Description positioning.
        static let descriptionFontSize: CGFloat = 16
        static let descriptionLeading: CGFloat = 20
        static let descriptionTop: CGFloat = 20
        static let descriptionLines: Int = 0
        
        // Button positioning.
        static let buttonRadius: CGFloat = 20
        static let buttonBottom: CGFloat = 15
        static let buttonWidth: CGFloat = 200
        static let buttonHeight: CGFloat = 40
    }
    
    // MARK: - Variables
    // UI Components.
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let presentBtn = UIButton()
    private let sliderStack = UIStackView()
    
    // Variables for storing color tint and transparency states.
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
        
        // Set up the UI components when the view is loaded.
        configureUI()
    }
    
    // MARK: - Actions
    // Toggles the visibility of the slider stack and updates the button text.
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
    // Configures the overall UI of the view controller.
    private func configureUI() {
        view.backgroundColor = UIColor(hex: Constants.blackHex)
        
        // Set up the title label.
        configureTitle()
        // Set up the description label.
        configureDescription()
        // // Set up the sliders.
        configureSliders()
        // Set up the button.
        configurePresentButton()
    }
    
    // Configures the title label.
    private func configureTitle() {
        view.addSubview(titleLabel)
        
        titleLabel.text = Constants.titleText
        // Making the text bold.
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        // Using an extension to change color with a hex value.
        titleLabel.textColor = UIColor(hex: Constants.whiteHex)

        // Using UIView+Pin to center the title label horizontally and set its top margin.
        titleLabel.pinCenterX(to: view)
        titleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.titleTop)
    }
    
    // Configures the description label.
    private func configureDescription() {
        view.addSubview(descriptionLabel)
        
        descriptionLabel.text = Constants.descriptionText
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        descriptionLabel.textColor = UIColor(hex: Constants.whiteHex)
        // Allow unlimited lines.
        descriptionLabel.numberOfLines = Constants.descriptionLines
        // Break lines by words.
        descriptionLabel.lineBreakMode = .byWordWrapping
        
        // Using UIView+Pin to center the description label horizontally and set its left and top margins.
        descriptionLabel.pinCenterX(to: view)
        descriptionLabel.pinLeft(to: view, Constants.descriptionLeading)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, Constants.descriptionTop)
    }
    
    // Configures the button that shows/hides the sliders.
    private func configurePresentButton() {
        view.addSubview(presentBtn)
        
        // Set button corner radius.
        presentBtn.layer.cornerRadius = Constants.buttonRadius
        // Set initial button title.
        presentBtn.setTitle(Constants.buttonInactiveText, for: .normal)
        // Set initial button background color.
        presentBtn.backgroundColor = UIColor(hex: Constants.whiteHex)
        // Set initial button text color.
        presentBtn.setTitleColor(UIColor(hex: Constants.blackHex), for: .normal)
    
        // Add action for button press.
        presentBtn.addTarget(self, action: #selector(presentButtonPressed), for: .touchUpInside)
        
        // Using UIView+Pin to set constraints.
        presentBtn.pinCenterX(to: view)
        presentBtn.pinBottom(to: sliderStack.topAnchor, Constants.buttonBottom)
        presentBtn.setWidth(Constants.buttonWidth)
        presentBtn.setHeight(Constants.buttonHeight)
    }
    
    // Configures the sliders for changing the background color.
    private func configureSliders() {
        view.addSubview(sliderStack)
        
        // Arrange sliders vertically.
        sliderStack.axis = .vertical
        // Set corner radius.
        sliderStack.layer.cornerRadius = Constants.stackRadius
        // Ensure sliders don't extend beyond stack bounds.
        sliderStack.clipsToBounds = true
        
        // Create sliders for each color component and alpha.
        let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax, initValue: Constants.sliderMin)
        let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax, initValue: Constants.sliderMin)
        let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax, initValue: Constants.sliderMin)
        let sliderAlpha = CustomSlider(title: Constants.alpha, min: Constants.sliderMin, max: Constants.sliderMax, initValue: Constants.defaultAlpha)
        
        // Add each slider to the stack view.
        for slider in [sliderRed, sliderGreen, sliderBlue, sliderAlpha] {
            sliderStack.addArrangedSubview(slider)
        }
        
        // Using UIView+Pin to set constraints for the slider stack.
        sliderStack.pinCenterX(to: view)
        sliderStack.pinLeft(to: view, Constants.stackLeading)
        sliderStack.pinBottom(to: view, Constants.stackBottom)
        
        // Handle value changes for each slider to update the background color.
        sliderRed.valueChanged = { [weak self] value in
            // Prevent memory leaks by safely unwrapping `self` before using it.
            guard let self = self else { return }
            // Change background color with new one.
            self.view.backgroundColor = UIColor(red: value, green: self.currentGreen, blue: self.currentBlue, alpha: self.currentAlpha)
            // Save value.
            self.currentRed = value
            // Update colors of other components.
            setOtherComponentsColor()
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            // Prevent memory leaks by safely unwrapping `self` before using it.
            guard let self = self else { return }
            // Change background color with new one.
            self.view.backgroundColor = UIColor(red: self.currentRed, green: value, blue: self.currentBlue, alpha: self.currentAlpha)
            // Save value.
            self.currentGreen = value
            // Update colors of other components.
            setOtherComponentsColor()
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            // Prevent memory leaks by safely unwrapping `self` before using it.
            guard let self = self else { return }
            // Change background color with new one.
            self.view.backgroundColor = UIColor(red: self.currentRed, green: self.currentGreen, blue: value, alpha: self.currentAlpha)
            // Save value.
            self.currentBlue = value
            // Update colors of other components.
            setOtherComponentsColor()
        }
        
        sliderAlpha.valueChanged = { [weak self] value in
            // Prevent memory leaks by safely unwrapping `self` before using it.
            guard let self = self else { return }
            // Change background color with new one.
            self.view.backgroundColor = UIColor(red: self.currentRed, green: self.currentGreen, blue: self.currentBlue, alpha: value)
            // Save value.
            self.currentAlpha = value
        }
    }
    
    // Updates the colors of the other UI components to provide contrast with the background.
    private func setOtherComponentsColor() {
        // Calculate an opposite color for better contrast.
        let oppositeColor = UIColor(red: Constants.sliderMax - currentRed, green: Constants.sliderMax - currentGreen, blue: Constants.sliderMax - currentBlue, alpha: Constants.defaultAlpha)
        
        titleLabel.textColor = oppositeColor
        descriptionLabel.textColor = oppositeColor
        presentBtn.backgroundColor = oppositeColor
        // Set button text color to match the background.
        presentBtn.setTitleColor(view.backgroundColor, for: .normal)
    }
}
