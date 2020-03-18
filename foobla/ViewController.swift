//
//  ViewController.swift
//  foobla
//
//  Created by Marina Azevedo on 15/08/19.
//  Copyright © 2019 Marina Azevedo. All rights reserved.
//

import UIKit

// MARK: Aliases

typealias CellPattern = (title: String, cells: [(IndexPath) -> UITappableTableViewCell])


class ViewController: UITableViewController {
    
    // MARK: Variables

    var data: [CellPattern] = []  {
        didSet { tableView.reloadData() }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        
        loadData()
    }
    
    // MARK: - TableView
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data[section].title
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].cells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return data[indexPath.section].cells[indexPath.row](indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? UITappableTableViewCell {
            cell.tap?()
        }
    }
    
    // MARK: - Private functions
    
    func loadData() {
        data = [
            (title: "Sessão 1", cells: [
                detailCell,
                simpleCell,
                detailCell
            ]),
            (title: "Sessão 2", cells: [
                simpleCell,
                detailCell
            ]),
        ]
    }
    
}
