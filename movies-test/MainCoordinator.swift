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
        let view = FavoriteView(viewModel: viewModel, coordinator: self, searchText: "")
        
        
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: false)
    }
}


