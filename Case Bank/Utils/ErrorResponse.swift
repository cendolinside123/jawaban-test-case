//
//  ErrorResponse.swift
//  Case Bank
//
//  Created by Jan Sebastian on 16/01/24.
//

import Foundation


extension String: Error, LocalizedError, CustomNSError {
    func customError() -> Error {
        return NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: self])
    }
}
