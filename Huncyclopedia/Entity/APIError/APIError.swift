//
//  APIError.swift
//  CoreApp
//
//  Created by hsncr on 13.05.2021.
//

import Foundation

public enum APIError: Error {
    case unknown
    case generic(_ description: String)
    case invalidJSON
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case serverError
    case error4xx(Int)
    case error5xx(Int)
    
}

extension APIError: Equatable {
    
    public static func ==(lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.unknown, .unknown):
            return true
        case (.generic, .generic):
            return true
        case (.invalidJSON, .invalidJSON):
            return true
        case (.badRequest, .badRequest):
            return true
        case (.unauthorized, .unauthorized):
            return true
        case (.forbidden, .forbidden):
            return true
        case (.notFound, .notFound):
            return true
        case (.serverError, .serverError):
            return true
        case (.error4xx(let lhsCode), .error4xx(let rhsCode)):
            return lhsCode == rhsCode
        case (.error5xx(let lhsCode), .error5xx(let rhsCode)):
            return lhsCode == rhsCode
        default:
            return false
        }
        
    }
}

extension APIError {
    
    public static func statusError(_ statusCode: Int) -> APIError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(statusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(statusCode)
        default: return .unknown
        }
    }
}
