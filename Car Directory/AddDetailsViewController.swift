//
//  AddDetailsViewController.swift
//  Car Directory
//
//  Created by Timur Rakhimov on 13/10/2019.
//  Copyright © 2019 Timur Rakhimov. All rights reserved.
//

import UIKit
import SnapKit

final class AddDetailsViewController: UIViewController {

    var car: Car?

    let manufacturerTextField: UITextField = {
        let textField = UITextField()
        textField.adjustsFontSizeToFitWidth = true
        textField.placeholder = "Enter Manufacturer"
        textField.borderStyle = .roundedRect
        return textField
    }()

    let yearOfReleaseTextField: UITextField = {
        let textField = UITextField()
        textField.adjustsFontSizeToFitWidth = true
        textField.placeholder = "Enter Year of Release"
        textField.borderStyle = .roundedRect
        return textField
    }()

    let modelTextField: UITextField = {
        let textField = UITextField()
        textField.adjustsFontSizeToFitWidth = true
        textField.placeholder = "Enter Model"
        textField.borderStyle = .roundedRect
        return textField
    }()

    let bodyTypeTextField: UITextField = {
        let textField = UITextField()
        textField.adjustsFontSizeToFitWidth = true
        textField.placeholder = "Enter Body Type"
        textField.borderStyle = .roundedRect
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        setupNavigationBar()
        setupStackView()
    func setupNavigationBar() {
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Add Car"
        self.navigationItem.rightBarButtonItem = doneBarButtonItem
    }

}

extension AddDetailsViewController {

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
