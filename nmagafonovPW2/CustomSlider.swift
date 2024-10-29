//
//  CustomSlider.swift
//  nmagafonovPW2
//
//  Created by Никита Агафонов on 29.10.2024.
//

import UIKit

final class CustomSlider: UIView {
    // MARK: - Enums
    enum Constants {
        // Strings.
        static let whiteHex: String = "#FFFFFF"
        
        // TitleView positioning.
        static let titleViewTop: CGFloat = 10
        static let titleViewLeading: CGFloat = 20
        
        // ValueView positioning.
        static let valueViewLeading: CGFloat = 20
        
        // Slider positioning.
        static let sliderBottom: CGFloat = 10
        static let sliderLeading: CGFloat = 20
    }
    
    // MARK: - Variables
    // Closure.
    var valueChanged: ((Double) -> Void)?
    
    // UI Components.
    var slider = UISlider()
    var titleView = UILabel()
    var valueView = UILabel()
    
    // MARK: - Lifecycle
    init(title: String, min: Double, max: Double, initValue: Double) {
        super.init(frame: .zero)
        
        // Set title text.
        titleView.text = title
        
        // Set slider min, max values.
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        // Set slider value to custom initial.
        slider.value = Float(initValue)
        // // Add a target-action to handle value changes of the slider.
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        // Set current value to custom initial.
        valueView.text = "\(initValue)"
        
        // Set up the UI components.
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func configureUI() {
        // Adding subviews.
        addSubview(slider)
        addSubview(valueView)
        addSubview(titleView)
        
        // Set background to white using custom hex initializer.
        backgroundColor = UIColor(hex: Constants.whiteHex)
        
        // Using UIView+Pin to set constraints for the title.
        titleView.pinCenterX(to: self)
        titleView.pinTop(to: self, Constants.titleViewTop)
        titleView.pinLeft(to: self, Constants.titleViewLeading)
        
        // Using UIView+Pin to set constraints for the current value.
        valueView.pinCenterX(to: self)
        valueView.pinLeft(to: self, Constants.valueViewLeading)
        valueView.pinTop(to: titleView.bottomAnchor)
        
        // Using UIView+Pin to set constraints for the slider.
        slider.pinTop(to: valueView.bottomAnchor)
        slider.pinCenterX(to: self)
        slider.pinBottom(to: self, Constants.sliderBottom)
        slider.pinLeft(to: self, Constants.sliderLeading)
    }
    
    // Called when the slider value changes. Updates the callback and displays the new value.
    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
        valueView.text = "\(slider.value)"
    }
}
