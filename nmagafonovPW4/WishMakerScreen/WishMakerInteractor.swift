//
//  WishMakerInteractor.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 03.12.2024.
//

import CoreFoundation

final class WishMakerInteractor: WishMakerBusinessLogic {
    enum Constants {
        static let minSliderValue: CGFloat = 0
        static let maxSliderValue: CGFloat = 1
        static let sliderInitialValueColor: CGFloat = 0
        static let sliderInitialValueAlpha: CGFloat = 1
    }
    
    private let presenter: WishMakerPresentationLogic
    
    // Tracks the visibility state of the sliders.
    private var isSliderVisible: Bool = false
    
    // Stores the current values of each slider type.
    private var sliderValues: [WishMakerModel.Slider.SliderType: CGFloat] = [
        .red: Constants.sliderInitialValueColor,
        .green: Constants.sliderInitialValueColor,
        .blue: Constants.sliderInitialValueColor,
        .alpha: Constants.sliderInitialValueAlpha
    ]
    
    init (presenter: WishMakerPresentationLogic) {
        self.presenter = presenter
    }
    
    // Loads initial data for the WishMaker screen.
    func loadStart(_ request: WishMakerModel.Start.Request) {
        let sliders = [
            WishMakerModel.SliderData(title: "Red", minValue: Constants.minSliderValue, maxValue: Constants.maxSliderValue, initialValue: Constants.sliderInitialValueColor, type: .red),
            WishMakerModel.SliderData(title: "Green", minValue: Constants.minSliderValue, maxValue: Constants.maxSliderValue, initialValue: Constants.sliderInitialValueColor, type: .green),
            WishMakerModel.SliderData(title: "Blue", minValue: Constants.minSliderValue, maxValue: Constants.maxSliderValue, initialValue: Constants.sliderInitialValueColor, type: .blue),
            WishMakerModel.SliderData(title: "Alpha", minValue: Constants.minSliderValue, maxValue: Constants.maxSliderValue, initialValue: Constants.sliderInitialValueAlpha, type: .alpha)
        ]
        
        presenter.presentStart(WishMakerModel.Start.Response(sliders: sliders))
    }
    
    // Toggles the visibility of sliders.
    func toggleSliderVisibility(_ request: WishMakerModel.ToggleSlider.Request) {
        // Changes slider visibility to false is true and to true if false. Синтаксический сахар :)
        isSliderVisible.toggle()
        
        presenter.presentSliderVisibility(WishMakerModel.ToggleSlider.Response(isSliderVisible: isSliderVisible))
    }
    
    // Handles slider value changes and updates UI elements accordingly.
    func sliderValueChanged(_ request: WishMakerModel.Slider.ValueChangedRequest) {
        // Updates the value of the specified slider.
        sliderValues[request.sliderType] = request.value
        
        // Retrieves current color components.
        let red = sliderValues[.red] ?? Constants.sliderInitialValueColor
        let green = sliderValues[.green] ?? Constants.sliderInitialValueColor
        let blue = sliderValues[.blue] ?? Constants.sliderInitialValueColor
        let alpha = sliderValues[.alpha] ?? Constants.sliderInitialValueAlpha
        
        // Calculates inverted color components.
        let invertedRed = Constants.maxSliderValue - red
        let invertedGreen = Constants.maxSliderValue - green
        let invertedBlue = Constants.maxSliderValue - blue
        
        // Prepares the response with updated color components.
        let response = WishMakerModel.Slider.ValueChangedResponse(
            backgroundColorComponents: [red, green, blue, alpha],
            titleColorComponents: [invertedRed, invertedGreen, invertedBlue, Constants.sliderInitialValueAlpha],
            descriptionColorComponents: [invertedRed, invertedGreen, invertedBlue, Constants.sliderInitialValueAlpha],
            buttonColorComponents: [invertedRed, invertedGreen, invertedBlue, Constants.sliderInitialValueAlpha],
            buttonTextColorComponents: [red, green, blue, Constants.sliderInitialValueAlpha]
        )
        
        presenter.presentSliderValueChanged(response)
    }
    
    func routeTo(_ request: WishMakerModel.Navigation.Request) {
        presenter.routeTo(request.destination)
    }
}
