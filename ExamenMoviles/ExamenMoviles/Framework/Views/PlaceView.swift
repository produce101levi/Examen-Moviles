//
//  PlaceView.swift
//  ExamenMoviles
//
//  Created by Leví Diaz on 21/11/24.
//

import Foundation
import SwiftUI

struct PlaceHistoryView: View {
    let category: String
    let histories: [History]
    
    var body: some View {
        VStack {
            
            List(filteredHistories, id: \.id) { history in
                VStack {
                    Spacer()
                    Text("Date: ").bold() + Text(history.date)
                    Spacer()
                    Text(history.description)
                    Spacer()
                    
                }
            }
        }
        .navigationTitle(category)
    }
    
    private var filteredHistories: [History] {
        histories.filter { $0.category == category }
    }
}
