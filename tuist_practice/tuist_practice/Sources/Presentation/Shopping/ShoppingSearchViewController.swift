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
    enum SectionType: Int {
        case filter
        case products
    }
    // MARK: -- View Properties...
    private lazy var shoppingListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    private let navigationSearchController = UISearchController()
    private let rootContainerView: UIView = UIView()
    
    // MARK: -- Private Properties...
    private let viewModel: ShoppingViewModel
    
    // MARK: -- Init...
    init(viewModel: ShoppingViewModel) {
        self.viewModel = viewModel
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
    
    // viewIsAppearing은 transition중에 한번만 호출되고 view가 나타날때 레이아웃이 필요하지 않더라도 호출됩니다.
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
    }
    
    // 여러번 호출될 가능성이 있는 ~LayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootContainerView.pin.all(view.safeAreaInsets)
        rootContainerView.flex.layout(mode: .adjustHeight)
    }
    
    func configureNavigation() {
        self.navigationItem.title = "쇼핑 검색"
        self.navigationItem.largeTitleDisplayMode = .always
        navigationSearchController.searchBar.placeholder = "검색어를 입력하세요"
        self.navigationItem.searchController = navigationSearchController
    }
    
    func configureView() {
        self.view.backgroundColor = .systemBackground
    }
}

extension ShoppingSearchViewController: UICollectionViewDelegate {
    func configureCollectionView() {
        
    }
    
    var collectionViewLayout: UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] idx, environment in
            guard let sectionType = SectionType(rawValue: idx) else {
                assertionFailure("Don't exist items")
                return NSCollectionLayoutSection.list(using: .init(appearance: .plain), layoutEnvironment: environment)
            }
            switch sectionType {
            case .filter:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(60), heightDimension: .fractionalHeight(0.8)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            case .products:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(60), heightDimension: .fractionalHeight(0.8)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
        }
    }
}
