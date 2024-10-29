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
    var valueChanged: ((Double) -> Void)?
    
    var slider = UISlider()
    var titleView = UILabel()
    var valueView = UILabel()
    
    // MARK: - Lifecycle
    init(title: String, min: Double, max: Double, defaultValue: Double) {
        super.init(frame: .zero)
        titleView.text = title
        valueView.text = "\(min)"
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.value = Float(defaultValue)
        valueView.text = "\(defaultValue)"
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func configureUI() {
        addSubview(slider)
        addSubview(valueView)
        addSubview(titleView)
        
        backgroundColor = UIColor(hex: Constants.whiteHex)
        
        titleView.pinCenterX(to: self)
        titleView.pinTop(to: self, Constants.titleViewTop)
        titleView.pinLeft(to: self, Constants.titleViewLeading)
        
        valueView.pinCenterX(to: self)
        valueView.pinLeft(to: self, Constants.valueViewLeading)
        valueView.pinTop(to: titleView.bottomAnchor)
        
        slider.pinTop(to: valueView.bottomAnchor)
        slider.pinCenterX(to: self)
        slider.pinBottom(to: self, Constants.sliderBottom)
        slider.pinLeft(to: self, Constants.sliderLeading)
    }
    
    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
        valueView.text = "\(slider.value)"
    }
}
