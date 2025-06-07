//
//  ShoppingViewModel.swift
//  tuist_practice
//
//  Created by Greem on 6/7/25.
//

import Foundation
import Combine

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

protocol ShoppingRepositoryProtocol { }

class ShoppingRepositoryDefault: ShoppingRepositoryProtocol { }

final class ShoppingViewModel {
    
    private let shoppingRepository: ShoppingRepositoryProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let refreshTrigger: AnyPublisher<Void, Never>
        let createUserTrigger: AnyPublisher<(name: String, email: String), Never>
    }
    
    struct Output {
        var items: CurrentValueSubject<[String], Never>
        let isLoading: AnyPublisher<Bool, Never>
        let error: AnyPublisher<String?, Never>
        let userCreated: AnyPublisher<String, Never>
    }
    
    // MARK: - Subjects
    private let usersSubject = CurrentValueSubject<[String], Never>([])
    private let loadingSubject = CurrentValueSubject<Bool, Never>(false)
    private let errorSubject = CurrentValueSubject<String?, Never>(nil)
    private let userCreatedSubject = PassthroughSubject<String, Never>()
    
    init(shoppingRepository: ShoppingRepositoryProtocol = ShoppingRepositoryDefault()) {
        self.shoppingRepository = shoppingRepository
    }
    
    func transform(input: Input) -> Output {
        
        Publishers.Merge(input.refreshTrigger, input.viewDidLoad)
            .sink { [weak self] _ in
                guard let self else { return }
            }
            .store(in: &cancellables)
        
        return Output(
            items: .init(["Hello"]),
            isLoading: loadingSubject.eraseToAnyPublisher(),
            error: errorSubject.eraseToAnyPublisher(),
            userCreated: userCreatedSubject.eraseToAnyPublisher()
        )
    }
    
}
