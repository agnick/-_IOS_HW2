//
//  WishStoringViewController.swift
//  nmagafonovPW2
//
//  Created by Никита Агафонов on 06.11.2024.
//

import UIKit

final class WishStoringViewController: UIViewController {
    // MARK: - Enums
    enum Constants {
        // Strings.
        static let goBackButtonTitle: String = "Go back <-"
        static let whiteHex: String = "#FFFFFF"
        static let blackHex: String = "#000000"
        static let alertTitle: String = "Edit Wish"
        static let alertMessage: String = "Modify your wish:"
        static let alertSave: String = "Save"
        static let alertCancel: String = "Cancel"
        static let editInstuctionsText: String = "Click on wish to edit it"
        
        // Keys
        static let wishesKey: String = "savedWishes"
        
        // Go back button positioning.
        static let goBackButtonRadius: CGFloat = 10
        static let goBackButtonLeading: CGFloat = 20
        static let goBackButtonTop: CGFloat = 10
        static let goBackButtonWidth: CGFloat = 100
        
        // Edit instruction spreferences.
        static let editInstructionFont: CGFloat = 16
        
        // Edit instruction positioning.
        static let editInstructionTop: CGFloat = 10
        static let editInstructionTrailing: CGFloat = 20
        
        // Table positioning.
        static let tableCornerRadius: CGFloat = 10
        static let tableOffset: CGFloat = 10
        static let tableTop: CGFloat = 10
        static let tableBottom: CGFloat = 10
        
        // Table preferences
        static let numberOfSects: Int = 2;
        static let noWishes: Int = 0;
        static let oneWish: Int = 1;
    }
    
    // MARK: - Variables
    // UI Components.
    private let goBackButton: UIButton = UIButton(type: .system)
    private let editInstruction: UILabel = UILabel()
    private let table: UITableView = UITableView(frame: .zero)
    private let defaults = UserDefaults.standard
    private var wishArray: [String] = []
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        // Loading saved wishes.
        loadWishes()
        // Configure UI.
        configureUI()
    }
    
    // MARK: - Actions
    // Closes the current wish screen.
    @objc private func goBackButtonPressed() {
        self.dismiss(animated: true)
    }
    
    // MARK: - Private methods
    // Configures the overall UI of the view controller.
    private func configureUI() {
        view.backgroundColor = UIColor(hex: Constants.blackHex)
        
        configureGoBackButton()
        configureEditInstruction()
        configureTable()
    }
    
    private func configureGoBackButton() {
        view.addSubview(goBackButton)
        
        // Set button corner radius.
        goBackButton.layer.cornerRadius = Constants.goBackButtonRadius
        // Set initial button title.
        goBackButton.setTitle(Constants.goBackButtonTitle, for: .normal)
        // Set initial button background color.
        goBackButton.backgroundColor = UIColor(hex: Constants.whiteHex)
        // Set initial button text color.
        goBackButton.setTitleColor(UIColor(hex: Constants.blackHex), for: .normal)
        
        goBackButton.addTarget(self, action: #selector(goBackButtonPressed), for: .touchUpInside)
        
        // Set constraints to position the button.
        goBackButton.pinTop(to: view, Constants.goBackButtonTop)
        goBackButton.pinLeft(to: view, Constants.goBackButtonLeading)
        goBackButton.setWidth(Constants.goBackButtonWidth)
    }
    
    private func configureEditInstruction() {
        view.addSubview(editInstruction)
        
        // Set the label's text to display instructions.
        editInstruction.text = Constants.editInstuctionsText
        // Center the text within the label.
        editInstruction.textAlignment = .center
        // Set font size.
        editInstruction.font = UIFont.systemFont(ofSize: Constants.editInstructionFont)
        // Using an extension to change color with a hex value.
        editInstruction.textColor = UIColor(hex: Constants.whiteHex)
        
        // Set constraints to position the label.
        editInstruction.pinTop(to: view, Constants.editInstructionTop)
        editInstruction.pinRight(to: view, Constants.editInstructionTrailing)
    }
    
    private func configureTable() {
        view.addSubview(table)
        
        table.backgroundColor = .red
        
        // Set the data source and delegate for the table view.
        table.dataSource = self
        table.delegate = self
        
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        
        table.isScrollEnabled = true // Ensure scrolling is enabled
        table.alwaysBounceVertical = true // Allows bounce effect when scrolling to improve UX
        
        // Set constraints to position the table view.
        table.pinTop(to: goBackButton.bottomAnchor, Constants.tableTop)
        table.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, Constants.tableBottom)
        table.pinLeft(to: view, 20)
        table.pinRight(to: view, 20)
        
        // Register the cell classes for reuse.
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
    
    // Saves the current wishArray to UserDefaults.
    private func saveWishes() {
        defaults.set(wishArray, forKey: Constants.wishesKey)
    }
    
    // Loads saved wishes from UserDefaults into wishArray.
    private func loadWishes() {
        if let savedWishes = defaults.array(forKey: Constants.wishesKey) as? [String] {
            wishArray = savedWishes
        }
    }
}

// MARK: - Extensions
extension WishStoringViewController: UITableViewDataSource {
    // Specifies the number of sections in the table view.
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSects;
    }
    
    // Enables swipe-to-delete functionality in the wish section (section 1).
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && indexPath.section == Constants.oneWish {
            // Remove the wish from the array.
            wishArray.remove(at: indexPath.row)
            // Save the updated array to UserDefaults.
            saveWishes()
            // Delete the row from the table view.
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Returns the number of rows in each section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Constants.noWishes:
            return Constants.oneWish
        case Constants.oneWish:
            return wishArray.count
        default:
            return Constants.noWishes
        }
    }
    
    // Configures and returns the cell for a specific index path.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == Constants.noWishes {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath) as! AddWishCell
            // Closure to add a new wish.
            cell.addWish = { [weak self] wish in
                self?.wishArray.append(wish)
                self?.saveWishes()
                self?.table.reloadData()
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath) as! WrittenWishCell
            // Configure the cell with the wish.
            cell.configure(with: wishArray[indexPath.row])
            return cell
        }
    }
}

extension WishStoringViewController: UITableViewDelegate {
    // Handles the selection of a row, allowing the user to edit a wish.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == Constants.oneWish else { return }
        let currentWish = wishArray[indexPath.row]
        
        // Show an alert for editing the selected wish.
        let alert = UIAlertController(title: Constants.alertTitle, message: Constants.alertMessage, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = currentWish
        }
        
        // Define a save action to update the wish.
        let saveAction = UIAlertAction(title: Constants.alertSave, style: .default) { [weak self] _ in
            guard let self = self, let updatedWish = alert.textFields?.first?.text, !updatedWish.isEmpty else { return }
            self.wishArray[indexPath.row] = updatedWish
            self.saveWishes()
            self.table.reloadRows(at: [indexPath], with: .automatic)
        }
        
        // Define a cancel action to dismiss the alert without changes.
        let cancelAction = UIAlertAction(title: Constants.alertCancel, style: .cancel, handler: nil)
        
        // Add actions to the alert and present it.
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
