//
//  SearchNetworkService.swift
//  dummyYummy
//
//  Created by badyi on 20.07.2021.
//

import Foundation

final class SearchIngredientsNetworkService {
    let networkHelper = NetworkHelper(reachability: Reachability())
    var taskItem: TaskItem?
}

extension SearchIngredientsNetworkService: SearchIngredientsNetworkProtocol {
    func loadIngredients(_ count: Int,
                         _ query: String,
                         completion: @escaping(OperationCompletion<IngredientsResponse>) -> Void) {

        if taskItem?.query == query, taskItem?.task != nil {
            completion(.failure(ServiceError.alreadyLoading))
            return
        }
        cancelSearchTask()

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

    func cancelSearchTask() {
        taskItem?.task?.cancel()
        taskItem = nil
    }
}

extension SearchIngredientsNetworkService {
    struct TaskItem {
        var query: String?
        var task: CancellationProtocol?
    }
}
