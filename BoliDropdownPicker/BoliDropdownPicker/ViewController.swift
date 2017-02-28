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
    let values = ["A", "B", "C"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func showPicker(_ sender: Any) {
        let dropdownPicker = BoliDropdownPicker(values: values, belowView: sender as! UIButton, customWidth: (sender as! UIButton).frame.width + 10 , customOffset: 10)
        dropdownPicker.delegate = self
        self.view.addSubview(dropdownPicker)
    }

}

extension ViewController: BoliDropdownPickerDelegate {
    func didSelectItemAtIndex(index: Int) {
        self.button.setTitle(values[index], for: .normal)
    }

}
