//
//  ProductListView.swift
//  
//
//  Created by Jobson Mateus on 10/06/23.
//

import SwiftUI
import Domain

public struct ProductListView: View {
    
    @ObservedObject var viewModel: ProductListViewModel
    
    let gridItems: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    public var body: some View {
        ScrollView {
            ProductsHeaderView(numberOfProducts: viewModel.products.count)
            
            LazyVGrid(columns: gridItems, spacing: 16) {
                ForEach(viewModel.products, id: \.codeColor) { item in
                    ProductView(product: item)
                        .frame(height: 208)
                        .onTapGesture {
                            // TODO: Action
                        }
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
        .background(Color.primaryBackgroundColor)
        .navigationBarItems(
            trailing: HStack {
                Button(
                    action: {
                        
                    }
                ) {
                    Image.shoppingCartIcon
                        .tint(.primaryColor)
                }
            }
        )
        .onAppear {
            viewModel.fetchProducts(filterByOnSale: false) {
                
            }
        }
    }
    
    public init(viewModel: ProductListViewModel) {
        self.viewModel = viewModel
    }
}

//struct ProductListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductListView(
//            viewModel: ProductListViewModelImpl(
//                getProductListUseCase: <#T##GetProductListUseCase#>
//            )
//        )
//    }
//}
