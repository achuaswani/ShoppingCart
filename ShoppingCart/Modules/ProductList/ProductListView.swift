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
    @State var show = false
    @State var selected: Product?
    @State var search = ""
    @State var selectedMenu = "All"
    
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
            VStack {
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        //.font(.title2)
                        .foregroundColor(.white)
                    
                    TextField("Search", text: $search)
                }
                .padding()
                .background(Color("search"))
                .cornerRadius(15)
                .padding()
                NavigationLink(destination:
                                CartView(viewModel: CartViewModel(service: viewModel.service))) {
                    Text("View Cart")
                        .foregroundColor(.black)
                }
                HStack(spacing: 10) {
                    ForEach(viewModel.categories,id: \.self) { title in
                        MenuButton(title: title, selected: $selectedMenu)
                        // giving space for all expect for last...
                        if title != viewModel.categories.last {
                            Spacer(minLength: 0)
                        }
                    }
                }
                .padding()
                productList
            }
            .background(Color("BG"))
            .padding(.vertical)
            .navigationBarTitle("Product List", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.session.signout()
            }) {
                Text("Logout")
            })
        }
    
    }
    
    @ViewBuilder
    var productList: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(viewModel.products) { product in
                    ProductCard(product: product, viewModel: viewModel)
                        .shadow(color: Color.black.opacity(0.16), radius: 5, x: 0, y: 5)
                }
                .onAppear {
                    self.viewModel.loadProducts()
                }
            }
            .contentShape(Rectangle())
        }
        .padding(.horizontal,22)
    }
    struct MenuButton : View {
        
        var title : String
        @Binding var selected : String
        
        var body: some View{
            
            Button(action: {selected = title}) {
                Text(title)
                    .font(.system(size: 15))
                    .fontWeight(selected == title ? .bold : .none)
                    .padding(.vertical,10)
                    .padding(.horizontal,20)
                    .background(Color("search").opacity(selected == title ? 1 : 0))
                    .cornerRadius(10)
            }
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
