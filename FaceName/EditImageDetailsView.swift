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
    var onSave: (UserImage) -> Void
    
    var newUserImage: UserImage {
        var newUserImage = userImage
        newUserImage.name = name
        
        return newUserImage
    }
    
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
                    onSave(newUserImage)
                    dismiss()
                }
            }
        }
    }
}

struct EditImageDetails_Previews: PreviewProvider {
    static var previews: some View {
        EditImageDetailsView(userImage: UserImage.example) { _ in }
    }
}
