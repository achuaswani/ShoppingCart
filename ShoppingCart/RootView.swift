//
//  RootViewController.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/25/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import SwiftUI

struct RootView: View {
    //MARK: Properties
    @ObservedObject var session = FirebaseSession()
    var body: some View {
        
        NavigationView {
            VStack {
                if session.user != nil {
                    ProductListView(viewModel: ProductListViewModel(service: ProductService()))
                } else {
                    SigninView()
                }
            }
            .navigationBarHidden(true)
            .onAppear(perform: getUser)
        }
    }
    
    //MARK: Functions
    func getUser() {
        session.listen()
    }
}

struct RootViewController_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
