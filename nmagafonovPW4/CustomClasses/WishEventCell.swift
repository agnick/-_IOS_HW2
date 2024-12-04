//
//  WishEventCell.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 04.12.2024.
//

import UIKit

final class WishEventCell: UICollectionViewCell {
    // MARK: - Enums
    enum WishEventCellConstants {
        // Wrap settings.
        static let wrapOffset: CGFloat = 5
        static let wrapCornerRadius: CGFloat = 10
        static let wrapBackgroundColor: UIColor = .lightGray
        
        // Title settings.
        static let titleFont: UIFont = .systemFont(ofSize: 20, weight: .semibold)
        static let titleTop: CGFloat = 5
        static let titleLeading: CGFloat = 5
        static let titleTextColor: UIColor = .black
        
        // Description settings.
        static let descriptionFont: UIFont = .systemFont(ofSize: 14, weight: .regular)
        static let descriptionBottom: CGFloat = 5
        static let descriptionLeading: CGFloat = 5
        static let descriptionTextColor: UIColor = .black
        
        // Start date settings.
        static let startDateFont: UIFont = .systemFont(ofSize: 22, weight: .regular)
        static let startDateTop: CGFloat = 5
        static let startDateTrailing: CGFloat = 5
        static let startDateTextColor: UIColor = .black
        
        // End date settings.
        static let endDateFont: UIFont = .systemFont(ofSize: 22, weight: .regular)
        static let endDateBottom: CGFloat = 5
        static let endDateTrailing: CGFloat = 5
        static let endDateTextColor: UIColor = .black
    }
    
    // MARK: - Variables
    static let reuseIdentifier: String = "WishEventCell"
    
    // UI components.
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureWrap()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStartDateLabel()
        configureEndDateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        startDateLabel.text = "Start Date: \(event.startDate)"
        endDateLabel.text = "End Date: \(event.endDate)"
    }
    
    // MARK: - Private methods
    private func configureWrap() {
        addSubview(wrapView)
        
        wrapView.pin(to: self, WishEventCellConstants.wrapOffset)
        wrapView.layer.cornerRadius = WishEventCellConstants.wrapCornerRadius
        wrapView.backgroundColor = WishEventCellConstants.wrapBackgroundColor
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.textColor = .black
        titleLabel.font = WishEventCellConstants.titleFont
        
        titleLabel.pinTop(to: wrapView, WishEventCellConstants.titleTop)
        titleLabel.pinLeft(to: wrapView, WishEventCellConstants.titleLeading)
    }
    
    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        
        descriptionLabel.textColor = WishEventCellConstants.descriptionTextColor
        descriptionLabel.font = WishEventCellConstants.descriptionFont
        
        descriptionLabel.pinBottom(to: wrapView, WishEventCellConstants.descriptionBottom)
        descriptionLabel.pinLeft(to: wrapView, WishEventCellConstants.descriptionLeading)
    }
    
    private func configureStartDateLabel() {
        addSubview(startDateLabel)
        
        startDateLabel.textColor = WishEventCellConstants.startDateTextColor
        startDateLabel.font = WishEventCellConstants.startDateFont
        
        startDateLabel.pinTop(to: wrapView, WishEventCellConstants.startDateTop)
        startDateLabel.pinRight(to: wrapView, WishEventCellConstants.startDateTrailing)
    }
    
    private func configureEndDateLabel() {
        addSubview(endDateLabel)
        
        endDateLabel.textColor = WishEventCellConstants.endDateTextColor
        endDateLabel.font = WishEventCellConstants.endDateFont
        
        endDateLabel.pinBottom(to: wrapView, WishEventCellConstants.endDateBottom)
        endDateLabel.pinRight(to: wrapView, WishEventCellConstants.endDateTrailing)
    }
}
