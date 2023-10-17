//
//  IAPHelper.swift
//  Demo
//
//  Created by BJIT on 17/10/23.
//

import Foundation
import StoreKit

class IAPHelper: NSObject {
    static let shared = IAPHelper()
    var availableProducts = [SKProduct]()
    var invalidProductIdentifiers = [String]()
    /// Keeps track of all purchases.
    var purchased = [SKPaymentTransaction]()
    /// Keeps track of all restored purchases.
    var restored = [SKPaymentTransaction]()
    /// Indicates whether there are restorable purchases.
    var hasRestorablePurchases = false
    var purchasingCount = 0
    var deferredCount = 0
    var purchasedCount = 0
    var failedCount = 0
    var restoredCount = 0
    var removedProductIdentifiers = [String]()
    var restoreFailedCount = 0
    func fetchProductsData(type products: [String]) {
        let request = SKProductsRequest(productIdentifiers: Set(products))
        request.delegate = self
        request.start()
    }
}

// MARK: - SKProductsRequestDelegate, SKRequestDelegate
extension IAPHelper: SKProductsRequestDelegate, SKRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        // products contains products whose identifiers have been recognized by the App Store. As such, they can be purchased.
        if !response.products.isEmpty {
            availableProducts = response.products
            FetchProductsListVC.viewModel.fetchedProducts = response.products
        }
        if !response.invalidProductIdentifiers.isEmpty {
            invalidProductIdentifiers = response.invalidProductIdentifiers
        }
    }
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print(error.localizedDescription)
        FetchProductsListVC.viewModel.fetchedProducts = []
    }
}
