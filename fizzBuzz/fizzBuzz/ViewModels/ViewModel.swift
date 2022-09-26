//
//  ViewModel.swift
//  FizzBuzz
//
//  Created by Mohamed Ali BELHADJ on 23/9/2022.
//

import Foundation
import Combine

final class ViewModel: ObservableObject {
    @Published var firstNumber: Int? = nil
    @Published var secondNumber: Int? = nil
    @Published var firstString: String = ""
    @Published var secondString: String = ""
    @Published var limit: Int? = nil
    
    @Published var isValidForm = false
    
    @Published var shouldShowResults = false
    
    var results: [Item] = []
    @Published var finalResults: [Item] = []
    
    
    private(set) lazy var interactor: InteractorProtocol? = nil
    
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    // Needed for RandomAccessCollection
    var startIndex: Int = 0
    var endIndex: Int { results.endIndex }
    
    // Needed for loading data
    var firstItemToLoad = 0
    var lastItemToLoad = 1
    
    init() {
        isValidFormPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValidForm, on: self)
            .store(in: &cancellables)
    }
}

extension ViewModel {
    func fetchResults() async {
        guard let limit = limit, let firstNumber = firstNumber, let secondNumber = secondNumber else { return }
        interactor = Interactor(limit: limit, firstNumber: firstNumber, secondNumber: secondNumber, firstWord: firstString, secondWord: secondString)
        
        if let unwrappedResults = await interactor?.invoke() {
            DispatchQueue.main.async { [weak self] in
                self?.results.reserveCapacity(limit)
                self?.results = unwrappedResults
                    .lazy
                    .map { Item(description: $0) }
                self?.shouldShowResults = self?.results.count == limit
                self?.loadMoreItems()
            }
        }
    }
    
    func clear() {
        finalResults.removeAll(keepingCapacity: false)
        results.removeAll(keepingCapacity: false)
        firstNumber = nil
        secondNumber = nil
        firstString = ""
        secondString = ""
        limit = nil
        firstItemToLoad = 0
        lastItemToLoad = 1
    }
}

private extension ViewModel {
    var areValidNumbersPublisher: AnyPublisher<Bool, Never> {
        Publishers
            .CombineLatest3($firstNumber, $secondNumber, $limit)
            .map { ($0 ?? 0 > 0) && ($1 ?? 0 > 0) && ($2 ?? 0 > 0) }
            .eraseToAnyPublisher()
    }
    
    var areValidStringsPublisher: AnyPublisher<Bool, Never> {
        Publishers
            .CombineLatest($firstString, $secondString)
            .map { !$0.isEmpty && !$1.isEmpty}
            .eraseToAnyPublisher()
    }
    
    var isValidFormPublisher: AnyPublisher<Bool, Never> {
        Publishers
            .CombineLatest(areValidStringsPublisher, areValidNumbersPublisher)
            .map { $0 && $1 }
            .eraseToAnyPublisher()
    }
}
