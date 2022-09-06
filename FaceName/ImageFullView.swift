//
//  ImageFullView.swift
//  FaceName
//
//  Created by Landon Cayia on 9/6/22.
//

import SwiftUI

struct ImageFullView: View {
    let userImage: UserImage
    
    var body: some View {
        Image(uiImage: userImage.image)
            .resizable()
            .scaledToFit()
            .navigationTitle(userImage.name)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct ImageFullView_Previews: PreviewProvider {
    static var previews: some View {
        ImageFullView(userImage: UserImage.example)
    }
}
