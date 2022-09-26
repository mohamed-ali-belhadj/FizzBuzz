//
//  ContentView.swift
//  FizzBuzz
//
//  Created by Mohamed Ali BELHADJ on 23/9/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var isPerformingTask = false
    var body: some View {
        NavigationView {
            ZStack {
                Group {
                    NavigationLink(isActive: $viewModel.shouldShowResults) {
                        ResultsView(viewModel: self.viewModel)
                        .onAppear {
                            isPerformingTask = (viewModel.results.count == viewModel.limit)
                        }
                        .onDisappear {
                            isPerformingTask = false
                        }
                    } label: {
                        Text("Show results")
                    }
                }.hidden()
                Form {
                    Section(
                        header: Text("NUMBERS"),
                        footer: Text("make sure you enter positive numbers starting from 1.")) {
                            TextField("First number", text: Binding<String>
                                .init(
                                    get: {
                                        viewModel.firstNumber.map { String($0) } ?? ""
                                    },
                                    set: {
                                        viewModel.firstNumber = Int($0)
                                    }))
                            .keyboardType(.numberPad)
                            TextField("Second number", text: Binding<String>
                                .init(
                                    get: {
                                        viewModel.secondNumber.map { String($0) } ?? ""
                                    },
                                    set: {
                                        viewModel.secondNumber = Int($0)
                                    }))
                            .keyboardType(.numberPad)
                        }
                    
                    Section(header: Text("WORDS")) {
                        TextField("First word", text: $viewModel.firstString)
                        TextField("Second word", text: $viewModel.secondString)
                    }
                    
                    Section(
                        header: Text("LIMIT"),
                        footer: Text("Limit represents the maximum number to reach when applying Fizz Buzz algorithm")) {
                            TextField("Limit", text: Binding<String>
                                .init(
                                    get: {
                                        viewModel.limit.map { String($0) } ?? ""
                                    },
                                    set: {
                                        viewModel.limit = Int($0)
                                    }))
                            .keyboardType(.numberPad)
                        }
                    
                    Section {
                        Button {
                            isPerformingTask = true
                            Task {
                                await viewModel.fetchResults()
                            }
                        } label: {
                            Text("Show results")
                        }
                    }
                    .disabled(!viewModel.isValidForm || isPerformingTask)
                }
                
               
                if isPerformingTask {
                    ProgressView("Calculating")
                        .progressViewStyle(.circular)
                }
            }
            .navigationBarTitle("Fizz Buzz")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
