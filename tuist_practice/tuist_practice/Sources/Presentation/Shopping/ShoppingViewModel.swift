//
//  ShoppingViewModel.swift
//  tuist_practice
//
//  Created by Greem on 6/7/25.
//

import Foundation
import Combine

struct DisplayProduct {
    var isLike: Bool
    var title: String
}

final class ShoppingViewModel {
    
    private let searchUseCase: SearchProductUseCase
    
    enum Action {
        case requestSearchItems(term: String)
        case heartTapped
    }
    
    enum Mutation {
        case setItemLike(Bool)
        case fetchItems([DisplayProduct])
    }
    
    struct State {
        var products: [DisplayProduct] = []
    }
    
    // MARK: - Subjects
    @Published private(set) var state = State()
    private let actionSubject: PassthroughSubject<Action, Never> = .init()
    private let mutationSubject: PassthroughSubject<Mutation, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    init(searchUseCase: SearchProductUseCase = DefaultSearchProduct()) {
        self.searchUseCase = searchUseCase
        
        let actionMutationPublisher: AnyPublisher<Mutation, Never> = actionSubject.flatMap {
            self.mutate(action: $0)
        }.eraseToAnyPublisher()
        
        transform(mutation: actionMutationPublisher)
            .scan(state) { [unowned self] state, mutation in
                self.reduce(state: state, mutation: mutation)
            }
            .sink { [weak self] newState in
                self?.state = newState
            }
            .store(in: &cancellables)
    }
    
    func action(_ action: Action) {
        actionSubject.send(action)
    }
    
    // MARK: - Private
    private func mutate(action: Action) -> AnyPublisher<Mutation, Never> {
        var state = self.state // 현재 State 값 캡쳐링
        switch action {
        case .heartTapped:
            return Just(Mutation.setItemLike(false)).eraseToAnyPublisher()
        case .requestSearchItems(term: let terms):
            return Just(Mutation.setItemLike(false)).eraseToAnyPublisher()
        }
    }
    
    private func transform(mutation: AnyPublisher<Mutation, Never>) -> AnyPublisher<Mutation, Never> {
        mutation
    }

    private func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setItemLike(let isLike): break
//            newState.products[0].isLike = isLike
        case .fetchItems(let items):
            newState.products = items
        }
        return newState
    }
    
}
