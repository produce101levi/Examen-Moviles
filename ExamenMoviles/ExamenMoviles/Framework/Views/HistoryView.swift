//
//  ContentView.swift
//  ExamenMoviles
//
//  Created by Leví Diaz on 21/11/24.
//

import SwiftUI

struct HistoryView: View {
    @StateObject var viewModel: HistoryViewModel
    @State var places: [String] = []
    var body: some View {
        NavigationView{
            VStack {
                Text("History List")
                List(self.places, id: \.self) { place in
                    NavigationLink {
                        Text("TODO: add History Detail View")
                    } label: {
                        Text(place)
                    }
                    
                }
                
            }.task {
                let fetchedPlaces = await viewModel.fetchPlaces() ?? []
                self.places = fetchedPlaces
                print("Called from View: \(self.places)")
                // self.histories = fetchedHistories ?? []
            }
        }
            
            
    }
    
}
