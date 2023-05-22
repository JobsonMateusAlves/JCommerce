//
//  ProductDetailCoordinator.swift
//  JCommerce
//
//  Created by Jobson Mateus on 20/05/23.
//

import UIKit
import Domain
import Presentation
import Data

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
            let viewModel = Presentation.ProductDetailFactory.makeViewModel(
                product: product,
                useCases: Domain.PurchaseFactory.makeUseCase(
                    repository: PurchaseFactory.makeRepository()
                )
            )
            
            let controller = ProductDetailViewController(
                viewModel: viewModel,
                coordinator: self
            )
            navigationController.pushViewController(controller, animated: true)
        }
    }
    
    func finishProductDetailFlow() {
        navigationController.popViewController(animated: true)
        finish?()
    }
}
