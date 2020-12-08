//
//  TestView.swift
//  ShoppingCart
//
//  Created by Aswani G on 9/5/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import SwiftUI

struct TestView: View {
    @State var search = ""
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
                                SecondView()) {
                    Text("Second View")
                        .foregroundColor(.black)
                }
                VStack(spacing: 105) {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(0..<100) { i in
                            ThirdView(index: i)
                            Spacer()
                        }
                        
                    }
                }
                .padding(.horizontal,22)
            }
            .padding(.vertical)
            .navigationBarTitle("List")
            .edgesIgnoringSafeArea(.bottom)
        }
    }
            
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

struct SecondView: View {
    var body: some View {
        Text("Second View")
    }
}
struct ThirdView: View {
    var index: Int
    var body: some View {
        NavigationLink(destination: FourthView()) {
            Text("Third\(index) View")
            Spacer()
            Text("Content")
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct FourthView: View {
    var body: some View {
        Text("Fourth View")
    }
}
