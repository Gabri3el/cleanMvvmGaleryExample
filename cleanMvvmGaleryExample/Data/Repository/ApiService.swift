//
//  ApiService.swift
//  cleanMvvmGaleryExample
//
//  Created by Gabriel Merino Dos Santos - GMS on 25/10/22.
//

import Moya

protocol ApiProtocol {
    func getPhotos(completion: @escaping (Result<GaleryResponse, ServiceErrorApi>) -> Void)
}

class ApiService: ApiProtocol {
    let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
    let provider: MoyaProvider<GaleryApi>
    let authPlugin: PluginType = AccessTokenPlugin { _ in
        let defaults = UserDefaults.standard
        var token = ""
        guard let tk = defaults.string(forKey: "") else { return token }
        token = tk
            return token
    }
    
    init() {
        self.provider = MoyaProvider<GaleryApi>(plugins: [authPlugin, plugin])
    }
    
    func getPhotos(completion: @escaping (Result<GaleryResponse, ServiceErrorApi>) -> Void) {
        request(target: .getPhotos, completion: completion)
    }
}

extension ApiService {
    func request<T: Decodable>(target: GaleryApi, completion: @escaping (Result<T, ServiceErrorApi>) -> Void) {
        provider.request(target) { result in
            switch result {
            case let .success(moyaResponse):
                guard var _ = try? moyaResponse.filterSuccessfulStatusAndRedirectCodes() else {
                    print(moyaResponse.statusCode)
                    switch moyaResponse.statusCode {
                    case 400:
                        completion(.failure(ServiceErrorApi.validationFailed))
                    case 401:
                        completion(.failure(ServiceErrorApi.unauthorized))
                    default:
                        completion(.failure(ServiceErrorApi.unexpected))
                    }
                    return
                }
                guard let results = try? moyaResponse.map(T.self) else {
                    completion(.failure(.decodingError)) //JSON parsing error
                    return
                }
                completion(.success(results))
            case .failure:
                completion(.failure(ServiceErrorApi.noConnection))
            }
        }
    }
}
