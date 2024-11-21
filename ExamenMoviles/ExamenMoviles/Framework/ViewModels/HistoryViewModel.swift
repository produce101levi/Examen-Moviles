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
    var categories: [String] = []
    
    init(requirement: HistoryRequirement = HistoryRequirement.shared) {
        self.requirement = requirement
    }
    
    func fetchPlaces() async -> [String]? {
        do {
            let result = try await requirement.fetchPlaces()
            self.categories = result.category
            return categories
        } catch {
            print("Error fetching places")
            return nil
        }
    }
    
    func fetchHistory() async -> [History]? {
        do {
            let result = try await requirement.fetchHistory()
            return result
        } catch {
            print("Error in viewModel")
            return nil
        }
    }
}
