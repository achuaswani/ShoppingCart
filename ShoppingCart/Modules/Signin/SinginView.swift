//
//  SinginView.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/25/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import SwiftUI

struct SigninView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isNavigationBarHidden = true
    @State var showErrorMessage = false
    @State var errorMessage = ""
    
    @ObservedObject var session = FirebaseSession()

    var body: some View {
        NavigationView {
            VStack {
                header
                textFieldSection
                if showErrorMessage {
                    Text(errorMessage)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(.red)
                }
                Spacer()
                buttonView
                Spacer()
                registerAccount
                Spacer()
            } .padding(.top, 0)
            .background(
            LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all))
        }
        .navigationBarHidden(isNavigationBarHidden)
        .navigationBarTitle("")
        .onAppear {
            self.isNavigationBarHidden = true
        }
        .onDisappear {
            self.isNavigationBarHidden = false
        }
    }
}

private extension SigninView {
    var header: some View {
         VStack {
            Image("AppIcon")
                .resizable()
                .frame(width: 250, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10.0, x: 20, y: 10)
            Spacer()
            Text("Login to Tokenz")
                .font(.system(size: 42, weight: .bold, design: .rounded))
            .foregroundColor(Color.black)
            .shadow(radius: 10.0, x: 20, y: 10)
        }
    }
    
    var textFieldSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Spacer()
            TextField("Email", text: self.$email)
              .padding()
              .foregroundColor(Color.black)
              .background(Color.normalTextField)
              .cornerRadius(20.0)
            SecureField("Password", text: self.$password)
              .padding()
              .foregroundColor(Color.black)
              .background(Color.normalTextField)
              .cornerRadius(20.0)
        }.padding([.leading, .trailing], 27.5)
    }
    
    var buttonView: some View {
        VStack {
            Spacer()
            Button(action: signin) {
                Text("Sign In")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .buttonStyle(PrimaryButton())
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.normalButton)
                    .cornerRadius(15.0)
                    .shadow(radius: 10.0, x: 5, y: 5)
            }.padding(.top, 50)
            Spacer()
        }
    }
    
    var registerAccount: some View {
        HStack(spacing: 0) {
            Text("Don't have an account? ")
                .font(.system(size: 18, weight: .bold, design: .rounded))
            NavigationLink(destination: SignupView()) {
                Text("Sign Up")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
            }
        }.padding(.top, 50)
    }
    
    //MARK: Functions
    func signin() {
        session.signin(email: email, password: password) { (result, error) in
            if error != nil {
                self.showErrorMessage = true
                self.errorMessage = error?.localizedDescription ?? "Error"
            } else {
                self.showErrorMessage = true
                self.errorMessage = ""
                _ = ProductListView(viewModel: ProductListViewModel(service: ProductService()))
            }
        }
    }
}

#if DEBUG
struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}
#endif
