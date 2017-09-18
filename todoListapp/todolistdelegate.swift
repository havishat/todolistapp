//
//  todolistdelegate.swift
//  todoListapp
//
//  Created by havisha tiruvuri on 9/15/17.
//  Copyright © 2017 havisha tiruvuri. All rights reserved.
//

import UIKit

protocol todolistdelegate: class {
    func add(by: UIViewController, title: String, notes: String, date: String)
}
