//
//  DetailNetworkService.swift
//  dummyYummy
//
//  Created by badyi on 06.07.2021.
//

import UIKit

final class DetailNetworkService {
    let networkHelper = NetworkHelper(reachability: FakeReachability())
    var imageLoadRequest: Cancellation?
    var infoLoadRequest: Cancellation?
}

extension DetailNetworkService: DetailNetworkServiceProtocol {
    func loadRecipeInfo(_ id: Int, completion: @escaping(OperationCompletion<FeedRecipeInfoResponse>) -> Void) {
        if infoLoadRequest != nil {
            #warning("completion")
            print("already loading")
            return
        }

        guard let resource = DetailResourceFactory().createRecipesInfoResource(id) else {
            let error = NSError(domain: "Recipe info resource create error", code: 0, userInfo: nil)
            completion(.failure(error))
            return
        }

        infoLoadRequest = load(resource: resource, completion: { [weak self] result in
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
            #warning("completion")
            return
        }
        guard let resource = DetailResourceFactory().createImageResource(url) else {
            let error = NSError(domain: "Image resource create error", code: 0, userInfo: nil)
            completion(.failure(error))
            return
        }
        imageLoadRequest = load(resource: resource, completion: { [weak self] result in
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

private extension DetailNetworkService {
    func load<T>(resource: Resource<T>, completion: @escaping(OperationCompletion<T>) -> Void) -> Cancellation? {
        let request = networkHelper.load(resource: resource, completion: { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        })
        return request
    }
}
