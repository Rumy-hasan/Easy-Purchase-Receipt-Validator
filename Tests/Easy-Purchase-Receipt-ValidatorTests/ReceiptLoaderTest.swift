//
//  ReceiptLoaderTest.swift
//

import XCTest
@testable import Easy_Purchase_Receipt_Validator

final class ReceiptLoaderTest: XCTestCase {
    var receiptLoader: ReceiptLoader?
    override func setUp() {
        receiptLoader = ReceiptLoader()
    }
    override func tearDown() {
        receiptLoader = nil
    }
    func test_getReceipt_whenInvalidUrlGiven_shouldReturnInvalidURLError() {
        let url = URL(string: "")
        receiptLoader?.getReceipt(url) { data, error   in
            XCTAssertEqual(error, ReceiptError.invalidURL, "Error expected to be .invalidURL")
            XCTAssertNil(data, "Receipt data expected to be nil but found data")
        }
    }
    func test_getReceipt_whenIncorrectValidURLGiven_shouldReturnErrorAsFileNotFound() {
        let url = URL(string: "receipt/fileNotFountURL")
        receiptLoader?.getReceipt(url) { data, error in
            XCTAssertEqual(error, ReceiptError.fileNotFound, "Error expected to be .fileNotFound")
            XCTAssertNil(data, "Receipt data expected to be nil but found data")
        }
    }
}
