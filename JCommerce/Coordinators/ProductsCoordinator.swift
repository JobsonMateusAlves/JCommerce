//
//  ProductsCoordinator.swift
//  JCommerce
//
//  Created by Jobson Mateus on 20/05/23.
//

import UIKit
import Domain
import Presentation
import Data

class ProductsCoordinator: Coordinator, Products {
    var finish: (() -> Void)?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = Presentation.ProductsFactory.makeViewModel(
            useCase: Domain.ProductsFactory.makeUseCase(
                repository: ProductsFactory.makeRepository()
            )
        )
        
        let controller = ProductsViewController(viewModel: viewModel, coordinator: self)
        UIView.transition(with: navigationController.view, duration: 0.5, options: [.transitionCrossDissolve]) { [weak self] in
            self?.navigationController.setViewControllers([controller], animated: true)
        }
    }
    
    func startShoppingCartFlow() {
        let coordinator = ShoppingCartCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func startProductDetailFlow(product: Product) {
        let coordinator = ProductDetailCoordinator(navigationController: navigationController)
        coordinator.product = product
        coordinator.finish = { [weak self] in
            self?.childCoordinators.removeLast()
            self?.startShoppingCartFlow()
        }
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
