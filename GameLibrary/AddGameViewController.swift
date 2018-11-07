//
//  AddGameViewController.swift
//  GameLibrary
//
//  Created by Kirk Brown on 11/5/18.
//  Copyright © 2018 Kirk Brown. All rights reserved.
//

import UIKit

class AddGameViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var ratingSegmentedControl: UISegmentedControl!
    @IBOutlet weak var genrePickerView: UIPickerView!
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        trySavingGame()
    }
    
    let segments: [(title: String, rating: Game.Rating)] =
        [("K", .kids),
         ("E", .everyone),
         ("E 10+", .tenPlus),
         ("T", .teen),
         ("M", .mature),
         ("AO", .adultsOnly)]
    
    let genres: [(title: String, genre: Game.Genre)] =
        [("Action", .action),
         ("Arcade", .arcade),
         ("Japanese Role Playing Game", .jrpg),
         ("Puzzle", .puzzle),
         ("Epic Battle Royal", .royale),
         ("Role Playing Game", .rpg)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ratingSegmentedControl.removeAllSegments()
        
        for (index, segment) in segments.enumerated() {
            ratingSegmentedControl.insertSegment(withTitle: segment.title, at: index, animated: false)
        }
        
        ratingSegmentedControl.selectedSegmentIndex = 0
        
        genrePickerView.dataSource = self
        genrePickerView.delegate = self
    }
    
    
    func trySavingGame() {
        
        // title
        guard let title = titleTextField.text else { return }
        
        // details
        guard let details = detailsTextView.text else { return }
        
        // rating
        let rating = segments[ratingSegmentedControl.selectedSegmentIndex].rating
        
        // genre
        let genre = genres[genrePickerView.selectedRow(inComponent: 0)].genre
        
        let game = Game(title: title, detail: details, rating: rating, genre: genre)
        
        Library.sharedInstance.games.append(game)
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddGameViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genres[row].title
    }
    
    
}



