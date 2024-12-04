//
//  WishEventCreationView.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 04.12.2024.
//

import UIKit

final class WishEventCreationViewController: UIViewController {
    // MARK: - Enums
    private enum WishEventCreationConstants {
        // Text fields settings.
        static let textFieldHeight: CGFloat = 40
        
        // Margins and components sizes.
        static let horizontalMargin: CGFloat = 16
        static let verticalSpacing: CGFloat = 12
        static let pickerHeight: CGFloat = 150
        static let buttonHeight: CGFloat = 44
        
        // Font sizes.
        static let titleFontSize: CGFloat = 18
        static let buttonFontSize: CGFloat = 16
        
        // Background colors.
        static let viewBackgroundColor: UIColor = .white
        static let pickerBackgroundColor: UIColor = .white
        
        // Data pickers settings.
        static let maxDays: Int = 712
        static let datesToShow: Int = 1
    }
    
    // MARK: - Variables
    // Bussiness logic.
    private let interactor: WishEventCreationBusinessLogic
    weak var delegate: WishEventCreationDelegate?
    
    // For storing start and end date options.
    private var startDateComponents: [String] = []
    private var endDateComponents: [String] = []
    
    // UI Components.
    private let titleTextField = UITextField()
    private let descriptionTextField = UITextField()
    private let startDatePicker = UIPickerView()
    private let endDatePicker = UIPickerView()
    private let cancelButton = UIButton(type: .system)
    private let saveButton = UIButton(type: .system)
    private let stackView = UIStackView()
    
    // MARK: - Lifecycle
    init(interactor: WishEventCreationBusinessLogic) {
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
        
        // Initialize picker data.
        setupPickerData()
        setupPickerDelegates()
    }
    
    // MARK: - Actions
    // Handles the cancel button tap, dismissing the view.
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    // Handles the save button tap, validating and sending data to the interactor.
    @objc private func saveButtonTapped() {
        guard let title = titleTextField.text, !title.isEmpty,
              let description = descriptionTextField.text, !description.isEmpty else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        
        guard let startDate = formatter.date(from: startDateComponents[startDatePicker.selectedRow(inComponent: 0)]),
              let endDate = formatter.date(from: endDateComponents[endDatePicker.selectedRow(inComponent: 0)]) else { return }
        
        // Make request.
        let request = WishEventCreationModel.Other.Request(title: title, description: description, startDate: startDate, endDate: endDate)
        
        interactor.loadOther(request)
        
        delegate?.didCreateNewEvent()
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Public Methods
    func displayStart() {}
    
    // Displays the result of saving an event, showing a success or error message.
    func displayOther(_ viewModel: WishEventCreationModel.Other.ViewModel) {
        if viewModel.success {
            delegate?.didCreateNewEvent()
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: viewModel.message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            present(alert, animated: true)
        }
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        view.backgroundColor = WishEventCreationConstants.viewBackgroundColor
        configureTextFields()
        configurePickers()
        configureButtons()
        configureStackView()
    }
    
    // Configures the text fields for title and description input.
    private func configureTextFields() {
        // Title TextField.
        titleTextField.placeholder = "Введите заголовок"
        titleTextField.borderStyle = .roundedRect
        titleTextField.setHeight(WishEventCreationConstants.textFieldHeight)
        
        // Description TextField.
        descriptionTextField.placeholder = "Введите описание"
        descriptionTextField.borderStyle = .roundedRect
        descriptionTextField.setHeight(WishEventCreationConstants.textFieldHeight)
    }
    
    // Configures the date pickers for selecting start and end dates.
    private func configurePickers() {
        // Start Date Picker.
        startDatePicker.backgroundColor = WishEventCreationConstants.pickerBackgroundColor
        startDatePicker.setHeight(WishEventCreationConstants.pickerHeight)
        
        // End Date Picker.
        endDatePicker.backgroundColor = WishEventCreationConstants.pickerBackgroundColor
        endDatePicker.setHeight(WishEventCreationConstants.pickerHeight)
    }
    
    // Configures the cancel and save buttons.
    private func configureButtons() {
        // Cancel Button.
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: WishEventCreationConstants.buttonFontSize, weight: .regular)
        cancelButton.setTitleColor(.systemBlue, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        // Save Button.
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: WishEventCreationConstants.buttonFontSize, weight: .regular)
        saveButton.setTitleColor(.systemBlue, for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    // Configures the main stack view layout.
    private func configureStackView() {
        // Configure StackView.
        stackView.axis = .vertical
        stackView.spacing = WishEventCreationConstants.verticalSpacing
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        // Buttons.
        let buttonStack = UIStackView(arrangedSubviews: [cancelButton, saveButton])
        buttonStack.axis = .horizontal
        buttonStack.distribution = .equalSpacing
        
        view.addSubview(buttonStack)
        buttonStack.pinTop(to: view.safeAreaLayoutGuide.topAnchor, WishEventCreationConstants.verticalSpacing)
        buttonStack.pinHorizontal(to: view, WishEventCreationConstants.horizontalMargin)
        
        // TextFields.
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(descriptionTextField)
        
        // Start Date Label and Picker.
        let startDateLabel = UILabel()
        startDateLabel.text = "Select start date"
        startDateLabel.font = UIFont.systemFont(ofSize: WishEventCreationConstants.titleFontSize, weight: .bold)
        stackView.addArrangedSubview(startDateLabel)
        stackView.addArrangedSubview(startDatePicker)
        
        // End Date Label and Picker.
        let endDateLabel = UILabel()
        endDateLabel.text = "Select end date"
        endDateLabel.font = UIFont.systemFont(ofSize: WishEventCreationConstants.titleFontSize, weight: .bold)
        stackView.addArrangedSubview(endDateLabel)
        stackView.addArrangedSubview(endDatePicker)
        
        // Add StackView to View.
        view.addSubview(stackView)
        
        // Layout.
        stackView.pinTop(to: buttonStack.bottomAnchor, WishEventCreationConstants.verticalSpacing)
        stackView.pinHorizontal(to: view, WishEventCreationConstants.horizontalMargin)
    }
    
    // Initializes the date picker data with a range of dates.
    private func setupPickerData() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        
        let startDate = Date()
        startDateComponents = (0..<WishEventCreationConstants.maxDays).map { dayOffset in
            let date = Calendar.current.date(byAdding: .day, value: dayOffset, to: startDate)!
            return formatter.string(from: date)
        }
        
        endDateComponents = startDateComponents
    }
    
    // Sets up the delegate and data source for the date pickers.
    private func setupPickerDelegates() {
        startDatePicker.delegate = self
        startDatePicker.dataSource = self
        endDatePicker.delegate = self
        endDatePicker.dataSource = self
    }
}

// MARK: - Extensions
extension WishEventCreationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return WishEventCreationConstants.datesToShow
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == startDatePicker {
            return startDateComponents.count
        } else {
            return endDateComponents.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == startDatePicker {
            return startDateComponents[row]
        } else {
            return endDateComponents[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == startDatePicker {
            print("Selected Start Date: \(startDateComponents[row])")
        } else {
            print("Selected End Date: \(endDateComponents[row])")
        }
    }
}
