//
//  History.swift
//  ExamenMoviles
//
//  Created by Leví Diaz on 21/11/24.
//

import Foundation

struct History: Identifiable {
    var id: UUID
    var date: String
    var description: String
    var place: String
}

struct Place: Identifiable {
    let id = UUID()
    let name: String
}
