//
//  AddDetailsViewController.swift
//  Car Directory
//
//  Created by Timur Rakhimov on 13/10/2019.
//  Copyright © 2019 Timur Rakhimov. All rights reserved.
//

import UIKit
import SnapKit

final class AddEditDetailsViewController: UIViewController {

    var car: Car?
    var completionHandler: ((Car) -> Void)?

    private lazy var doneBarButtonItem: UIBarButtonItem = {
           return UIBarButtonItem(barButtonSystemItem: .done,
                                  target: self,
                                  action: #selector(doneBarButtonTapped))
    }()

    private let manufacturerTextField: UITextField = {
        let textField = UITextField()
        textField.adjustsFontSizeToFitWidth = true
        textField.placeholder = "Enter Manufacturer"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let yearOfReleaseTextField: UITextField = {
        let textField = UITextField()
        textField.adjustsFontSizeToFitWidth = true
        textField.placeholder = "Enter Year of Release"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let modelTextField: UITextField = {
        let textField = UITextField()
        textField.adjustsFontSizeToFitWidth = true
        textField.placeholder = "Enter Model"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let bodyTypeTextField: UITextField = {
        let textField = UITextField()
        textField.adjustsFontSizeToFitWidth = true
        textField.placeholder = "Enter Body Type"
        textField.borderStyle = .roundedRect
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let car = self.car {
            manufacturerTextField.text = car.manufacturer
            yearOfReleaseTextField.text = "\(Int(car.yearOfRelease ?? 0))"
            modelTextField.text = car.model
            bodyTypeTextField.text = car.bodyType
            completionHandler?(car)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar()
        self.setupStackView()
        self.view.backgroundColor = .white
    }

    @objc
    fileprivate func doneBarButtonTapped() {
        var car = Car()
        car.manufacturer  = manufacturerTextField.text
        let yearOfRelease = yearOfReleaseTextField.text
        if let yearOfRelease = yearOfRelease {
            car.yearOfRelease = Int(yearOfRelease)
        }
        car.model = modelTextField.text
        car.bodyType = bodyTypeTextField.text
        completionHandler?(car)
        dismiss(animated: true, completion: nil)
    }

    fileprivate func setupNavigationBar() {
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Add Car"
        self.navigationItem.rightBarButtonItem = doneBarButtonItem
    }

}

extension AddEditDetailsViewController {

    fileprivate func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [manufacturerTextField,
                                                       yearOfReleaseTextField,
                                                       modelTextField,
                                                       bodyTypeTextField])
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 20

        stackView.snp.makeConstraints { (make) in
            make.left.topMargin.equalTo(20)
            make.right.equalTo(-20)
        }
    }

}
