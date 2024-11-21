//
//  HistoryRequirement.swift
//  ExamenMoviles
//
//  Created by Leví Diaz on 21/11/24.
//

import Foundation

protocol HistoryRequirementProtocol {
    func fetchHistory() async throws -> [History]
}

class HistoryRequirement: HistoryRequirementProtocol {
    var repository: HistoryRepository
    
    static let shared = HistoryRequirement()
    
    init(repository: HistoryRepository = HistoryRepository.shared){
        self.repository = repository
    }
    
    func fetchHistory() async throws -> [History] {
        return try await repository.fetchHistory()
    }
}
