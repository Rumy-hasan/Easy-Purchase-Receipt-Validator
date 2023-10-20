//
//  ReceiptLoader.swift
//
//

import Foundation

class ReceiptLoader {
    public func getReceipt(_ url: URL? = Bundle.main.appStoreReceiptURL, _ completion: @escaping(_ success: Bool, _ data: Data?, _ error: ReceiptError?) -> Void) {
        guard let appReceiptURL = url else {
            completion(false, nil, .invalidURL)
            return
        }
        do {
            let receiptData = try Data(contentsOf: appReceiptURL)
            completion(true, receiptData, nil)
        } catch {
            completion(false, nil, Detect.errorType(url: appReceiptURL))
        }
    }
}
