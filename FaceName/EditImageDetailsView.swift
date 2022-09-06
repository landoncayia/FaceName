//
//  EditImageDetailsView.swift
//  FaceName
//
//  Created by Landon Cayia on 9/3/22.
//

import SwiftUI

struct EditImageDetailsView: View {
    @Environment(\.dismiss) var dismiss
    
    var userImage: UserImage
    
    @State private var name = ""
    
    var body: some View {
        Form {
            Section {
                Image(uiImage: userImage.image)
                    .resizable()
                    .scaledToFit()
            }
            
            Section {
                TextField("Name this image", text: $name)
                
                Button("Save image") {
                    dismiss()
                }
            }
        }
    }
}

struct EditImageDetails_Previews: PreviewProvider {
    static var previews: some View {
        EditImageDetailsView(userImage: UserImage.example)
    }
}
