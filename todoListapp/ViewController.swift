//
//  ViewController.swift
//  todoListapp
//
//  Created by havisha tiruvuri on 9/16/17.
//  Copyright © 2017 havisha tiruvuri. All rights reserved.
//


import UIKit
import CoreData

class ViewController: UIViewController {
    
    weak var delegate: todolistdelegate? = nil
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var notesTextField: UITextField!
    
    @IBOutlet weak var dateDatePicker: UIDatePicker!
  
    @IBAction func additem(_ sender: UIButton) {
        let myDate = dateDatePicker.date
        print(myDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateString = dateFormatter.string(from: myDate)
        print(dateString)
        if delegate != nil {
            delegate?.add(by: self, title: titleTextField.text!, notes: notesTextField.text!, date: dateString)
            dismiss(animated: true, completion: nil )
        }
    }
}
   





