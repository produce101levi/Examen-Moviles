//
//  HistoryRepository.swift
//  ExamenMoviles
//
//  Created by Leví Diaz on 21/11/24.
//

import Foundation

protocol HistoryRepositoryProtocol {
    func fetchHistory() async throws -> [History]
}

class HistoryRepository: HistoryRepositoryProtocol {
    var parse: ParseService
    
    static let shared = HistoryRepository()
    
    init(parse: ParseService = ParseService.shared){
        self.parse = parse
    }
    
    func fetchHistory() async throws -> [History] {
        return try await parse.fetchHistory()
    }
}
