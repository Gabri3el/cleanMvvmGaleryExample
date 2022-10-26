//
//  Env.swift
//  cleanMvvmGaleryExample
//
//  Created by Gabriel Merino Dos Santos - GMS on 25/10/22.
//

import Foundation

public struct Env {
    public static let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=50&query=ocean&client_id=uGJfSy849imZttulqxuAs4uyOOX0Aw5cCo-fl0rnjoY"
    public static let baseURL = URL(string: urlString)
    // Exemple of flag to do certificate pinning
    public static let defaultHeader = ["Content-type": "application/json"]

}
