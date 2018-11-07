//
//  Library.swift
//  GameLibrary
//
//  Created by Kirk Brown on 11/5/18.
//  Copyright © 2018 Kirk Brown. All rights reserved.
//

import Foundation

class Library {
    //Singleton
    static let sharedInstance = Library()
    
    var games = [Game]()
    func populateWithTestData() {
    }
}
