//
//  DetailNetworkService.swift
//  dummyYummy
//
//  Created by badyi on 06.07.2021.
//

import UIKit

final class DetailNetworkService {
    let networkHelper = NetworkHelper(reachability: Reachability())
    var imageLoadRequest: Cancellation?
    var infoLoadRequest: Cancellation?
}

extension DetailNetworkService: DetailNetworkServiceProtocol {
    func loadRecipeInfo(_ id: Int, completion: @escaping(OperationCompletion<RecipeInfoResponse>) -> Void) {
        if infoLoadRequest != nil {
            return
        }

        guard let resource = DetailResourceFactory().createRecipesInfoResource(id) else {
            completion(.failure(ServiceError.resourceCreatingError))
            return
        }

        infoLoadRequest = load(resource, completion: { [weak self] result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
            self?.infoLoadRequest = nil
        })
    }

    func loadImage(_ url: String, completion: @escaping (OperationCompletion<Data>) -> Void) {
        if imageLoadRequest != nil {
            return
        }

        guard let resource = DetailResourceFactory().createImageResource(url) else {
            completion(.failure(ServiceError.resourceCreatingError))
            return
        }

        imageLoadRequest = load(resource, completion: { [weak self] result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
            self?.imageLoadRequest = nil
        })
    }
}
