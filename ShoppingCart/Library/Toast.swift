//
//  Toast.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/8/20.
//

import SwiftUI

struct Toast<Presenting>: View where Presenting: View {

    /// The binding that decides the appropriate drawing in the body.
    @Binding var isPresented: Bool
    /// The view that will be "presenting" this toast
    let presenting: () -> Presenting
    /// The text to show
    let text: Text
    let delay: TimeInterval = 1.5

    var body: some View {
        if self.isPresented {
            DispatchQueue.main.asyncAfter(deadline: .now() + self.delay) {
                withAnimation {
                    self.isPresented = false
                }
            }
        }
         return GeometryReader { geometry in
                    ZStack(alignment: .center) {
                        self.presenting()

                        VStack {
                            self.text
                        }
                        .frame(width: geometry.size.width / 2,
                               height: geometry.size.height / 5)
                        .background(Color.secondary.colorInvert())
                        .foregroundColor(Color.primary)
                        .cornerRadius(20)
                        .transition(.slide)
                        .opacity(self.isPresented ? 1 : 0)

                    }
            }

    }

}
