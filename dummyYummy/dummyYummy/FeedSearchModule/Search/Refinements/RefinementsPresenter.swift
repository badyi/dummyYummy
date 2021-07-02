//
//  RefinementsPresenter.swift
//  dummyYummy
//
//  Created by badyi on 02.07.2021.
//

import UIKit

final class RefinementsPresenter: NSObject {
    
    let refinementsSections: [RefinementsSection : [RefinementsRows]] = [.time : [.time], .cuisine : [.cuisine, .excludesCuisine], .diet : [.diet], .intolearns : [.intolearns]]
    
    let refinementsOrder: [RefinementsSection] = [.time, .cuisine, .diet, .intolearns]
    var refinements: SearchRefinements
    weak var view: RefinementsViewProtocol?
    
    init(with refinements: SearchRefinements) {
        self.refinements = refinements
    }
}

extension RefinementsPresenter: RefinementsPresenterProtocol {
    func viewDidLoad() {
        view?.setupView()
    }
    
    func viewWillAppear() {
        view?.configNavigation()
    }
    
    func viewWillDisappear() {
        view?.willFinish?(refinements)
    }
    
    func willDisplayCell(at index: IndexPath) {
        
    }
    
    func didEndDisplayCell(at index: IndexPath) {
        
    }
}

// MARK: - UITableViewDataSource
extension RefinementsPresenter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return refinementsSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        refinementsSections[refinementsOrder[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RefinementInputCell.id, for: indexPath) as! RefinementInputCell
        cell.setIndexPath(indexPath)
        cell.inputDelegate = self
        cell.deleteTapped = { [weak self] indexPath in
            self?.deleteAt(indexPath)
        }
        
        switch refinementsOrder[indexPath.section] {
        case .time:
            configCellForTime(cell)
        case .cuisine where indexPath.row == 0:
            configCellForCuisine(cell)
        case .cuisine where indexPath.row == 1:
            configCellForExcludedCuisine(cell)
        case .diet:
            configCellForDiet(cell)
        case .intolearns:
            configCellForIntolearns(cell)
        default:
            return cell
        }
        
        return cell
    }
    
    func configCellForTime(_ cell: RefinementInputCell) {
        cell.isUsingKeyBoard = true
        var isActive = false
        var text = "Max ready minutes: "
        if let time = refinements.maxReadyTime {
            isActive = true
            text += "\(time)"
        }
        cell.configCell(with: text, isActive)
    }
    
    func configCellForCuisine(_ cell: RefinementInputCell) {
        var isActive = false
        if refinements.cuisine != nil {
            isActive = true
        }
        cell.configCell(with: "Cuisine", isActive)
    }
    
    func configCellForExcludedCuisine(_ cell: RefinementInputCell) {
        var isActive = false
        if refinements.excludedCuisine != nil {
            isActive = true
        }
        cell.configCell(with: "Excluded cuisine", isActive)
    }
    
    func configCellForDiet(_ cell: RefinementInputCell) {
        var isActive = false
        if refinements.diet != nil {
            isActive = true
        }
        cell.configCell(with: "Diet", isActive)
    }
    
    func configCellForIntolearns(_ cell: RefinementInputCell) {
        var isActive = false
        if refinements.intolerances != nil {
            isActive = true
        }
        cell.configCell(with: "intolearns", isActive)
    }
    
    func deleteAt(_ indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        
        switch refinementsOrder[indexPath.section] {
        case .time:
            refinements.maxReadyTime = nil
        case .cuisine where indexPath.row == 0:
            refinements.cuisine = nil
        case .cuisine where indexPath.row == 1:
            refinements.excludedCuisine = nil
        case .diet:
            refinements.diet = nil
        case .intolearns:
            refinements.intolerances = nil
        default:
            print("deafult")
        }
    }
    
    func didSelectAt(_ indexPath: IndexPath) {
        switch refinementsOrder[indexPath.section] {
        case .time:
            print("time")
        case .cuisine where indexPath.row == 0:
            print("cuisine")
        case .cuisine where indexPath.row == 1:
            print("excluededCuisine")
        case .diet:
            print("diet")
        case .intolearns:
            print("intolearns")
        default:
            print("deafult")
        }
    }
}

extension RefinementsPresenter: InputCellDelegate {
    func doneButtonTapped() {
        view?.endEditing(true)
    }
    
    func insertText(_ text: String, didFinishUpdate: ((Int) -> ())?) {
        var entry: Int = 0
        if let time = refinements.maxReadyTime {
            entry = time
        } else {
            refinements.maxReadyTime = 0
        }
        if let number = Int(text), number < 10 {
            let newEntry = entry * 10 + number
            guard newEntry < 1000, newEntry > 0 else { return }
            entry = newEntry
            refinements.maxReadyTime = entry
            didFinishUpdate?(entry)
        }
    }
    
    func deleteBackwards(didFinishUpdate: ((Int) -> ())?) {
        var entry: Int = 0
        if let time = refinements.maxReadyTime {
            entry = time
        } else {
            refinements.maxReadyTime = 0
        }
        entry /= 10
        refinements.maxReadyTime = entry
        didFinishUpdate?(entry)
    }
}
