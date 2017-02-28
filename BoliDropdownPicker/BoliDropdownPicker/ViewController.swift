//
//  ViewController.swift
//  BoliDropdownPicker
//
//  Created by Bryan A Bolivar M on 2/27/17.
//  Copyright © 2017 Bolivarbryan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    let values = ["B", "C", "D", "E", "F"]
    var dropdownPicker:BoliDropdownPicker!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func showPicker(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            dropdownPicker = BoliDropdownPicker(values: values, belowView: sender, customWidth: (sender).frame.width , customOffset: nil)
            dropdownPicker.delegate = self
            self.view.addSubview(dropdownPicker)
        }else{
          dropdownPicker.close()
        }   
    }
}

extension ViewController: BoliDropdownPickerDelegate {
    func didSelectItemAtIndex(index: Int) {
        self.button.setTitle(values[index], for: .normal)
        self.button.isSelected = false
    }
}
