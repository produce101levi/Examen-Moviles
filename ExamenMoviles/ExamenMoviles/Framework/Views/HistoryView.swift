//
//  ContentView.swift
//  ExamenMoviles
//
//  Created by Leví Diaz on 21/11/24.
//

import SwiftUI

struct HistoryView: View {
    @StateObject var viewModel: HistoryViewModel
    @State var histories: [History] = []
    var body: some View {
        VStack {
            List(histories, id: \.id) { history in
                HStack {
                    Text(history.description)
                    Spacer()
                    Text(history.date)
                    Spacer()
                    Text(history.place)
                }
            }
        }.task {
            let fetchedHistories = await viewModel.fetchHistory()
            self.histories = fetchedHistories!
        }
        
    }
}
