//
//  TextField.swift
//  Car Directory
//
//  Created by Timur Rakhimov on 20/10/2019.
//  Copyright © 2019 Timur Rakhimov. All rights reserved.
//

import UIKit

final class TextField: UITextField {

    convenience init(placeholder: String) {
        self.init()
        self.placeholder = placeholder
        self.adjustsFontSizeToFitWidth = true
        self.borderStyle = .roundedRect
    }

}
