//
//  WishStoringViewController.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 03.12.2024.
//

import UIKit

final class WishStoringViewController: UIViewController {
    // MARK: - Enums
    enum Constants {
        // Strings.
        static let whiteHex: String = "#FFFFFF"
        static let blackHex: String = "#000000"
        static let alertTitle: String = "Edit Wish"
        static let alertMessage: String = "Modify your wish:"
        static let alertSave: String = "Save"
        static let alertCancel: String = "Cancel"
        static let instructionText: String = "Click on wish to edit it"
        
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
        
        // tableView positioning.
        static let tableCornerRadius: CGFloat = 10
        static let tableOffset: CGFloat = 10
        static let tableTop: CGFloat = 10
        static let tableBottom: CGFloat = 10
        static let tableLeft: CGFloat = 20
        static let tableRight: CGFloat = 20
        
        // tableView preferences
        static let numberOfSects: Int = 2;
        static let noWishes: Int = 0;
        static let oneWish: Int = 1;
    }
    
    // MARK: - Variables
    private let interactor: WishStoringBusinessLogic
    private var wishes: [String] = []
    
    // UI Components.
    private let instructionLabel: UILabel = UILabel()
    private let tableView: UITableView = UITableView(frame: .zero)
    
    
    // MARK: - Lifecycle
    init(interactor: WishStoringBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(parameters:) has not been implemented")
    }
    
    override func viewDidLoad() {
        // Configure UI.
        configureUI()
        interactor.loadWishes(WishStoringModel.Start.Request())
    }
    
    // MARK: - Public methods
    func displayWishes(_ viewModel: WishStoringModel.Start.ViewModel) {
        self.wishes = viewModel.wishes
        tableView.reloadData()
    }
    
    // MARK: - Private methods
    // Configures the overall UI of the view controller.
    private func configureUI() {
        view.backgroundColor = UIColor(hex: Constants.blackHex)
        
        configureInstructionLabel()
        configureTableView()
    }
    
    
    private func configureInstructionLabel() {
        view.addSubview(instructionLabel)
        
        // Set the label's text to display instructions.
        instructionLabel.text = Constants.instructionText
        // Center the text within the label.
        instructionLabel.textAlignment = .center
        // Set font size.
        instructionLabel.font = UIFont.systemFont(ofSize: Constants.editInstructionFont)
        // Using an extension to change color with a hex value.
        instructionLabel.textColor = UIColor(hex: Constants.whiteHex)
        
        // Set constraints to position the label.
        instructionLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.editInstructionTop)
        instructionLabel.pinRight(to: view, Constants.editInstructionTrailing)
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.backgroundColor = .darkGray
        
        // Set the data source and delegate for the tableView view.
        tableView.dataSource = self
        tableView.delegate = self
        
        // Register the cell classes for reuse.
        tableView.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        tableView.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
        
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = Constants.tableCornerRadius
        
        // Ensure scrolling is enabled.
        tableView.isScrollEnabled = true
        // Allows bounce effect when scrolling to improve UX.
        tableView.alwaysBounceVertical = true
        
        // Set constraints to position the tableView view.
        tableView.pinTop(to: instructionLabel.bottomAnchor, Constants.tableTop)
        tableView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, Constants.tableBottom)
        tableView.pinLeft(to: view, Constants.tableLeft)
        tableView.pinRight(to: view, Constants.tableRight)
    }
}

// MARK: - Extensions
extension WishStoringViewController: UITableViewDataSource {
    // Specifies the number of sections in the tableView view.
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSects;
    }
    
    // Enables swipe-to-delete functionality in the wish section (section 1).
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            interactor.deleteWish(WishStoringModel.DeleteWish.Request(index: indexPath.row))
        }
    }
    
    // Returns the number of rows in each section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == Constants.noWishes ? Constants.oneWish : wishes.count
    }
    
    // Configures and returns the cell for a specific index path.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == Constants.noWishes {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath) as! AddWishCell
            
            cell.addWish = { [weak self] wish in
                guard let self else { return }
                self.interactor.addWish(WishStoringModel.AddWish.Request(wish: wish))
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath) as! WrittenWishCell
            
            cell.configure(with: wishes[indexPath.row])
            
            return cell
        }
    }
}

extension WishStoringViewController: UITableViewDelegate {
    // Handles the selection of a row, allowing the user to edit a wish.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentWish = wishes[indexPath.row]
        let alert = UIAlertController(
            title: Constants.alertTitle,
            message: Constants.alertMessage,
            preferredStyle: .alert
        )
        
        alert.addTextField { textField in
            textField.text = currentWish
        }
        
        let saveAction = UIAlertAction(title: Constants.alertSave, style: .default) { [weak self] _ in
            guard let self = self, let updatedWish = alert.textFields?.first?.text, !updatedWish.isEmpty else { return }
            self.interactor.editWish(WishStoringModel.EditWish.Request(index: indexPath.row, wish: updatedWish))
        }
        let cancelAction = UIAlertAction(title: Constants.alertCancel, style: .cancel)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}
