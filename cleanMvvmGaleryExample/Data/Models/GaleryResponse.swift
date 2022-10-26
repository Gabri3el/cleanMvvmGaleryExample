//
//  GaleryResponse.swift
//  cleanMvvmGaleryExample
//
//  Created by Gabriel Merino Dos Santos - GMS on 25/10/22.
//

import Foundation

struct GaleryResponse: Codable {
    let total: Int
    let total_pages: Int
    let results: [Results]
}

struct Results: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let regular: String
}
