//
//  File.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import UIKit

enum CancelType {
    case imageLoad
}

final class Cancel {
    var imageLoad: Cancellation?
}

final class FeedNetworkService {
    let networkHelper = NetworkHelper(reachability: FakeReachability())
    
    var requestContainer = [IndexPath: Cancel]()
}

// MARK: - FeedServiceProtocol
extension FeedNetworkService: FeedServiceProtocol {
    func loadRandomRecipes(_ count: Int, completion: @escaping(OperationCompletion<FeedRecipeResponse>) -> ()) {
        guard let resource = FeedResourceFactory().createRandomRecipesResource(count) else {
            let error = NSError(domain: "Random recipe resource create error", code: 0, userInfo: nil)
            completion(.failure(error))
            return
        }
        
        _ = load(resource: resource, completion: { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func loadImage(at index: IndexPath, with url: String, completion: @escaping(OperationCompletion<Data>) -> ()) {
        guard let resource = FeedResourceFactory().createImageResource(url) else {
            let error = NSError(domain: "Image resource create error", code: 0, userInfo: nil)
            completion(.failure(error))
            return
        }
        
        if requestContainer[index] == nil {
            requestContainer[index] = Cancel()
        }
        
        #warning("mb add comletion to return")
        if requestContainer[index]?.imageLoad != nil { return }
        
        requestContainer[index]?.imageLoad = load(at: index, type: .imageLoad, resource: resource, completion: { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func cancelRequest(at index: IndexPath) {
        requestContainer[index]?.imageLoad?.cancel()
        
        requestContainer[index]?.imageLoad = nil
    }
}

// MARK: - Private methods
private extension FeedNetworkService {
    func removeRequest(at index: IndexPath, type: CancelType) {
        switch type {
        case .imageLoad:
            requestContainer[index]?.imageLoad = nil
        }
    }
    
    func load<T>(at index: IndexPath? = nil, type: CancelType? = nil, resource: Resource<T>, completion: @escaping(OperationCompletion<T>) -> ()) -> Cancellation? {
        let cancel = networkHelper.load(resource: resource, completion: { [weak self] result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
            if let type = type, let index = index {
                self?.removeRequest(at: index, type: type)
            }
        })
        return cancel
    }
}
