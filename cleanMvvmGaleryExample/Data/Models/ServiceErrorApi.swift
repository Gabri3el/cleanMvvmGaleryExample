//
//  ServiceErrorApi.swift
//  cleanMvvmGaleryExample
//
//  Created by Gabriel Merino Dos Santos - GMS on 25/10/22.
//

import Foundation

enum ServiceErrorApi: Error {
    case decodingError
    case validationFailed
    case unauthorized
    case noConnection
    case unexpected
}
