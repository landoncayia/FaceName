//
//  ContentView-ViewModel.swift
//  FaceName
//
//  Created by Landon Cayia on 9/6/22.
//

import Foundation
import SwiftUI

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var userImages: [UserImage]
        
        @Published var image: Image?
        @Published var inputImage: UIImage?
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedUserImages")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                let decodedData = try JSONDecoder().decode([UserImage].self, from: data)
                userImages = decodedData
            } catch {
                userImages = []
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
}
