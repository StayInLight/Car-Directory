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
            manufacturerLabel.text = car?.manufacturer
            modelLabel.text = car?.model
            yearOfReleaseLabel.text = String(car?.yearOfRelease ?? 0)
            bodyTypeLabel.text = car?.bodyType
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
        setupViews()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

}

extension CarCell {

    fileprivate func setupViews() {
        addSubview(manufacturerLabel)
        addSubview(modelLabel)
        addSubview(yearOfReleaseLabel)
        addSubview(bodyTypeLabel)

        setupLabelsConstraints()
    }

    fileprivate func setupLabelsConstraints() {
        manufacturerLabel.snp.makeConstraints { (make) -> Void in
            make.top.left.equalTo(self.safeAreaLayoutGuide).offset(defaultOffset)
            make.trailing.equalTo(self.modelLabel.snp.leading).offset(-defaultOffset)
        }
        yearOfReleaseLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(defaultOffset)
            make.right.equalTo(self.safeAreaLayoutGuide).offset(-defaultOffset)
        }
        modelLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(defaultOffset)
            make.trailing.greaterThanOrEqualTo(self.yearOfReleaseLabel.snp.leading).offset(-defaultOffset)
        }
        bodyTypeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.safeAreaLayoutGuide).offset(defaultOffset)
            make.top.equalTo(self.manufacturerLabel.snp.bottom).offset(defaultOffset / 2)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-defaultOffset)
        }
    }
}
