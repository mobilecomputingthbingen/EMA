//
//  PflanzenschutzViewController.swift
//  EMA
//
//  Created by Veli Tasyurdu on 03.08.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import UIKit

class PflanzenschutzViewController: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIStackView!
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.text = "Datum"
        return label
    }()
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        return picker
    }()
    let fieldLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.text = "Feld"
        return label
    }()
    lazy var fieldPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        return picker
    }()
    let userLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.text = "Benutzer"
        return label
    }()
    let userTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.text = "benutzername"
        return textField
    }()
    let workingHourLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.text = "Arbeitszeit (Stunden)"
        return label
    }()
    lazy var workingHourPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        return picker
    }()
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.text = "Pflantenschutzmittel Kategorie"
        return label
    }()
    lazy var categoryPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        return picker
    }()
    let againstLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.text = "Pflantenschutzmittel Kategorie"
        return label
    }()
    let againstTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.text = "benutzername"
        return textField
    }()
    let protectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.text = "Pflantenschutzmittel Kategorie"
        return label
    }()
    let protectionTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.text = "benutzername"
        return textField
    }()
    let dueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.text = "Pflantenschutzmittel Kategorie"
        return label
    }()
    let dueTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.text = "benutzername"
        return textField
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    private func setup() {
        mainView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: dateLabel, attribute: .left, relatedBy: .equal, toItem: mainView, attribute: .left, multiplier: 1.0, constant: 16).isActive = true  // swiftlint:disable:this line_length
        NSLayoutConstraint(item: dateLabel, attribute: .top, relatedBy: .equal, toItem: mainView, attribute: .top, multiplier: 1.0, constant: 16).isActive = true  // swiftlint:disable:this line_length
        mainView.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: datePicker, attribute: .left, relatedBy: .equal, toItem: mainView, attribute: .left, multiplier: 1.0, constant: 16).isActive = true  // swiftlint:disable:this line_length
        NSLayoutConstraint(item: datePicker, attribute: .top, relatedBy: .equal, toItem: dateLabel, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true  // swiftlint:disable:this line_length
        mainView.addSubview(fieldLabel)
        fieldLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: fieldLabel, attribute: .left, relatedBy: .equal, toItem: mainView, attribute: .left, multiplier: 1.0, constant: 16).isActive = true  // swiftlint:disable:this line_length
        NSLayoutConstraint(item: fieldLabel, attribute: .top, relatedBy: .equal, toItem: datePicker, attribute: .bottom, multiplier: 1.0, constant: 16).isActive = true  // swiftlint:disable:this line_length
        mainView.addSubview(fieldPicker)
        fieldPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: fieldPicker, attribute: .left, relatedBy: .equal, toItem: mainView, attribute: .left, multiplier: 1.0, constant: 16).isActive = true  // swiftlint:disable:this line_length
        NSLayoutConstraint(item: fieldPicker, attribute: .top, relatedBy: .equal, toItem: fieldLabel, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true  // swiftlint:disable:this line_length
        mainView.addSubview(userLabel)
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: userLabel, attribute: .left, relatedBy: .equal, toItem: mainView, attribute: .left, multiplier: 1.0, constant: 16).isActive = true  // swiftlint:disable:this line_length
        NSLayoutConstraint(item: userLabel, attribute: .top, relatedBy: .equal, toItem: fieldPicker, attribute: .bottom, multiplier: 1.0, constant: 16).isActive = true  // swiftlint:disable:this line_length
        mainView.addSubview(userTextField)
        userTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: userTextField, attribute: .left, relatedBy: .equal, toItem: mainView, attribute: .left, multiplier: 1.0, constant: 16).isActive = true  // swiftlint:disable:this line_length
        NSLayoutConstraint(item: userTextField, attribute: .top, relatedBy: .equal, toItem: userLabel, attribute: .bottom, multiplier: 1.0, constant: 16).isActive = true  // swiftlint:disable:this line_length
        mainView.addSubview(workingHourLabel)
        workingHourLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: workingHourLabel, attribute: .left, relatedBy: .equal, toItem: mainView, attribute: .left, multiplier: 1.0, constant: 16).isActive = true  // swiftlint:disable:this line_length
        NSLayoutConstraint(item: workingHourLabel, attribute: .top, relatedBy: .equal, toItem: userTextField, attribute: .bottom, multiplier: 1.0, constant: 16).isActive = true  // swiftlint:disable:this line_length
        mainView.addSubview(workingHourPicker)
        workingHourPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: workingHourPicker, attribute: .left, relatedBy: .equal, toItem: mainView, attribute: .left, multiplier: 1.0, constant: 16).isActive = true  // swiftlint:disable:this line_length
        NSLayoutConstraint(item: workingHourPicker, attribute: .top, relatedBy: .equal, toItem: workingHourLabel, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true  // swiftlint:disable:this line_length
        mainView.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: categoryLabel, attribute: .left, relatedBy: .equal, toItem: mainView, attribute: .left, multiplier: 1.0, constant: 16).isActive = true  // swiftlint:disable:this line_length
        NSLayoutConstraint(item: categoryLabel, attribute: .top, relatedBy: .equal, toItem: workingHourPicker, attribute: .bottom, multiplier: 1.0, constant: 16).isActive = true  // swiftlint:disable:this line_length
        mainView.addSubview(categoryPicker)
        categoryPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: categoryPicker, attribute: .left, relatedBy: .equal, toItem: mainView, attribute: .left, multiplier: 1.0, constant: 16).isActive = true   // swiftlint:disable:this line_length
        NSLayoutConstraint(item: categoryPicker, attribute: .top, relatedBy: .equal, toItem: categoryLabel, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true  // swiftlint:disable:this line_length
        mainView.addSubview(againstLabel)
        againstLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: againstLabel, attribute: .left, relatedBy: .equal, toItem: mainView, attribute: .left, multiplier: 1.0, constant: 16).isActive = true  // swiftlint:disable:this line_length
        NSLayoutConstraint(item: againstLabel, attribute: .top, relatedBy: .equal, toItem: categoryPicker, attribute: .bottom, multiplier: 1.0, constant: 16).isActive = true  // swiftlint:disable:this line_length
        mainView.addSubview(againstTextField)
        againstTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: againstTextField, attribute: .left, relatedBy: .equal, toItem: mainView, attribute: .left, multiplier: 1.0, constant: 16).isActive = true   // swiftlint:disable:this line_length
        NSLayoutConstraint(item: againstTextField, attribute: .top, relatedBy: .equal, toItem: againstLabel, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true  // swiftlint:disable:this line_length
        mainView.addSubview(protectionLabel)
        protectionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: protectionLabel, attribute: .left, relatedBy: .equal, toItem: mainView, attribute: .left, multiplier: 1.0, constant: 16).isActive = true  // swiftlint:disable:this line_length
        NSLayoutConstraint(item: protectionLabel, attribute: .top, relatedBy: .equal, toItem: againstTextField, attribute: .bottom, multiplier: 1.0, constant: 16).isActive = true  // swiftlint:disable:this line_length
        mainView.addSubview(protectionTextField)
        protectionTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: protectionTextField, attribute: .left, relatedBy: .equal, toItem: mainView, attribute: .left, multiplier: 1.0, constant: 16).isActive = true   // swiftlint:disable:this line_length
        NSLayoutConstraint(item: protectionTextField, attribute: .top, relatedBy: .equal, toItem: protectionLabel, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true  // swiftlint:disable:this line_length
        mainView.addSubview(dueLabel)
        dueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: dueLabel, attribute: .left, relatedBy: .equal, toItem: mainView, attribute: .left, multiplier: 1.0, constant: 16).isActive = true  // swiftlint:disable:this line_length
        NSLayoutConstraint(item: dueLabel, attribute: .top, relatedBy: .equal, toItem: protectionTextField, attribute: .bottom, multiplier: 1.0, constant: 16).isActive = true  // swiftlint:disable:this line_length
        mainView.addSubview(dueTextField)
        dueTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: dueTextField, attribute: .left, relatedBy: .equal, toItem: mainView, attribute: .left, multiplier: 1.0, constant: 16).isActive = true   // swiftlint:disable:this line_length
        NSLayoutConstraint(item: dueTextField, attribute: .top, relatedBy: .equal, toItem: dueLabel, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true  // swiftlint:disable:this line_length 
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == fieldPicker {
            return "Hello"
        }
        return nil
    }
}
