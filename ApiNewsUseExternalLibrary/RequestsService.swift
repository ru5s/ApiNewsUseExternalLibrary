//
//  RequestsService.swift
//  ApiNewsUseExternalLibrary
//
//  Created by Ruslan Ismailov on 21/11/22.
//

import Foundation
import Moya

private let apikey = "ea9f3fd5e5ef4620b6797fdd0cc4d3ed"

enum NewsEnum {
    enum bitcoin: TargetType {
        
        case bitcoinUrl
        
        var baseURL: URL {
            guard let url = URL(string: "https://newsapi.org/v2") else { fatalError() }
            return url
            
        }
        
        var path: String {
            switch self {
            case .bitcoinUrl:
                return "/everything"
            }
        }
        
        var method: Moya.Method {
            return .get
        }
        
        var sampleData: Data {
                return Data()
        }
        
        var task: Moya.Task {
            switch self {
            case .bitcoinUrl:
                return .requestParameters(parameters: ["q":"bitcoin","apiKey": apikey], encoding: URLEncoding.queryString)
            }
        }
        
        var headers: [String : String]? {
            return nil
        }
        
        
    }
}
