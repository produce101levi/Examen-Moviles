//
//  ContentView.swift
//  ExamenMoviles
//
//  Created by Leví Diaz on 21/11/24.
//

import SwiftUI

struct HistoryView: View {
    @StateObject var viewModel: HistoryViewModel
    @State var categories: [String] = []
    @State var histories: [History] = []
    var body: some View {
        NavigationView{
            VStack {
                Text("History List")
                List(self.categories, id: \.self) { category in
                    NavigationLink {
                        PlaceHistoryView(category: category, histories: histories)
                    } label: {
                        Text(category)
                    }
                    
                }
                
            }.task {
                let fetchedCategories = await viewModel.fetchPlaces() ?? []
                self.categories = fetchedCategories
                let fetchedHistories = await viewModel.fetchHistory() ?? []
                self.histories = fetchedHistories
                // print("Called from View: \(self.categories)")
            }
        }
            
            
    }
    
}
