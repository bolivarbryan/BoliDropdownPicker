//
//  BoliDropdownPicker.swift
//  BoliDropdownPicker
//
//  Created by Bryan A Bolivar M on 2/27/17.
//  Copyright © 2017 Bolivarbryan. All rights reserved.
//

import Foundation
import UIKit

protocol BoliDropdownPickerDelegate {
    func didSelectItemAtIndex(index: Int)
}

class BoliDropdownPicker: UIView {
    var delegate: BoliDropdownPickerDelegate!
    //expecting an Array of Strings
    let kMaxTableWidht = 320
    var minTableWidth:CGFloat = 0
    let kCellIdentifier = "BoliDropdownPickerCell"
    var values: Array<String> = []
    var cellsSelected = Set<IndexPath>()
    var tableView: UITableView = UITableView()
    //multiple selection is false by default
    var isMultipleSelectionEnabled: Bool {
        set(value) {
            self.tableView.allowsMultipleSelection = false
        }
        get{
            self.cellsSelected.removeAll()
            self.tableView.reloadData()
            return self.tableView.allowsMultipleSelection
        }
    }
    
    init(values: Array<String>, belowView senderView: UIView, customWidth: CGFloat?, customOffset: CGFloat?) {
        
        self.minTableWidth = senderView.frame.size.width
        if let widthObject = customWidth {
            minTableWidth = widthObject
        }
        
        var x = senderView.frame.origin.x
        if let offset = customOffset {
            x = x - offset
        }
        let point = CGPoint(x: x, y: senderView.frame.origin.y + senderView.frame.height)
        
        super.init(frame: CGRect(origin: point, size: CGSize(width: minTableWidth, height: 150)))
        self.values = values
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let rect = CGRect(x: 0, y: 0, width: minTableWidth, height: 0)
        let rect2 = CGRect(x: 0, y: 0, width: minTableWidth, height: self.frame.height)
        self.tableView.frame = rect
        self.tableView.layer.borderWidth = 1
        self.tableView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.addSubview(self.tableView)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.tableView.frame = rect2
        }) { (done) in}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func finishPickup() {
        
    }
}

extension BoliDropdownPicker: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: kCellIdentifier)
        cell.textLabel?.text = values[indexPath.row]
        
        if cellsSelected.contains(indexPath) {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width , height: 30))
        headerView.backgroundColor = UIColor.green
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width , height: 30))
        footerView.backgroundColor = UIColor.green
        return footerView
    }
}

extension BoliDropdownPicker: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if cellsSelected.contains(indexPath) {
            cellsSelected.remove(indexPath)
        }else{
            //if multiple selection is disabled, remove all selected cells from set
            if isMultipleSelectionEnabled == true {
                cellsSelected.removeAll()
                self.tableView.reloadData()
            }
            
            cellsSelected.insert(indexPath)
        }
        tableView.reloadRows(at: [indexPath], with: .none)
        self.delegate.didSelectItemAtIndex(index: indexPath.row)

        let rect = CGRect(x: 0, y: 0, width: minTableWidth, height: 0)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.tableView.frame = rect
        }) { (done) in
            self.removeFromSuperview()
        }
    }
    
}
