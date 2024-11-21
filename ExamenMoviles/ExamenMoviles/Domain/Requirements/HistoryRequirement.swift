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
    
    func fetchPlaces() async throws -> (date: [String], category: [String], allData: [History]) {
        let allData = try await repository.fetchHistory()
        
        let date = Set(allData.map { $0.date }) // Specify type explicitly
        
        let category = Set(allData.map { $0.category }).sorted() // Specify type explicitly
        
        //print("Places: \(place)")
        //print("Dates: \(date)")
        
        return (Array(date), Array(category), allData)
    }
}
