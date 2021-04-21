//
//  DebugScreenTableController.swift
//  SwiftCoreTraining
//
//  Created by Serg Liamthev on 21.04.2021.
//  Copyright © 2021 Serg Liamtsev. All rights reserved.
//

import UIKit

protocol DebugScreenTableControllerDelegate: class {
    
}

final class DebugScreenTableController: NSObject, TableController {
    
    weak var delegate: DebugScreenTableControllerDelegate?
    
    var updatesQueue: DispatchQueue = DispatchQueue(label: "\(NSStringFromClass(DebugScreenTableController.self)).collection.updates", qos: .userInteractive, attributes: [], autoreleaseFrequency: .workItem, target: nil)
    
    var dataSource: [TableViewSectionVM] = [
        // NOTE: - Insert some initial models values if needed
    ]
    
    var factory: TableCellsFactory = DebugScreenTableCellsFactory()
    
    var tableView: UITableView
    
    // MARK: - Life cycle
    init(tableView: UITableView) {
        
        self.tableView = tableView
        factory.registerAllCells(for: tableView)
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
        if let factory = self.factory as? DebugScreenTableCellsFactory {
            factory.delegate = self
        }
    }
    
    // MARK: - Public functions
    func updateDataSource(with newItems: [TableCellModel], animated: Bool) {
        
        // NOTE: - Update your data source using internal queue to avoid NSInternalInconsistencyException. Change to diffable data source if needed
        updatesQueue.async {
            
        }
    }
    
    // NOTE: - Insert custom data source update methods here
    
}

// MARK: - UITableViewDataSource
extension DebugScreenTableController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource[section].cells.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = dataSource[indexPath.section].cells[indexPath.row]
        return factory.generateCell(for: model, tableView: tableView, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView,
                   canEditRowAt indexPath: IndexPath) -> Bool {
        
        return false
    }
    
}

// MARK: - UITableViewDelegate
extension DebugScreenTableController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard dataSource.indices.contains(indexPath.section) else {
            return CGFloat.leastNonzeroMagnitude
        }
        guard dataSource[indexPath.section].cells.indices.contains(indexPath.row) else {
            return CGFloat.leastNonzeroMagnitude
        }
        return dataSource[indexPath.section].cells[indexPath.row].rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard dataSource.indices.contains(indexPath.section) else {
            return CGFloat.leastNonzeroMagnitude
        }
        guard dataSource[indexPath.section].cells.indices.contains(indexPath.row) else {
            return CGFloat.leastNonzeroMagnitude
        }
        return dataSource[indexPath.section].cells[indexPath.row].rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return dataSource[section].header?.rowHeight ?? CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return dataSource[section].footer?.rowHeight ?? CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let model: TableHeaderFooterModel = dataSource[section].header else {
            return nil
        }
        return factory.generateHeader(for: model, tableView: tableView, at: section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        guard let model: TableHeaderFooterModel = dataSource[section].footer else {
            return nil
        }
        return factory.generateFooter(for: model, tableView: tableView, at: section)
    }
    
}

// MARK: - Cell factory delegate
extension DebugScreenTableController: DebugScreenTableCellsFactoryDelegate {
    
}
