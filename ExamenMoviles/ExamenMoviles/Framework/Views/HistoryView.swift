//
//  ContentView.swift
//  ExamenMoviles
//
//  Created by Leví Diaz on 21/11/24.
//

import SwiftUI

extension String {
    func cleanHTML() -> String {
        return self
            .replacingOccurrences(of: "&amp;", with: "&")
            .replacingOccurrences(of: "amp;", with: "") // Handles repeated encodings
    }
}


struct HistoryView: View {
    
    
    @StateObject var viewModel: HistoryViewModel
    @State var categories: [String] = []
    @State var histories: [History] = []
    var body: some View {
        NavigationView{
            VStack {
                List(self.categories, id: \.self) { category in
                    NavigationLink {
                        DetailsHistoryView(category: category, histories: histories)
                    } label: {
                        VStack {
                            Text(String(category.cleanHTML()))
                        }
                        
                    }
                    
                }
                
            }
            .navigationTitle("History")
            .task {
                let fetchedCategories = await viewModel.fetchPlaces() ?? []
                self.categories = fetchedCategories
                let fetchedHistories = await viewModel.fetchHistory() ?? []
                self.histories = fetchedHistories
                // print("Called from View: \(self.categories)")
            }
            
        }
            
            
    }
    
}
