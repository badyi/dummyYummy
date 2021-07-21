//
//  SearchNetworkService.swift
//  dummyYummy
//
//  Created by badyi on 20.07.2021.
//

import Foundation

final class SearchIngredientsNetworkService {
    let networkHelper = NetworkHelper(reachability: FakeReachability())
    var taskItem: TaskItem?
}

extension SearchIngredientsNetworkService: SearchIngredientsNetworkProtocol {
    func loadIngredients(_ count: Int,
                         _ query: String,
                         completion: @escaping(OperationCompletion<IngredientsResponse>) -> Void) {

        if taskItem?.query == query, taskItem?.task != nil {
            return
        }

        guard let resource = SearchIngredientsResourceFactory().createIngredientsResource(count, query) else {
            completion(.failure(ServiceError.resourceCreatingError))
            return
        }

        taskItem = TaskItem()
        taskItem?.query = query

        taskItem?.task = load(resource, completion: { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}

extension SearchIngredientsNetworkService {
    struct TaskItem {
        var query: String?
        var task: Cancellation?
    }
}
