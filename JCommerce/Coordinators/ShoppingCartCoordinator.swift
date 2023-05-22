//
//  ShoppingCartCoordinator.swift
//  JCommerce
//
//  Created by Jobson Mateus on 21/05/23.
//

import UIKit
import Domain
import Presentation

class ShoppingCartCoordinator: Coordinator, ShoppingCart {
    var finish: (() -> Void)?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        
        let controller = ShoppingCartViewController(
            viewModel: ShoppingCartFactory.createViewModel(),
            coordinator: self
        )
        navigationController.pushViewController(controller, animated: true)
    }
}
