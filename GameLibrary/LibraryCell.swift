//
//  LibraryCell.swift
//  GameLibrary
//
//  Created by Kirk Brown on 11/5/18.
//  Copyright © 2018 Kirk Brown. All rights reserved.
//

import UIKit

class LibraryCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var dueDateLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var availabilityView: UIView!
    
    func setup(game: Game) {
        titleLabel.text = game.title
        genreLabel.text = game.genre.rawValue
        ratingLabel.text = game.rating.rawValue
        
        switch game.availability {
        case .checkedIn:
            // hide due date
            dueDateLabel.isHidden = true
            // set view to green
            availabilityView.backgroundColor = .green
            
        case .checkedOut(let date):
            // show due date
            dueDateLabel.isHidden = false
            // set view to red
            availabilityView.backgroundColor = .red
            // set dueDate to formatted date
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            dueDateLabel.text = dateFormatter.string(from: date)
        }
    }
    
}

