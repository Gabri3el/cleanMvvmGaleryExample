//
//  ApiRouter.swift
//  cleanMvvmGaleryExample
//
//  Created by Gabriel Merino Dos Santos - GMS on 25/10/22.
//

import Moya

enum GaleryApi {
    case getPhotos
}

extension GaleryApi: TargetType {
    var baseURL: URL {
        return Env.baseURL!
    }
    
    var path: String {
        switch self {
        case .getPhotos:
            return GeneralStrings.emptyString
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPhotos:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getPhotos:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return Env.defaultHeader
    }
    
    
}
