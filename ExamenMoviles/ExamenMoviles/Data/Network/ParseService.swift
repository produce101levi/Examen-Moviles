//
//  ParseService.swift
//  ExamenMoviles
//
//  Created by Leví Diaz on 21/11/24.
//

import Foundation
import ParseCore

class ParseService {
    static let shared = ParseService()
    
    func fetchHistory() async throws -> [History] {
        return try await withCheckedThrowingContinuation { continuation in
            PFCloud.callFunction(inBackground: "hello", withParameters: [:]){ (response, error) in
                if let error = error {
                    print("Error in Parse")
                    continuation.resume(throwing: error)
                } else if let response = response as? [String: Any]{
                    
                    if let historyArray = response["data"] as? [[String: Any]]{
                        let history = historyArray.compactMap { dict -> History? in
                            guard let date = dict["date"] as? String,
                                  let description = dict["description"] as? String,
                                  let place = dict["category2"] as? String else {return nil}
                            return History(id: UUID(), date: date, description: description, place: place)
                        }
                        continuation.resume(returning: history)
                    }
                }
            }
        }
    }
}
