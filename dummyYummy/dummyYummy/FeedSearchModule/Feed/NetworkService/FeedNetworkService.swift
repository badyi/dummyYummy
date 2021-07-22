//
//  File.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import Foundation

final class FeedNetworkService {
    let networkHelper = NetworkHelper(reachability: Reachability())
    var loadRandomRecipes: Cancellation?
    var imageLoadTaskContainer = [String: Cancellation]()
}

// MARK: - FeedServiceProtocol
extension FeedNetworkService: FeedServiceProtocol {
    func loadRandomRecipes(_ count: Int, completion: @escaping(OperationCompletion<RecipesResponse>) -> Void) {

        if loadRandomRecipes != nil {
            completion(.failure(ServiceError.alreadyLoading))
            return
        }

        guard let resource = FeedResourceFactory().createRandomRecipesResource(count) else {
            completion(.failure(ServiceError.resourceCreatingError))
            return
        }

        loadRandomRecipes = load(resource, completion: { [weak self] result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
            self?.loadRandomRecipes = nil
        })
    }

    func loadImage(with url: String, completion: @escaping(OperationCompletion<Data>) -> Void) {

        if imageLoadTaskContainer[url] != nil {
            completion(.failure(ServiceError.alreadyLoading))
            return
        }

        guard let resource = FeedResourceFactory().createImageResource(url) else {
            completion(.failure(ServiceError.resourceCreatingError))
            return
        }

        imageLoadTaskContainer[url] = load(resource, completion: { [weak self] result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
            self?.imageLoadTaskContainer[url] = nil
        })
    }

    func cancelImageLoad(with url: String) {
        imageLoadTaskContainer[url]?.cancel()
        imageLoadTaskContainer[url] = nil
    }

    func clearAndCancelAll() {
        loadRandomRecipes?.cancel()
        imageLoadTaskContainer.forEach {
            $0.value.cancel()
        }

        loadRandomRecipes = nil
        imageLoadTaskContainer.removeAll()
    }
}
