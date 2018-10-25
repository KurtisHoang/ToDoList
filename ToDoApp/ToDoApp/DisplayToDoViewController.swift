//
//  DisplayToDoViewController.swift
//  ToDoApp
//
//  Created by Kurtis Hoang on 10/22/18.
//  Copyright © 2018 Kurtis Hoang. All rights reserved.
//

import UIKit

class DisplayToDoViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var toDo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        display.text = toDo
    }
}
