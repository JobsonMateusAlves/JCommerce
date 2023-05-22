//
//  ShoppingCartCoordinator.swift
//  JCommerce
//
//  Created by Jobson Mateus on 21/05/23.
//

import UIKit
import Domain
import Presentation
import Data

class ShoppingCartCoordinator: Coordinator, ShoppingCart {
    var finish: (() -> Void)?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = Presentation.ShoppingCartFactory.makeViewModel(
            useCases: Domain.PurchaseFactory.makeUseCase(
                repository: PurchaseFactory.makeRepository()
            )
        )
        
        let controller = ShoppingCartViewController(
            viewModel: viewModel,
            coordinator: self
        )
        navigationController.pushViewController(controller, animated: true)
    }
}
