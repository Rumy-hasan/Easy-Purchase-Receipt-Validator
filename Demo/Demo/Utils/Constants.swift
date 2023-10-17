//
//  Constants.swift
//  Demo
//
//  Created by BJIT on 17/10/23.
//

import Foundation
import StoreKit

class Constants {
    static let purchasableProducts = ["", ""]
    static var availableProductsCollection: [String: SKProduct] = [:]
}

enum ProductType {
    case consumable
    case nonConsumable
    case nonRenewableSubscription
    case autoRenewableSubscription
}
