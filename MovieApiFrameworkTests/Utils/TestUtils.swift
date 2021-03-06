//
//  TestHelpers.swift
//  MovieApiFrameworkTests
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//

import Foundation

import Foundation
@discardableResult
func stub(_ url: URL, data: Data, statusCode: Int = 200, length: Int? = nil) -> LSStubResponseDSL {
    print("###url:\(url.absoluteString)")
    var stubResult = stubRequest("GET", url.absoluteString as NSString).andReturn(statusCode)?.withBody(data as NSData)
    if let length = length {
        stubResult = stubResult?.withHeader("Content-Length", "\(length)")
    }
    return stubResult!
}

//func delayedStub(_ url: URL, data: Data, statusCode: Int = 200, length: Int? = nil) -> LSStubResponseDSL {
//    let result = stub(url, data: data, statusCode: statusCode, length: length)
//    return result.delay()!
//}

func stub(_ url: URL, errorCode: Int) {
    let error = NSError(domain: "stubError", code: errorCode, userInfo: nil)
    stub(url, error: error)
}

func stub(_ url: URL, error: Error) {
    return stubRequest("GET", url.absoluteString as NSString).andFailWithError(error)
}
