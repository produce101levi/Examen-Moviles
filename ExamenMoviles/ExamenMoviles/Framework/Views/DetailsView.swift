//
//  PlaceView.swift
//  ExamenMoviles
//
//  Created by Leví Diaz on 21/11/24.
//

import Foundation
import SwiftUI

extension String {
    func cleanHTMLVM() -> String {
        return self
            .replacingOccurrences(of: "&amp;", with: "&")
            .replacingOccurrences(of: "amp;", with: "") // Handles repeated encodings
    }
}


struct DetailsHistoryView: View {
    
    let category: String
    let histories: [History]
    
    var body: some View {
        VStack {
            
            List(filteredHistories, id: \.id) { history in
                VStack {
                    Spacer()
                    Text("Date: ").font(.title).bold().foregroundColor(Color(red: 106/255, green: 65/255, blue: 29/255)) + Text(history.date).font(.title).foregroundColor(Color(red: 106/255, green: 65/255, blue: 29/255))
                    Spacer()
                    Text(history.description).foregroundColor(Color(red: 68/255, green: 40/255, blue: 16/255))
                    Spacer()
                    
                }.listRowBackground(Color(red: 254/255, green: 250/255, blue: 224/255))
                
            }
            .scrollContentBackground(.hidden)
        }
        .background(Color(red: 221/255, green: 161/255, blue: 94/255))
        .navigationTitle(category.cleanHTMLVM())
        
    }
    
    private var filteredHistories: [History] {
        histories.filter { $0.category == category }
    }
}
