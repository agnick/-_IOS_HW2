//
//  WishMakerViewController.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 03.12.2024.
//

import UIKit

class WishMakerViewController: UIViewController {
    // MARK: - Enums
    enum WishMakerConstants {
        // String.
        static let whiteHex: String = "#FFFFFF"
        static let blackHex: String = "#000000"
        
        // Stack positioning.
        static let stackRadius: CGFloat = 20
        static let stackBottom: CGFloat = 10
        static let stackLeading: CGFloat = 20
        
        // Title positioning.
        static let titleFontSize: CGFloat = 32
        static let titleTop: CGFloat = 30
        static let titleLeading: CGFloat = 20
        
        // Description positioning.
        static let descriptionFontSize: CGFloat = 16
        static let descriptionLeading: CGFloat = 20
        static let descriptionTop: CGFloat = 20
        static let descriptionLines: Int = 0
        
        // Present Button positioning.
        static let buttonRadius: CGFloat = 20
        static let buttonBottom: CGFloat = 10
        static let buttonHeight: CGFloat = 40
        static let buttonSide: CGFloat = 20
        
        // Action Stack positioning.
        static let actionStackSpacing: CGFloat = 10
        static let actionStackBottom: CGFloat = 15
        static let actionStackLeading: CGFloat = 20
    }
    
    // MARK: - Variables
    private let interactor: WishMakerBusinessLogic
    
    // UI Components.
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let presentBtn: UIButton = UIButton(type: .system)
    private let addWishButton: UIButton = UIButton(type: .system)
    private let sliderStack: UIStackView = UIStackView()
    private let scheduleWishesButton: UIButton = UIButton(type: .system)
    private let actionStack: UIStackView = UIStackView()
    
    // MARK: - Lifecycle
    init(interactor: WishMakerBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(parameters:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        interactor.loadStart(WishMakerModel.Start.Request())
    }
    
    // MARK: - Actions
    // Toggles the visibility of the slider stack and updates the button text.
    @objc private func presentButtonPressed() {
        interactor.toggleSliderVisibility(WishMakerModel.ToggleSlider.Request())
    }
    
    // Opens the WishStoringViewController to display the list of wishes.
    @objc
    private func addWishButtonPressed() {
        let destination = WishStoringAssembly.build()
        interactor.routeTo(WishMakerModel.Navigation.Request(destination: destination))
    }
    
    // Opens the wish calendar screen.
    @objc
    private func scheduleWishesButtonPressed() {
        let destination = WishCalendarAssembly.build()
        interactor.routeTo(WishMakerModel.Navigation.Request(destination: destination))
    }
    
    // MARK: - Public methods
    // Displays the initial data in the UI.
    func displayStart(_ viewModel: WishMakerModel.Start.ViewModel) {
        presentBtn.setTitle(viewModel.startButtonText, for: .normal)
        titleLabel.text = viewModel.titleText
        descriptionLabel.text = viewModel.descriptionText
        configureSliders(viewModel.sliders)
        addWishButton.setTitle(viewModel.addWishButtonText, for: .normal)
        scheduleWishesButton.setTitle(viewModel.scheduleWishesButtonText, for: .normal)
    }
    
    // Updates the slider visibility state.
    func updateSliderVisibility(_ viewModel: WishMakerModel.ToggleSlider.ViewModel) {
        sliderStack.isHidden = viewModel.isSliderVisible
        presentBtn.setTitle(viewModel.buttonText, for: .normal)
    }
    
    // Updates the colors of UI components based on slider values.
    func updateSliderColors(_ viewModel: WishMakerModel.Slider.ValueChangedViewModel) {
        // Update background color
        view.backgroundColor = createColor(from: viewModel.backgroundColorComponents)
        
        // Update text colors
        titleLabel.textColor = createColor(from: viewModel.titleColorComponents)
        descriptionLabel.textColor = createColor(from: viewModel.descriptionColorComponents)
        
        // Update button colors
        let buttonBackgroundColor = createColor(from: viewModel.buttonColorComponents)
        let buttonTextColor = createColor(from: viewModel.buttonTextColorComponents)
        
        [presentBtn, addWishButton, scheduleWishesButton].forEach { button in
            button.backgroundColor = buttonBackgroundColor
            button.setTitleColor(buttonTextColor, for: .normal)
        }
    }
    
    // MARK: - Private methods
    // Configures the overall UI of the view controller.
    private func configureUI() {
        view.backgroundColor = UIColor(hex: WishMakerConstants.blackHex)
        
        configureTitle()
        configureDescription()
        configureActionStack()
        configureSliderStack()
        configurePresentButton()
    }
    
    // Configures the title label.
    private func configureTitle() {
        view.addSubview(titleLabel)
        
        titleLabel.textAlignment = .center
        // Making the text bold.
        titleLabel.font = UIFont.boldSystemFont(ofSize: WishMakerConstants.titleFontSize)
        // Using an extension to change color with a hex value.
        titleLabel.textColor = UIColor(hex: WishMakerConstants.whiteHex)
        
        // Using UIView+Pin to center the title label horizontally and set its top margin.
        titleLabel.pinCenterX(to: view)
        titleLabel.pinLeft(to: view, WishMakerConstants.titleLeading)
        titleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, WishMakerConstants.titleTop)
    }
    
    // Configures the description label.
    private func configureDescription() {
        view.addSubview(descriptionLabel)
        
        descriptionLabel.font = UIFont.systemFont(ofSize: WishMakerConstants.descriptionFontSize)
        descriptionLabel.textColor = UIColor(hex: WishMakerConstants.whiteHex)
        // Allow unlimited lines.
        descriptionLabel.numberOfLines = WishMakerConstants.descriptionLines
        // Break lines by words.
        descriptionLabel.lineBreakMode = .byWordWrapping
        
        // Using UIView+Pin to center the description label horizontally and set its left and top margins.
        descriptionLabel.pinCenterX(to: view)
        descriptionLabel.pinLeft(to: view, WishMakerConstants.descriptionLeading)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, WishMakerConstants.descriptionTop)
    }
    
    // Configures the button that shows/hides the sliders.
    private func configurePresentButton() {
        view.addSubview(presentBtn)
        
        // Set button corner radius.
        presentBtn.layer.cornerRadius = WishMakerConstants.buttonRadius
        // Set initial button background color.
        presentBtn.backgroundColor = UIColor(hex: WishMakerConstants.whiteHex)
        // Set initial button text color.
        presentBtn.setTitleColor(UIColor(hex: WishMakerConstants.blackHex), for: .normal)
        
        // Add action for button press.
        presentBtn.addTarget(self, action: #selector(presentButtonPressed), for: .touchUpInside)
        
        // Using UIView+Pin to set constraints.
        presentBtn.pinHorizontal(to: view, WishMakerConstants.buttonSide)
        presentBtn.pinBottom(to: sliderStack.topAnchor, WishMakerConstants.buttonBottom)
        presentBtn.setHeight(WishMakerConstants.buttonHeight)
    }
    
    private func configureSliderStack() {
        view.addSubview(sliderStack)
        
        // Arrange sliders vertically.
        sliderStack.axis = .vertical
        // Set corner radius.
        sliderStack.layer.cornerRadius = WishMakerConstants.stackRadius
        // Ensure sliders don't extend beyond stack bounds.
        sliderStack.clipsToBounds = true
        
        // Using UIView+Pin to set constraints for the slider stack.
        sliderStack.pinCenterX(to: view)
        sliderStack.pinLeft(to: view, WishMakerConstants.stackLeading)
        sliderStack.pinBottom(to: actionStack.topAnchor, WishMakerConstants.stackBottom)
    }
    
    // Configures the sliders for changing the background color.
    private func configureSliders(_ sliders: [WishMakerModel.SliderViewModel]) {
        
        // Create sliders for each color component and alpha.
        sliders.forEach { sliderData in
            let slider = CustomSlider(
                title: sliderData.title,
                min: sliderData.minValue,
                max: sliderData.maxValue,
                initValue: sliderData.initialValue
            )
            
            slider.valueChanged = { [weak self] value in
                guard let self else { return }
                
                self.interactor.sliderValueChanged(
                    WishMakerModel.Slider.ValueChangedRequest(
                        sliderType: sliderData.type,
                        value: value
                    )
                )
            }
            
            sliderStack.addArrangedSubview(slider)
        }
    }
    
    // Configures the Add Wish button.
    private func configureAddWishButton() {
        // Set initial button background color.
        addWishButton.backgroundColor = UIColor(hex: WishMakerConstants.whiteHex)
        // Set initial button text color.
        addWishButton.setTitleColor(UIColor(hex: WishMakerConstants.blackHex), for: .normal)
        
        addWishButton.setHeight(WishMakerConstants.buttonHeight)
        
        addWishButton.layer.cornerRadius = WishMakerConstants.buttonRadius
        // Add an action to the button, triggered when it is tapped.
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    // Configures the Schedule Wishes button.
    private func configureScheduleWishesButton() {
        // Set initial button background color.
        scheduleWishesButton.backgroundColor = UIColor(hex: WishMakerConstants.whiteHex)
        // Set initial button text color.
        scheduleWishesButton.setTitleColor(UIColor(hex: WishMakerConstants.blackHex), for: .normal)
        
        scheduleWishesButton.setHeight(WishMakerConstants.buttonHeight)
        
        scheduleWishesButton.layer.cornerRadius = WishMakerConstants.buttonRadius
        // Add an action to the button, triggered when it is tapped.
        scheduleWishesButton.addTarget(self, action: #selector(scheduleWishesButtonPressed), for: .touchUpInside)
    }
    
    // Configures the action stack containing additional buttons.
    private func configureActionStack() {
        actionStack.axis = .vertical
        view.addSubview(actionStack)
        actionStack.spacing = WishMakerConstants.actionStackSpacing
        
        configureAddWishButton()
        configureScheduleWishesButton()
        
        for button in [addWishButton, scheduleWishesButton] {
            actionStack.addArrangedSubview(button)
        }
        
        actionStack.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, WishMakerConstants.actionStackBottom)
        actionStack.pinHorizontal(to: view, WishMakerConstants.actionStackLeading)
    }
    
    private func createColor(from components: [CGFloat]) -> UIColor {
        return UIColor(
            red: components[0],
            green: components[1],
            blue: components[2],
            alpha: components[3]
        )
    }
}
