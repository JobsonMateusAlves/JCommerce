//
//  ProductView.swift
//  
//
//  Created by Jobson Mateus on 10/06/23.
//

import SwiftUI
import Domain

struct ProductView: View {
    
    var product: Product
    
    var body: some View {
        ZStack {
            backgroundView
            
            foregroundView
            
            if product.onSale {
                VStack(alignment: .trailing) {
                    CapsuleView(value: "-\(product.discountPercentage)")
                    
                    Spacer()
                }
                .padding(.top, 8)
                .padding(.trailing, 8)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
            }
        }
    }
    
    var foregroundView: some View {
        VStack(alignment: .leading) {
            imageView
            
            Text(product.name.capitalized)
                .foregroundColor(.primaryText)
                .font(.system(size: 16, weight: .bold))
                .multilineTextAlignment(.leading)
            
            Spacer(minLength: 0)

            HStack {
                VStack(alignment: .leading) {
                    if product.onSale {
                        Text(product.regularPrice)
                            .font(.system(size: 13, weight: .medium))
                            .strikethrough(color: .primaryText)
                    }

                    Text(product.actualPrice)
                        .font(.system(size: 14, weight: .bold))
                }
                .foregroundColor(.primaryText)

                Spacer()

                Image.shoppingBagIcon
                    .frame(
                        width: 24,
                        height: 24
                    )
                    .foregroundColor(Color.primaryColor)
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 12)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        
    }
    
    var imageView: some View {
        VStack {
            AsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image.placeholderImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 90)
        .cornerRadius(8)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.border, lineWidth: 1)
        }
    }
    
    var backgroundView: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(
                Color.secondaryBackgroundColor
                    .shadow(
                        .drop(
                            color: Color.black.opacity(0.3),
                            radius: 8,
                            x: 0,
                            y: 4
                        )
                    )
            )
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 0) {
            ProductView(
                product: Product(
                    name: "VESTIDO TRANSPASSE BOW",
                    style: "20002605",
                    codeColor: "20002605_613",
                    colorSlug: "tapecaria",
                    color: "TAPEÇARIA",
                    onSale: false,
                    regularPrice: "R$ 199,90",
                    actualPrice: "R$ 199,90",
                    discountPercentage: "",
                    installments: "3x R$ 66,63",
                    image: "https://d3l7rqep7l31az.cloudfront.net/images/products/20002605_615_catalog_1.jpg?1460136912",
                    sizes: []
                )
            )
                .frame(height: 208)
            
            ProductView(
                product: Product(
                    name: "VESTIDO TRANSPASSE BOW",
                    style: "20002605",
                    codeColor: "20002605_613",
                    colorSlug: "tapecaria",
                    color: "TAPEÇARIA",
                    onSale: true,
                    regularPrice: "R$ 199,90",
                    actualPrice: "R$ 159,90",
                    discountPercentage: "10%",
                    installments: "3x R$ 66,63",
                    image: "https://d3l7rqep7l31az.cloudfront.net/images/products/20002605_615_catalog_1.jpg?1460136912",
                    sizes: []
                )
            )
                .frame(height: 208)
        }
//        .padding(.horizontal, 16)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
        .background(Color.primaryBackgroundColor)
    }
}
