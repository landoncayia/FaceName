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
    @State private var userImages: [UserImage]
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    @State private var activeSheet: ActiveSheet?
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedUserImages")
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userImages) { userImage in
                    NavigationLink {
                        Text("User image placeholder")
                    } label: {
                        HStack {
                            Image(uiImage: userImage.image)
                                .resizable()
                                .frame(maxWidth: 100, maxHeight: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Text(userImage.name)
                        }
                    }
                }
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
                    EditImageDetailsView(userImage: UserImage(id: UUID(), name: "", image: inputImage ?? UIImage())) { newUserImage in
                        addImage(newUserImage)
                    }
                }
            }
            .onChange(of: inputImage) {
                _ in loadImage()
                activeSheet = .editDetails
            }
        }
    }
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            let decodedData = try JSONDecoder().decode([UserImage].self, from: data)
            _userImages = State(initialValue: decodedData)
        } catch {
            _userImages = State(initialValue: [])
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(userImages)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save user image data.")
        }
    }
    
    func addImage(_ newUserImage: UserImage) {
        userImages.append(newUserImage)
        save()
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
