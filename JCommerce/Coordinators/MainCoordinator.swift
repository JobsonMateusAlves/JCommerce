//
//  MainCoordinator.swift
//  JCommerce
//
//  Created by Jobson Mateus on 20/05/23.
//

import UIKit
import Presentation

class MainCoordinator: Coordinator {
    var finish: (() -> Void)?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        startProductsFlow()
    }
    
    private func startProductsFlow() {
        let coordinator = ProductsCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
