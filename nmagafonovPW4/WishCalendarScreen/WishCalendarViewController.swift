//
//  WishCalendarViewController.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 04.12.2024.
//

import UIKit

// A view controller for displaying and managing a calendar of wish events.
final class WishCalendarViewController: UIViewController {
    // MARK: - Enums
    enum WishCalendarConstants {
        // View settings.
        static let viewBackgroundColor: UIColor = .white
        
        // Collection settings.
        static let collectionTop: CGFloat = 5
        static let contentInset: UIEdgeInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        static let collectionMinimumInteritemSpacing: CGFloat = 0
        static let minimumLineSpacing: CGFloat = 0
        
        // Cells settings.
        static let cellsHeight: CGFloat = 120
        static let cellsPadding: CGFloat = 10
        
        // Plus Button settings.
        static let plusButtonHeight: CGFloat = 50
        static let plusButtonWidth: CGFloat = 50
        static let plusButtonTop: CGFloat = 10
        static let plusButtonTrailing: CGFloat = 10
        static let plusButtonTitle: String = "+"
        static let plusButtonTitleFontSize: CGFloat = 28
    }
    
    // MARK: - Variables
    // Bussiness logic.
    private let interactor: WishCalendarBusinessLogic
    
    // Events array.
    private var events: [WishEventModel] = []
    
    // UI Components.
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    // MARK: - Lifecycle
    init(interactor: WishCalendarBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(parameters:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        interactor.loadStart(WishCalendarModel.Start.Request())
    }
    
    // MARK: - Actions
    // Handles the action when the plus button is tapped.
    @objc private func plusButtonTapped() {
        // Build new screen.
        let wishEventCreationViewController = WishEventCreationAssembly.build()
        
        // Set delegate to update events.
        wishEventCreationViewController.delegate = self
        
        wishEventCreationViewController.modalPresentationStyle = .formSheet
        wishEventCreationViewController.modalTransitionStyle = .coverVertical
        
        present(wishEventCreationViewController, animated: true, completion: nil)
    }
    
    // MARK: - Public Methods
    // Updates the calendar view with a new list of events.
    func displayStart(_ viewModel: WishCalendarModel.Start.ViewModel) {
        events = viewModel.events
        collectionView.reloadData()
    }
    
    func displayOther() {}
    
    // MARK: - Private Methods
    private func configureUI() {
        view.backgroundColor = WishCalendarConstants.viewBackgroundColor
        
        configureCollection()
        configurePlusButton()
    }
    
    // Configures the collection view for displaying events.
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = WishCalendarConstants.contentInset
        
        if let layout = collectionView.collectionViewLayout as?
            UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = WishCalendarConstants.collectionMinimumInteritemSpacing
            layout.minimumLineSpacing = WishCalendarConstants.minimumLineSpacing
            layout.invalidateLayout()
        }
        
        collectionView.register(
            WishEventCell.self,
            forCellWithReuseIdentifier: WishEventCell.reuseIdentifier
        )
        
        view.addSubview(collectionView)
        
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, WishCalendarConstants.collectionTop)
    }
    
    // Configures the plus button for adding new events.
    private func configurePlusButton() {
        // Makes it Bar item.
        let plusButton = UIBarButtonItem(title: WishCalendarConstants.plusButtonTitle, style: .plain, target: self, action: #selector(plusButtonTapped))
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: WishCalendarConstants.plusButtonTitleFontSize, weight: .regular),
            .foregroundColor: UIColor.systemBlue
        ]
        
        plusButton.setTitleTextAttributes(attributes, for: .normal)
        plusButton.setTitleTextAttributes(attributes, for: .highlighted)
        
        navigationItem.rightBarButtonItem = plusButton
    }
}
// MARK: - Extensions
// Conforms to the WishEventCreationDelegate protocol to handle new event creation.
extension WishCalendarViewController: WishEventCreationDelegate {
    func didCreateNewEvent() {
        interactor.loadStart(WishCalendarModel.Start.Request())
    }
}

// MARK: - UICollectionViewDataSource
// Handles data source methods for the collection view.
extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView(
        _
        collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return events.count
    }
    
    func collectionView(
        _
        collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                        WishEventCell.reuseIdentifier, for: indexPath)
        
        guard let wishEventCell = cell as? WishEventCell else {
            return cell
        }
        
        wishEventCell.configure(with: events[indexPath.item])
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
// Handles layout methods for the collection view.
extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _
        collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.width - WishCalendarConstants.cellsPadding, height: WishCalendarConstants.cellsHeight)
    }
    
    func collectionView(
        _
        collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("Cell tapped at index \(indexPath.item)")
    }
}
