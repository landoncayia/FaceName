//
//  ContentView.swift
//  FaceName
//
//  Created by Landon Cayia on 9/3/22.
//

import SwiftUI

/// Determines which sheet is currently active for the main view.
enum ActiveSheet: Hashable, Identifiable {
    case picker, editDetails

    var id: ActiveSheet { self }
}

struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    @State private var activeSheet: ActiveSheet?
    
    var body: some View {
        NavigationView {
            VStack {
                image?
                    .resizable()
                    .scaledToFit()
            }
            .navigationTitle("FaceName")
            .toolbar {
                ToolbarItem {
                    Button {
                        activeSheet = .picker
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $activeSheet) { item in
                switch item {
                case .picker:
                    ImagePicker(image: $inputImage)
                case .editDetails:
                    EditImageDetailsView(userImage: UserImage(id: UUID(), name: "", photo: inputImage ?? UIImage()))
                }
            }
            .onChange(of: inputImage) {
                _ in loadImage()
                activeSheet = .editDetails
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
