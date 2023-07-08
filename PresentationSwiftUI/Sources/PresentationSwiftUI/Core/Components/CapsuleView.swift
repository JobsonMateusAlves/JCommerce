//
//  CapsuleView.swift
//  
//
//  Created by Jobson Mateus on 10/06/23.
//

import SwiftUI

struct CapsuleView: View {
    let value: String
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(Color.primaryColor)
            
            Text(value)
                .foregroundColor(.terciaryText)
                .font(.system(size: 12, weight: .medium))
                .padding(.horizontal, 8)
        }
        .frame(height: 20)
        .fixedSize()
    }
}

struct CapsuleView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CapsuleView(value: "-100%")  
        }
    }
}
