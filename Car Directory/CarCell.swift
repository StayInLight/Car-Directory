//
//  CarCell.swift
//  Car Directory
//
//  Created by Timur Rakhimov on 09/10/2019.
//  Copyright © 2019 Timur Rakhimov. All rights reserved.
//

import UIKit
import SnapKit

private let defaultOffset = 8

final class CarCell: UITableViewCell {
    
    var car: Car? {
        didSet {
            self.manufacturerLabel.text  = self.car?.manufacturer
            self.modelLabel.text         = self.car?.model
            self.yearOfReleaseLabel.text = String(self.car?.yearOfRelease ?? 0)
            self.bodyTypeLabel.text      = self.car?.bodyType
        }
    }

    private let manufacturerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private let modelLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let yearOfReleaseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    private let bodyTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
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

private extension CarCell {

     func setupViews() {
        self.addSubview(self.manufacturerLabel)
        self.addSubview(self.modelLabel)
        self.addSubview(self.yearOfReleaseLabel)
        self.addSubview(self.bodyTypeLabel)

        self.setupLabelsConstraints()
    }

    func setupLabelsConstraints() {
        self.manufacturerLabel.snp.makeConstraints { (make) -> Void in
            make.top.left.equalTo(self.safeAreaLayoutGuide).offset(defaultOffset)
            make.trailing.equalTo(self.modelLabel.snp.leading).offset(-defaultOffset)
        }
        self.yearOfReleaseLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(defaultOffset)
            make.right.equalTo(self.safeAreaLayoutGuide).offset(-defaultOffset)
        }
        self.modelLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(defaultOffset)
            make.trailing.greaterThanOrEqualTo(self.yearOfReleaseLabel.snp.leading).offset(-defaultOffset)
        }
        self.bodyTypeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.safeAreaLayoutGuide).offset(defaultOffset)
            make.top.equalTo(self.manufacturerLabel.snp.bottom).offset(defaultOffset / 2)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-defaultOffset)
        }
    }

}
