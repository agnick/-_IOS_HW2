//
//  AddWishCell.swift
//  nmagafonovPW2
//
//  Created by Никита Агафонов on 06.11.2024.
//

import UIKit

final class AddWishCell: UITableViewCell {
    // MARK: - Enums
    enum Constants {
        // Strings.
        static let addButtonTitle: String = "Add Wish"
        
        // Wish text view preferences.
        static let wishTextViewRadius: CGFloat = 8
        static let wishTextViewBorderWidth: CGFloat = 1
        static let wishTextViewFontSize: CGFloat = 16
        
        // Wish text view positioning.
        static let wishTextViewLeading: CGFloat = 16
        static let wishTextViewTrailing: CGFloat = 16
        static let wishTextViewTop: CGFloat = 8
        static let wishTextViewHeight: CGFloat = 80
        
        // Add button positioning.
        static let addButtonTop: CGFloat = 8
        static let addButtonBottom: CGFloat = 8
    }
    
    // MARK: - Variables
    static let reuseId: String = "AddWishCell"
    var addWish: ((String) -> Void)?
    
    // UI components.
    private let wishTextView: UITextView = UITextView()
    private let addButton: UIButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc private func addButtonPressed() {
        guard let text = wishTextView.text, !text.isEmpty else { return }
        // Call the closure to add the wish.
        addWish?(text)
        // Clear the text field.
        wishTextView.text = ""
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        // Configure the text view.
        wishTextView.layer.cornerRadius = Constants.wishTextViewRadius
        wishTextView.layer.borderWidth = Constants.wishTextViewBorderWidth
        wishTextView.layer.borderColor = UIColor.lightGray.cgColor
        wishTextView.textColor = .gray
        wishTextView.font = UIFont.systemFont(ofSize: Constants.wishTextViewFontSize)
        
        addButton.setTitle(Constants.addButtonTitle, for: .normal)
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        
        contentView.addSubview(wishTextView)
        contentView.addSubview(addButton)
        
        // Set constraints to position elements.
        wishTextView.pinLeft(to: contentView, Constants.wishTextViewLeading)
        wishTextView.pinRight(to: contentView, Constants.wishTextViewTrailing)
        wishTextView.pinTop(to: contentView, Constants.wishTextViewTop)
        wishTextView.setHeight(Constants.wishTextViewHeight)
        
        addButton.pinTop(to: wishTextView.bottomAnchor, Constants.addButtonTop)
        addButton.pinCenterX(to: contentView)
        addButton.pinBottom(to: contentView, Constants.addButtonBottom)
    }
}
