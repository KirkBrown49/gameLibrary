//
//  game.swift
//  GameLibrary
//
//  Created by Kirk Brown on 11/5/18.
//  Copyright © 2018 Kirk Brown. All rights reserved.
//

import Foundation

class Game {
    
    enum Genre: String {
        case rpg = "RPG"
        case royale = "Battle Royal"
        case fps = "FPS"
        case jrpg = "JRPG"
        case puzzle = "Puzzle"
        case action = "Action"
        case arcade = "Arcade"
        
        
    }
    enum Rating: String {
        case kids = "Kids"
        case everyone = "Everyone"
        case tenPlus = "E 10+"
        case teen = "Teen"
        case mature = "Mature"
        case adultsOnly = "ADULTS ONLY"
        
    }
    enum Availabilty {
        case checkedIn
        case checkedOut(dueDate:Date)
    }
    let title: String
    let detail: String
    let rating: Rating
    let genre: Genre
    var availability: Availabilty
    
    init(title: String, detail: String, rating: Rating,genre: Genre) {
        self.title = title
        self.detail = detail
        self.rating  = rating
        self.genre = genre
        self.availability = .checkedIn
    }
    
    
    
}
