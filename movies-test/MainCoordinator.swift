//
//  MainCoordinator.swift
//  movies-test
//
//  Created by Paulo Lazarini on 27/01/23.
//

import UIKit
import SwiftUI
import Moya

class Coordinator {

    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    let viewModel = MainViewModel(networkProvider: NetworkManager())
    
    func start() {
        let view = MainView(viewModel: viewModel, searchText: "", coordinator: self)
        
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func presentFavoriteMovie() {
        let view = FavoriteView(viewModel: viewModel, searchText: "", coordinator: self)
        
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func presentFilter() {
        let view = Filter(viewModel: viewModel, coordinator: self)
        
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func presentFilterGenre() {
        let view = FilterGenre(viewModel: viewModel, coordinator: self)
        
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func presentFilterDate() {
        let view = FilterDate(viewModel: viewModel, coordinator: self)
        
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: false)
    }
}


