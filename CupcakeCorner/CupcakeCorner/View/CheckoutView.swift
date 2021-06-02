//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Cao Mai on 6/1/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order

    var body: some View {
        Text("Checkout View")
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
