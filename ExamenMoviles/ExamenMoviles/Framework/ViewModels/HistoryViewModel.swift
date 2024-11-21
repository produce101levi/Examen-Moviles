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
    var history: [History] = []
    
    init(requirement: HistoryRequirement = HistoryRequirement.shared) {
        self.requirement = requirement
    }
    
    func fetchHistory() async -> [History]? {
        do {
            self.history = try await requirement.fetchHistory()
            return self.history
        } catch {
            print("Error in viewModel")
            return nil
        }
    }
}
