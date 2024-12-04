//
//  WishMakerProtocols.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 03.12.2024.
//

import UIKit

protocol WishMakerBusinessLogic {
    func loadStart(_ request: WishMakerModel.Start.Request)
    func toggleSliderVisibility(_ request: WishMakerModel.ToggleSlider.Request)
    func sliderValueChanged(_ request: WishMakerModel.Slider.ValueChangedRequest)
    
    func routeTo(_ request: WishMakerModel.Navigation.Request)
}

protocol WishMakerPresentationLogic {
    func presentStart(_ response: WishMakerModel.Start.Response)
    func presentSliderVisibility(_ response: WishMakerModel.ToggleSlider.Response)
    func presentSliderValueChanged(_ response: WishMakerModel.Slider.ValueChangedResponse)
    
    func routeTo(_ viewController: UIViewController)
}
