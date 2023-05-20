//
//  ProductDetailCoordinator.swift
//  JCommerce
//
//  Created by Jobson Mateus on 20/05/23.
//

import UIKit
import Domain
import Presentation

class ProductDetailCoordinator: Coordinator, ProductDetail {
    var finish: (() -> Void)?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var product: Product?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if let product = self.product {
            let controller = ProductDetailViewController(
                viewModel: ProductDetailFactory.createViewModel(product: product),
                coordinator: self
            )
            navigationController.pushViewController(controller, animated: true)
        }
    }
}
