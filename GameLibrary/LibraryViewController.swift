//
//  LibraryViewController.swift
//  GameLibrary
//
//  Created by Kirk Brown on 11/5/18.
//  Copyright © 2018 Kirk Brown. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class LibraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let library = Library.sharedInstance

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        library.games.append(Game(title: "Red Dead Redemption 2", detail: "10/10", rating: .mature, genre: .rpg ))
        
        library.games.append(Game(title: "SpiderMan", detail: "Best SpiderMan Game", rating: .teen, genre: .action ))
        
        library.games.append(Game(title: "FallOut 76", detail: "the most radioactive holler", rating: .teen, genre: .action ))
        tableView.reloadData()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // a little trick for removing the cell seperators
        self.tableView.tableFooterView = UIView()
        
        library.populateWithTestData()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    func checkOut(indexPath: IndexPath) {
        let game = library.games[indexPath.row]
        
        let calendar = Calendar(identifier: .gregorian)
        let dueDate = calendar.date(byAdding: .day, value: 7, to: Date())!
        
        game.availability = .checkedOut(dueDate: dueDate)
        
        if let cell = tableView.cellForRow(at: indexPath) as? LibraryCell {
            cell.setup(game: game)
        }
    }
    func checkIn(indexPath: IndexPath) {
        let game = library.games[indexPath.row]
        game.availability = .checkedIn
        
        if let cell = tableView.cellForRow(at: indexPath) as? LibraryCell {
            cell.setup(game: game)
        }
    }
    
}

extension LibraryViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return library.games.count
    }
    
    //this function asks for the cell for a given row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell from table view
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! LibraryCell
        
        // Get the game that is supposed to be represented at that row
        let game = library.games[indexPath.row]
        // Setup the cell UI for the given game
        cell.setup(game: game)
        
        // Return the cell
        return cell
    }
    // Here the tableview is asking if any row should have an "edit" action.
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // We create the delete action, with a closure associated with it.
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
            Library.sharedInstance.games.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            if Library.sharedInstance.games.count == 0 {
                tableView.reloadData()
            }
        }
        
        let game = library.games[indexPath.row]
        
        switch game.availability {
        case .checkedIn:
            let checkOutAction = UITableViewRowAction(style: .normal, title: "Check Out") { _, indexPath in
                self.checkOut(indexPath: indexPath)
            }
            
            return [deleteAction, checkOutAction]
            
        case .checkedOut:
            let checkInAction = UITableViewRowAction(style: .normal, title: "Check In") { _, indexPath in
                self.checkIn(indexPath: indexPath)
            }
            return [deleteAction, checkInAction]
        }
    }
}
extension LibraryViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "Empty Library")
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "You haven't added any games to your library.")
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
        
        return NSAttributedString(string: "Add Game", attributes: attributes)
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        performSegue(withIdentifier: "LibraryToAddGame", sender: self)
        
    }
    
}

