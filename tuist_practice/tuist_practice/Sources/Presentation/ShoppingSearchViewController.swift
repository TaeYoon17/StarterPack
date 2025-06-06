//
//  ShoppingSearchViewController.swift
//  tuist_practice
//
//  Created by Greem on 6/1/25.
//

import UIKit
import Combine
import FlexLayout
import PinLayout

final class ShoppingSearchViewController: UIViewController {
    
    // MARK: -- View Properties...
    
    private let shoppingListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    private let rootContainerView: UIView = UIView()
    
    
    // MARK: -- Init...
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
        
        view.addSubview(rootContainerView)
        rootContainerView.flex.direction(.column).define { flex in
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("Don't use StoryBoard")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        rootContainerView.pin.all(view.safeAreaInsets)
        rootContainerView.flex.layout(mode: .adjustHeight)
    }
    
    func configureNavigation() {
        self.navigationItem.title = "쇼핑 검색"
        let navigationSearchController = UISearchController()
        navigationSearchController.searchBar.placeholder = "검색어를 입력하세요"
        self.navigationItem.searchController = navigationSearchController
    }
    
    func configureView() {
        self.view.backgroundColor = .systemBackground
    }
}
