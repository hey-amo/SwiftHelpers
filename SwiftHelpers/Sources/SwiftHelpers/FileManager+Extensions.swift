//
//  FileManager+Extensions.swift
//  SwiftHelpers
//
//  Created by Amarjit on 20/10/2025.
//

import Foundation

extension FileManager {
    class func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    class func cacheDirectory() -> URL {
        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as [String]
        let firstPath = paths[0] as String
        return URL(fileURLWithPath: firstPath)
    }
}
