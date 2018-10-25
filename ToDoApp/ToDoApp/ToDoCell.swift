//
//  ToDoCell.swift
//  ToDoApp
//
//  Created by Kurtis Hoang on 10/22/18.
//  Copyright © 2018 Kurtis Hoang. All rights reserved.
//

import UIKit

class ToDoCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    
    var todo: String? {
        didSet {
            if let toDo = todo {
                icon.image = UIImage(named: toDo)
                icon.contentMode = .scaleAspectFit
            }
        }
    }
    
}
