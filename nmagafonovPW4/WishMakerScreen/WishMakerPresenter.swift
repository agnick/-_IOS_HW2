//
//  WishMakerPresenter.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 03.12.2024.
//

import UIKit

final class WishMakerPresenter: WishMakerPresentationLogic {
    enum Constants {
        static let buttonIsInactiveText: String = "Show color slider"
        static let buttonActiveText: String = "Hide color slider"
        static let titleText: String = "WishMaker"
        static let descriptionText: String = "This app will bring you jou and will fulfill three of your wishes!\n   \u{22C5} The first wish is to change the background color."
        static let addWishButtonText: String = "My wishes"
        static let scheduleWishesButtonText: String = "Schedule wish granting"
    }
    
    weak var view: WishMakerViewController?
    
    func presentStart(_ response: WishMakerModel.Start.Response) {
        let sliders = response.sliders.map {
            WishMakerModel.SliderViewModel(title: $0.title, minValue: $0.minValue, maxValue: $0.maxValue, initialValue: $0.initialValue, type: $0.type
            )
        }
        
        view?.displayStart(WishMakerModel.Start.ViewModel( startButtonText: Constants.buttonActiveText, titleText: Constants.titleText, descriptionText: Constants.descriptionText, sliders: sliders, addWishButtonText: Constants.addWishButtonText, scheduleWishesButtonText: Constants.scheduleWishesButtonText))
    }
    
    func presentSliderVisibility(_ response: WishMakerModel.ToggleSlider.Response) {
        
        let buttonText = response.isSliderVisible ? Constants.buttonIsInactiveText : Constants.buttonActiveText
        
        view?.updateSliderVisibility(WishMakerModel.ToggleSlider.ViewModel(isSliderVisible: response.isSliderVisible, buttonText: buttonText))
    }
    
    func presentSliderValueChanged(_ response: WishMakerModel.Slider.ValueChangedResponse) {
        let viewModel = WishMakerModel.Slider.ValueChangedViewModel(
            backgroundColorComponents: response.backgroundColorComponents,
            titleColorComponents: response.titleColorComponents,
            descriptionColorComponents: response.descriptionColorComponents,
            buttonColorComponents: response.buttonColorComponents,
            buttonTextColorComponents: response.buttonTextColorComponents
        )
        
        view?.updateSliderColors(viewModel)
    }
    
    func routeTo(_ viewController: UIViewController) {
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
}
