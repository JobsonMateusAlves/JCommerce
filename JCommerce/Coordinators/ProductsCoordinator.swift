//
//  ProductsCoordinator.swift
//  JCommerce
//
//  Created by Jobson Mateus on 20/05/23.
//

import UIKit
import Presentation

class ProductsCoordinator: Coordinator, Products {
    var finish: (() -> Void)?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = ProductsViewController(viewModel: ProductsFactory.createViewModel(), coordinator: self)
        UIView.transition(with: navigationController.view, duration: 0.5, options: [.transitionCrossDissolve]) { [weak self] in
            self?.navigationController.setViewControllers([controller], animated: true)
        }
    }
    
    func startShoppingCartFlow() {
        
    }
}
