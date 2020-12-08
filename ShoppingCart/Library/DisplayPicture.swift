//
//  DisplayPicture.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/9/20.
//

import SwiftUI

struct DisplayPicture: View {
    @State var profile: Profile
    @State var image: Image? = Image("noImage")
    @State var isShowPicker: Bool = false
    var body: some View {
        HStack {
            Spacer()
            getImageFromURL(urlString: profile.image)
            Spacer()
        }
    }
    
    func getImageFromURL(urlString: String) -> AnyView {
        return  AnyView(AsyncImage(
                       urlString: urlString,
                       placeholder: image!.resizable().aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.black)
                   )
            .padding()
            .aspectRatio(contentMode: .fit)
            .sheet(isPresented: $isShowPicker) {
                ImagePicker(image: self.$image, profile: $profile)
                        
                    }
            .onTapGesture{
                isShowPicker = true
            }
        )
    }
}

struct DisplayPicture_Previews: PreviewProvider {
    static var previews: some View {
        DisplayPicture(profile: Profile.default)
    }
}
