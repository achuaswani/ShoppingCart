//
//  ProductListView.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/25/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import SwiftUI

struct ProductListView: View {
    
    @ObservedObject
    var viewModel: ProductListViewModel
    var session = FirebaseSession()
    
    init(viewModel: ProductListViewModel) {
        self.viewModel = viewModel
        
        if #available(iOS 14.0, *) {
            // iOS 14 doesn't have extra separators below the list by default.
        } else {
            // To remove only extra separators below the list:
            UITableView.appearance().tableFooterView = UIView()
        }

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.products) { product in
                    ProductRow(product: product)
                }
                .onAppear {
                        self.viewModel.loadProducts()
                    }
                .navigationBarTitle("Product List")
                .navigationBarItems(trailing: Button(action: {
                    self.session.signout()
                }) {
                    Text("Logout")
                })
            }
    }
}

#if DEBUG
struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ProductListViewModel(service:ProductService())
        return ProductListView(viewModel: viewModel)
    }
}
#endif
