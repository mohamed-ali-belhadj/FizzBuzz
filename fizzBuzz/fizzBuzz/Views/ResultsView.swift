//
//  ResultsView.swift
//  FizzBuzz
//
//  Created by Mohamed Ali BELHADJ on 24/9/2022.
//

import SwiftUI

struct ResultsView: View {
    @ObservedObject private var viewModel: ViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            List(viewModel.results) { singleResult in
                Row(singleResult: singleResult.description)
                    .onAppear { viewModel.loadMoreItems(singleResult)}
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action : {
                viewModel.clear()
                mode.wrappedValue.dismiss()
            }){
                Image(systemName: "arrow.left")
            })
        .navigationBarTitle("Results")
    }
}


extension ResultsView {
    struct Row: View {
        var singleResult: String
        var body: some View {
            Text(singleResult)
                .foregroundColor(.black.opacity(0.8))
                .padding()
        }
    }
}

//struct ResultsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView.ResultsView(results: [])
//    }
//}
