//
//  JCommerceSwiftUIApp.swift
//  JCommerceSwiftUI
//
//  Created by Jobson Mateus on 10/06/23.
//

import SwiftUI
import PresentationSwiftUI
import Domain
import Data

@main
struct JCommerceSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ProductListView(
                    viewModel: ProductListViewModel(
                        getProductListUseCase: Domain.ProductsFactory.makeUseCase(
                            repository: ProductsFactory.makeRepository()
                        )
                    )
                )
                    .navigationTitle("JCommerce")
                    .navigationBarTitleDisplayMode(.large)
            }
        }
    }
}
