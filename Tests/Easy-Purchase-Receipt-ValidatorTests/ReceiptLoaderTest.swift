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
    func testInvalidUrl() {
        let url = URL(string: "")
        receiptLoader?.getReceipt(url) { success, data, error in
            XCTAssertFalse(success, "Receipt fetching should fail")
            XCTAssertNil(data, "Receipt data should be nil")
            XCTAssertEqual(error, ReceiptError.invalidURL, "Error should be .invalidURL")
        }
    }
    func testFileNotFound() {
        let url = URL(string: "receipt/fileNotFountURL")
        receiptLoader?.getReceipt(url) { success, data, error in
            XCTAssertFalse(success, "Receipt fetching should fail")
            XCTAssertNil(data, "Receipt data should be nil")
            XCTAssertEqual(error, ReceiptError.fileNotFound, "Error should be .fileNotFound")
        }
    }
//    func testValidURLWithSuccess() {
//        receiptLoader?.getReceipt{ success, data, error in
//            XCTAssertTrue(success, "Receipt fetching should not fail")
//            XCTAssertNil(data, "Receipt data should not be nil")
//            XCTAssertEqual(error, ReceiptError.invalidURL, "Error should be .invalidURL")
//        }
//    }
}
