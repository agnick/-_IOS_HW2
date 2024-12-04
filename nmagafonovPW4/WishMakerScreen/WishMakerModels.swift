//
//  WishMakerModels.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 03.12.2024.
//

import UIKit

enum WishMakerModel {
    struct SliderData {
        let title: String
        let minValue: Double
        let maxValue: Double
        let initialValue: Double
        let type: Slider.SliderType
    }
    
    struct SliderViewModel {
        let title: String
        let minValue: Double
        let maxValue: Double
        let initialValue: Double
        let type: Slider.SliderType
    }
    
    enum Start {
        struct Request {}
        
        struct Response {
            let sliders: [SliderData]
        }
        
        struct ViewModel {
            let startButtonText: String
            let titleText: String
            let descriptionText: String
            let sliders: [SliderViewModel]
            let addWishButtonText: String
            let scheduleWishesButtonText: String
        }
    }
    
    enum ToggleSlider {
        struct Request {}
        
        struct Response {
            let isSliderVisible: Bool
        }
        
        struct ViewModel {
            let isSliderVisible: Bool
            let buttonText: String
        }
    }
    
    enum Slider {
        enum SliderType: String {
            case red = "Red"
            case green = "Green"
            case blue = "Blue"
            case alpha = "Alpha"
        }
        
        struct ValueChangedRequest {
            let sliderType: SliderType
            let value: CGFloat
        }
        
        struct ValueChangedResponse {
            let backgroundColorComponents: [CGFloat]
            let titleColorComponents: [CGFloat]
            let descriptionColorComponents: [CGFloat]
            let buttonColorComponents: [CGFloat]
            let buttonTextColorComponents: [CGFloat]
        }
        
        struct ValueChangedViewModel {
            let backgroundColorComponents: [CGFloat]
            let titleColorComponents: [CGFloat]
            let descriptionColorComponents: [CGFloat]
            let buttonColorComponents: [CGFloat]
            let buttonTextColorComponents: [CGFloat]
        }
    }
    
    enum Navigation {
        struct Request {
            // Пытался сделать модели независимы от UIKit, но не вышло(
            let destination: UIViewController
        }
    }
}
