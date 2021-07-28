//
//  GuideViewController.swift
//  dummyYummy
//
//  Created by badyi on 28.07.2021.
//

import UIKit

final class GuidePageViewController: UIPageViewController {

    var presenter: GuidePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        presenter?.start()
    }
}

// MARK: - DataSource
extension GuidePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? GuideViewController else { return nil }
        if let index = presenter?.pages.firstIndex(of: viewController) {
            if index > 0 {
                return presenter?.pages[index - 1]
            }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? GuideViewController else { return nil }
        guard let presenter = presenter else { return nil }
        if let index = presenter.pages.firstIndex(of: viewController) {
            if index < presenter.pages.count - 1 {
                return presenter.pages[index + 1]
            }
        }
        return nil
    }
}

// MARK: - Delegate
extension GuidePageViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        presenter?.pages.count ?? 0
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if completed {
            guard let viewController = pageViewController.viewControllers?.first as? GuideViewController else { return }
            guard let index = presenter?.pages.firstIndex(of: viewController) else { return }
            guard let count = presenter?.pages.count else { return }
            if index == count - 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [weak self] in
                    self?.presenter?.finished()
                })
            }
        }
    }
}

// MARK: - GuidePageViewProtocol
extension GuidePageViewController: GuidePageViewProtocol {
    func update(with pages: [GuideViewController]) {
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
    }
}
