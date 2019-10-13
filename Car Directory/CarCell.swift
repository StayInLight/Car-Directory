//
//  CarCell.swift
//  Car Directory
//
//  Created by Timur Rakhimov on 09/10/2019.
//  Copyright © 2019 Timur Rakhimov. All rights reserved.
//

import UIKit
import SnapKit

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
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()

    private let modelLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let yearOfReleaseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let bodyTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
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

        let stackView = UIStackView(arrangedSubviews: [manufacturerLabel,
                                                       modelLabel,
                                                       yearOfReleaseLabel,
                                                       bodyTypeLabel, ])
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 8
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) -> Void in
            make.top.left.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.bottom.right.equalTo(self.safeAreaLayoutGuide).offset(-8)
        }
    }
}
