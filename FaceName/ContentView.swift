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
    @StateObject private var viewModel = ViewModel()
    
    @State private var activeSheet: ActiveSheet?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.userImages.sorted(by: { $0.name < $1.name })) { userImage in
                    NavigationLink {
                        ImageFullView(userImage: userImage)
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
                    ImagePicker(image: $viewModel.inputImage)
                case .editDetails:
                    EditImageDetailsView(userImage: UserImage(id: UUID(), name: "", image: viewModel.inputImage ?? UIImage())) { newUserImage in
                        viewModel.addImage(newUserImage)
                    }
                }
            }
            .onChange(of: viewModel.inputImage) {
                _ in viewModel.loadImage()
                activeSheet = .editDetails
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
