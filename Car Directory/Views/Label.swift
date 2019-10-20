//
//  Label.swift
//  Car Directory
//
//  Created by Timur Rakhimov on 20/10/2019.
//  Copyright © 2019 Timur Rakhimov. All rights reserved.
//

import UIKit

final class Label: UILabel {
    convenience init(textAlignment: NSTextAlignment = .left) {
        self.init()
        self.textAlignment = textAlignment
        self.numberOfLines = 0
    }
}
