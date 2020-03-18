//
//  CellBuilders.swift
//  foobla
//
//  Created by Marina Azevedo on 16/08/19.
//  Copyright © 2019 Marina Azevedo. All rights reserved.
//

import UIKit

extension ViewController {
    
    // MARK: Cell Builders
    
    func simpleCell(_ indexPath: IndexPath) -> UITappableTableViewCell {
        let cell: simpleCell = tableView.recycle()
        cell.setup("Indice \(indexPath.row)")
        cell.tap = {
            self.data[indexPath.section].cells.append(self.simpleCell)
        }
        return cell
    }
    
    func detailCell(_ indexPath: IndexPath) -> UITappableTableViewCell {
        let cell: detailCell = tableView.recycle()
        cell.setup("Indice \(indexPath.row)", value: "valor \(indexPath.row * 20)")
        cell.tap = {
            self.data[indexPath.section].cells.append(self.detailCell)
        }
        return cell
    }

}
