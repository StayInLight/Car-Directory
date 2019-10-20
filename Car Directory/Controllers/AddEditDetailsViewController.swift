//
//  AddDetailsViewController.swift
//  Car Directory
//
//  Created by Timur Rakhimov on 13/10/2019.
//  Copyright © 2019 Timur Rakhimov. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift

final class AddEditDetailsViewController: UIViewController {
    
    var car: Car?
    var completionHandler: (() -> Void)?
    
    private lazy var saveBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .save,
                               target: self,
                               action: #selector(saveBarButtonTapped))
    }()
    
    private lazy var deleteBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .trash,
                               target: self,
                               action: #selector(deleteBarButtonTapped))
    }()
    
    private let manufacturerTextField = TextField(placeholder: "Enter Manufacturer")
    private let yearOfReleaseTextField = TextField(placeholder: "Enter Year of Release")
    private let modelTextField = TextField(placeholder: "Enter Model")
    private let bodyTypeTextField = TextField(placeholder: "Enter Body Type")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let car = self.car {
            self.fetch(car)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar()
        self.setupStackView()
        self.view.backgroundColor = .white
    }

}

// MARK: - Buttons Actions
private extension AddEditDetailsViewController {
    @objc
    func saveBarButtonTapped() {
        let car = Car()
        if textFieldsNotEmpty() {
            self.create(car)
            dismiss(animated: true)
        } else {
            self.showAlertTextFieldsAreEmpty()
        }
    }

    @objc
    func deleteBarButtonTapped() {
        self.car?.delete()
        self.completionHandler?()
        dismiss(animated: true)
    }
}

// MARK: - Actions
private extension AddEditDetailsViewController {

    func textFieldsNotEmpty() -> Bool {
        guard
            let manufacturerText = self.manufacturerTextField.text?.isEmpty,
            let yearOfReleaseText = self.yearOfReleaseTextField.text?.isEmpty,
            let modelText = self.modelTextField.text?.isEmpty,
            let bodyTypeText = self.bodyTypeTextField.text?.isEmpty
            else {
                fatalError("Text is nil")
        }
        return !manufacturerText && !yearOfReleaseText && !modelText && !bodyTypeText
    }

    func create(_ car: Car) {
        car.manufacturer  = self.manufacturerTextField.text
        car.yearOfRelease = self.yearOfReleaseTextField.text
        car.model = self.modelTextField.text
        car.bodyType = self.bodyTypeTextField.text
        Car.add(car)
        self.completionHandler?()
    }

    func fetch(_ car: Car) {
        self.manufacturerTextField.text = car.manufacturer
        self.yearOfReleaseTextField.text = car.yearOfRelease
        self.modelTextField.text = car.model
        self.bodyTypeTextField.text = car.bodyType
    }

    func showAlertTextFieldsAreEmpty() {
        let alertController = UIAlertController(title: "Недостаточно данных",
                                                message: "Заполните все оставшиеся поля",
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
}

// MARK: - Setup UI
private extension AddEditDetailsViewController {
    
    func setupStackView() {
        let defaultSpacing: CGFloat = 20
        let stackView = UIStackView(arrangedSubviews: [manufacturerTextField,
                                                       yearOfReleaseTextField,
                                                       modelTextField,
                                                       bodyTypeTextField])
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = defaultSpacing
        
        stackView.snp.makeConstraints { (make) in
            make.left.topMargin.equalTo(defaultSpacing)
            make.right.equalTo(-defaultSpacing)
        }
    }

    func setupNavigationBar() {
        self.view.backgroundColor = .white
        if car != nil {
            self.navigationItem.title = "Edit Car"
            self.navigationItem.leftBarButtonItem = deleteBarButtonItem
        } else {
            self.navigationItem.title = "Add Car"
        }
        self.navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
}
