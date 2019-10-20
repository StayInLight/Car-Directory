//
//  CarCell.swift
//  Car Directory
//
//  Created by Timur Rakhimov on 09/10/2019.
//  Copyright © 2019 Timur Rakhimov. All rights reserved.
//

import UIKit
import SnapKit

final class CarTableViewCell: UITableViewCell {

    var car: Car? {
        didSet {
            self.updateText()
        }
    }

    private let manufacturerLabel = Label()
    private let modelLabel = Label()
    private let yearOfReleaseLabel = Label(textAlignment: .right)
    private let bodyTypeLabel: Label = {
        let label = Label()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupViews()
    }

}

// MARK: - Setup UI
private extension CarTableViewCell {
     func setupViews() {
        self.addSubview(self.manufacturerLabel)
        self.addSubview(self.modelLabel)
        self.addSubview(self.yearOfReleaseLabel)
        self.addSubview(self.bodyTypeLabel)

        self.setupLabelsConstraints()
    }

    func setupLabelsConstraints() {
        let defaultOffset = 8

        self.manufacturerLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(defaultOffset)
            make.left.equalTo(self.safeAreaLayoutGuide).offset(defaultOffset * 2)
            make.trailing.equalTo(self.modelLabel.snp.leading).offset(-defaultOffset)
        }
        self.yearOfReleaseLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(defaultOffset)
            make.right.equalTo(self.safeAreaLayoutGuide).offset(-defaultOffset * 2)
        }
        self.modelLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(defaultOffset)
            make.trailing.greaterThanOrEqualTo(self.yearOfReleaseLabel.snp.leading).offset(-defaultOffset)
        }
        self.bodyTypeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.safeAreaLayoutGuide).offset(defaultOffset * 2)
            make.top.equalTo(self.manufacturerLabel.snp.bottom).offset(defaultOffset / 2)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-defaultOffset)
        }
    }
}

// MARK: - Actions
private extension CarTableViewCell {
    func updateText() {
        self.manufacturerLabel.text  = self.car?.manufacturer
        self.modelLabel.text         = self.car?.model
        self.yearOfReleaseLabel.text = self.car?.yearOfRelease
        self.bodyTypeLabel.text      = self.car?.bodyType
    }
}
