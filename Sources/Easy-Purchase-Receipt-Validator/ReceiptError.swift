//
//  ErrorHandler.swift
//

import Foundation

enum ReceiptError: Error {
    case fileNotFound
    case invalidData
    case invalidURL
}

enum Detect {
    static func errorType(url: URL) -> ReceiptError {
        guard url != nil else {
            return .invalidURL
        }
        if !FileManager.default.fileExists(atPath: url.path) {
            return .fileNotFound
        } else {
            return .invalidData
        }
    }
}
