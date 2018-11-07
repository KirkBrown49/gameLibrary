//
//  game.swift
//  GameLibrary
//
//  Created by Kirk Brown on 11/5/18.
//  Copyright © 2018 Kirk Brown. All rights reserved.
//

import Foundation
import RealmSwift

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
        init(date:Date?) {
            if let date = date {
                self = .checkedOut(dueDate: date)
            }else{
                self = .checkedIn
            }
        }
    }
    
    
    @objc dynamic var title: String = ""
    @objc dynamic var  detail: String = ""
    @objc private dynamic var ratingInternal: String = ""
    @objc private dynamic var genreInternal: String = ""
    @objc private dynamic var availInternal: Date? = nil
    var rating: Rating {
        get {
            return Rating(rawValue: ratingInternal)!
        } set {
            ratingInternal = rating.rawValue
        }
    }
    var genre: Genre {
        get {
            return Genre(rawValue: genreInternal)!
        } set {
            genreInternal = genre.rawValue
        }
    }
    var availability: Availabilty {
        get {
            return Availabilty(date: availInternal)
        }
        set {
            switch availability {
                case .checkedIn:
                availInternal = nil
                case .checkedOut(let date):
                availInternal = date
            }
        }
    }
    
    convenience init(title: String, detail: String, rating: Rating,genre: Genre) {
        self.init()
        self.title = title
        self.detail = detail
        self.rating  = rating
        self.genre = genre
        self.availability = .checkedIn
    }
}
