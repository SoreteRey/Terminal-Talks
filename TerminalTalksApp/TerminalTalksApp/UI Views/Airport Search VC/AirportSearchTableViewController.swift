//
//  AirportSearchTableViewController.swift
//  TerminalTalksApp
//
//  Created by Sebastian Guiscardo on 4/3/23.
//

import UIKit

class AirportSearchTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    
    // MARK: - Functions
    func fetchingInformation(searchTerm: String) {
        guard let path = Bundle.main.path(forResource: "AirportsAPI", ofType: "json") else { return }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            guard let array = json as? [Any] else { return }
            for airport in array {
                guard let airportDict = airport as? [String : Any] else { return }
                guard let airportName = airportDict["name"] as? String else { return }
                guard let airportCountry = airportDict["country"] as? String else { return }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "airportCell", for: indexPath)

        
        return cell
    }
}
// MARK: - Extension
extension AirportSearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        fetchingInformation(searchTerm: searchTerm)
    }
}
// tell the information what to do and present it to the cell

