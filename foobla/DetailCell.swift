//
//  DetailCell.swift
//  foobla
//
//  Created by Marina Azevedo on 16/08/19.
//  Copyright © 2019 Marina Azevedo. All rights reserved.
//

import UIKit

class detailCell: UITappableTableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ title: String, value: String) {
        self.textLabel?.text = title
        self.detailTextLabel?.text = value
    }
    
}
