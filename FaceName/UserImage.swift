//
//  UserImage.swift
//  FaceName
//
//  Created by Landon Cayia on 9/3/22.
//

import Foundation
import SwiftUI

struct UserImage: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case id, name, image
    }
    
    let id: UUID
    var name: String
    let image: UIImage
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedUserImages")
    
    static let example = UserImage(id: UUID(), name: "Adorable Bunny", image: UIImage(systemName: "plus")!)
    
    // Standard initializer
    init(id: UUID, name: String, image: UIImage) {
        self.id = id
        self.name = name
        self.image = image
    }
    
    // Decodable conformance initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        let imageData = try container.decode(Data.self, forKey: .image)
        let decodedImage = UIImage(data: imageData) ?? UIImage()
        self.image = decodedImage
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: savePath, options: [.atomic, .completeFileProtection])
            try container.encode(jpegData, forKey: .image)
        }
    }
}
