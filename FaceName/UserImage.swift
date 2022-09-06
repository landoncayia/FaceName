//
//  UserImage.swift
//  FaceName
//
//  Created by Landon Cayia on 9/3/22.
//

import Foundation
import SwiftUI

struct UserImage: Identifiable {
    let id: UUID
    var name: String
    let photo: UIImage
    
    static let example = UserImage(id: UUID(), name: "Adorable Bunny", photo: UIImage(systemName: "plus")!)
}
