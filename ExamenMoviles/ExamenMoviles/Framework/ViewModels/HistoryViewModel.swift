//
//  HistoryViewModel.swift
//  ExamenMoviles
//
//  Created by Leví Diaz on 21/11/24.
//

import Foundation

class HistoryViewModel: ObservableObject {
    static let shared = HistoryViewModel()
    var requirement: HistoryRequirement
    var dates: [String] = []
    var places: [String] = []
    
    init(requirement: HistoryRequirement = HistoryRequirement.shared) {
        self.requirement = requirement
    }
    
    func fetchPlaces() async -> [String]? {
        do {
            let result = try await requirement.fetchHistory()
            self.places = result.place
            return places
        } catch {
            print("Error fetching places")
            return nil
        }
    }
    
    func fetchHistory() async {
        do {
            let result = try await requirement.fetchHistory()
            self.dates = result.date
            
            // print("Dates: \(self.dates)")
            print("Places: \(self.places)")
        } catch {
            print("Error in viewModel")
        }
    }
}
