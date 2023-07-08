//
//  ProductsHeaderView.swift
//  
//
//  Created by Jobson Mateus on 10/06/23.
//

import SwiftUI

struct ProductsHeaderView: View {
    var numberOfProducts: Int
    
    @State var isOnSale: Bool = false
    
    var body: some View {
        HStack(spacing: 8) {
            Text("\(numberOfProducts) Products")
                .foregroundColor(.primaryText)
                .font(.system(size: 14, weight: .regular))
            
            Spacer()
            
            HStack(spacing: 0) {
                Text("On Sale")
                    .foregroundColor(.primaryText)
                    .font(.system(size: 14, weight: .semibold))
                
                Toggle("", isOn: $isOnSale)
                    .tint(.primaryColor)
                    .fixedSize()
            }
        }
        .padding(.horizontal, 16)
    }
}

struct ProductsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsHeaderView(numberOfProducts: 22)
    }
}
