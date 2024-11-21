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
            func attemptFetch() {
                PFCloud.callFunction(inBackground: "hello", withParameters: [:]) { (response, error) in
                    
                    if let error = error {
                        print("Error in Parse")
                        print("Retrying...")
                        attemptFetch()
                    } else if let response = response as? [String: Any],
                              let historyArray = response["data"] as? NSArray {
                        // print("Type of each element in historyArray: \(historyArray.map { type(of: $0) })")
                        let history = historyArray.compactMap { element -> History? in
                            guard let pfObject = element as? PFObject else {
                                // print("Skipping: Not a PFObject - \(element)")
                                return nil
                            }
                            // print("Processing PFObject: \(pfObject)")

                            guard let date = pfObject["date"] as? String else {
                                // print("Skipping: 'date' not found or invalid - \(pfObject)")
                                return nil
                            }

                            guard let description = pfObject["description"] as? String else {
                               // print("Skipping: 'description' not found or invalid - \(pfObject)")
                                return nil
                            }

                            guard let category = pfObject["category2"] as? String else {
                                // print("Skipping: 'category2' not found or invalid - \(pfObject)")
                                return nil
                            }

                            return History(id: UUID(), date: date, description: description, category: category)
                        }
                        continuation.resume(returning: history)
                    } else {
                        print("Failed to cast data to NSArray")
                        continuation.resume(throwing: NSError(domain: "ParseError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Data is not in expected format"]))
                    }
                }
            }
            attemptFetch()
        }
    }
}
