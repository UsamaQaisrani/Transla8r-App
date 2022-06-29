//
//  MoyaServices.swift
//  Transl8or
//
//  Created by Usama on 14/04/2021.
//

import Foundation
import Moya

public enum MoyaServices {
    
    static private let API_KEY = "f129be17b7msh0c0586202f33793p1d8716jsn638e069942ee"
    
    case fetchLanguages
    case translate(text: String, source: String, target: String)
}

extension MoyaServices : TargetType {
    
    public var baseURL: URL {
        return URL(string: "https://google-translate1.p.rapidapi.com/language/translate/v2")!
    }
    
    public var path: String {
        switch self {
        case .fetchLanguages:
            return "/languages"
        case .translate(_, _, _):
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchLanguages:
            return .get
        case .translate(_, _, _):
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .fetchLanguages:
            return .requestPlain
        case let .translate(text, source, target):
            let params: [String: Any] = [
                "q": text,
                "source": source,
                "target": target
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        let baseHeader =   [
            "accept-encoding": "application/gzip",
            "x-rapidapi-key": "f129be17b7msh0c0586202f33793p1d8716jsn638e069942ee",
            "x-rapidapi-host": "google-translate1.p.rapidapi.com"
        ]
        switch self {
        case .fetchLanguages:
            return baseHeader
        case .translate(_, _, _):
            return baseHeader.merging(zip(["content-type"],["application/x-www-form-urlencoded"])) { (current, _) -> String in
                current
            }
        }
    }
}

