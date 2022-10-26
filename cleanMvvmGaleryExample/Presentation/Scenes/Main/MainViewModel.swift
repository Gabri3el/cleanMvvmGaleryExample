//
//  GaleryViewModel.swift
//  cleanMvvmGaleryExample
//
//  Created by Gabriel Merino Dos Santos - GMS on 25/10/22.
//

import UIKit
import Moya

protocol MainViewModelContract {
    func getPhotosList()
    var results: [Results] { get }
    
}
class MainViewModel: MainViewModelContract {
    private let service: ApiProtocol?
    private var randomRequest: Cancellable?
    var results: [Results] = []
    var image = UIImage()
    private(set) var error: ServiceErrorApi?

    init(service: ApiProtocol = ApiService()) {
        self.service = service
    }
    
    func getPhotosList() {
        service?.getPhotos(completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.results = response.results
                case .failure(let error):
                    self.errorGetPhotos(with: error)
                }
            }
        })
    }
    
    func errorGetPhotos(with error: ServiceErrorApi) {
        switch error {
        default:
            self.error = error
        }
    }
}
