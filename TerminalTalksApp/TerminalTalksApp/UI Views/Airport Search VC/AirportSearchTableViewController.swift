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
        jsonToObjectC()
        
    }
    // MARK: - Properties
    var airports: [Airport]?
    var filteredAirports: [Airport]?
    
    // MARK: - Functions
    func fetchingInformation(searchTerm: String) { //O(n), where n is the length of the sequence.
        let filtered = airports?.filter { airport in
            airport.name.lowercased().contains(searchTerm.lowercased()) || airport.city.lowercased().contains(searchTerm.lowercased())
        }
        self.filteredAirports = filtered
//        print(filtered)
    }
       
    func jsonToObjectC() {
        guard let path = Bundle.main.path(forResource: "AirportsAPI", ofType: "json") else { return }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let airports = try JSONDecoder().decode([Airport].self, from: data)
            self.airports = airports
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAirports?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "airportCell", for: indexPath)
        guard let airport = filteredAirports?[indexPath.row] else { return UITableViewCell() }
        
        var config = cell.defaultContentConfiguration()
        config.text = airport.name
        config.secondaryText = airport.city
        cell.contentConfiguration = config
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
// MARK: - Extension
extension AirportSearchTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        fetchingInformation(searchTerm: searchTerm)
        self.tableView.reloadData()
    }
}


