//
//  FileManager-DocumentsDirectory.swift
//  FaceName
//
//  Created by Landon Cayia on 9/6/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
