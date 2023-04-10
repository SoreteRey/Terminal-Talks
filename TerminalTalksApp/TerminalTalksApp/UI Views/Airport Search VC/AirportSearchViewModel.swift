//
//  AirportSearchViewModel.swift
//  TerminalTalksApp
//
//  Created by Sebastian Guiscardo on 4/8/23.
//

import Foundation

protocol AirportSearchViewModelDelegate: AnyObject {
    func airportsLoadedSuccessFully()
}

class AirportSearchViewModel {
    // MARK: - Properties
    var airports: [Airport] = []
    private var service: FireBaseSyncable
    private weak var delegate: AirportSearchViewModelDelegate?
    
    init(firebaseService: FireBaseSyncable = FirebaseService(), delegate: AirportSearchViewModelDelegate) {
        self.service = firebaseService
        self.delegate = delegate
    }
    
    // MARK: - Functions
//    func loadData() {
//        service.loadAirports { [weak self] result in
//            switch result {
//            case .success(let airports):
//                self?.airports = airports //make a function called loadairports and call the json file information
//                self?.delegate?.airportsLoadedSuccessFully()
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
}
