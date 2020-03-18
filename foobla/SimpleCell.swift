//
//  SimpleCell.swift
//  foobla
//
//  Created by Marina Azevedo on 16/08/19.
//  Copyright © 2019 Marina Azevedo. All rights reserved.
//

import UIKit

class simpleCell: UITappableTableViewCell {
    
    func setup(_ title: String) {
        self.textLabel?.text = title
    }
    
}
