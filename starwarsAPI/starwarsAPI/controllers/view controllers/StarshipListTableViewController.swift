//
//  StarshipListTableViewController.swift
//  starwarsAPI
//
//  Created by Matthew O'Connor on 10/3/19.
//  Copyright © 2019 Matthew O'Connor. All rights reserved.
//

import UIKit

class StarshipListTableViewController: UITableViewController {
    @IBOutlet weak var starshipSearchBar: UISearchBar!
    
    var starships: [Starship] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        starshipSearchBar.delegate = self
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return starships.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "starshipCell", for: indexPath)

        let starship = starships[indexPath.row]
        cell.textLabel?.text = starship.name

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let index = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? StarshipDetailTableViewController
                else {return}
            let starship = starships[index.row]
            destinationVC.starship = starship
        }
    }
    

}

extension StarshipListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        StarshipController.shared.fetchStarships(with: searchText) { (starships) in
            self.starships = starships
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
        }
    }
}
