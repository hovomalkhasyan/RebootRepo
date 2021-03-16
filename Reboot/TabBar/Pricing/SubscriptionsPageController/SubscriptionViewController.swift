//
//  SubscriptionViewController.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 16.03.21.
//

import UIKit

class SubscriptionViewController: BaseViewController {

    @IBOutlet weak var planBtn: PageControlButton!
    @IBOutlet weak var subBtn: PageControlButton!
    @IBOutlet weak var containerView: UIView!
    private var pageViewController: UIPageViewController!
    private var controllers: [UIViewController] = []
    private lazy var pageControllers: [UIViewController] = {
        [SubscriptionsViewController.initializeStoryboard(), PlanTrainingViewController.initializeStoryboard()]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        controllers = pageControllers
        setupBtn()
        setupGest()
        setupInfoBtn()
        setupDarkMode()
        setbarView()
        workoutsCount()
        setupPageViewController()
        changeController(to: controllers.first!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideNavBar()
    }
    
}

extension SubscriptionViewController {
    private func setupBtn() {

        subBtn.addTarget(self, action: #selector(buttonsSelection(sender:)), for: .touchUpInside)
        subBtn.isSelected = true
        planBtn.addTarget(self, action: #selector(buttonsSelection(sender:)), for: .touchUpInside)
    }
}

extension SubscriptionViewController {
    @objc func buttonsSelection(sender: UIButton) {
        selectButton(by: sender.tag)
    }
}

private extension SubscriptionViewController {
    func selectButton(by index: Int) {
        planBtn.isSelected = index == planBtn.tag
        subBtn.isSelected = index == subBtn.tag
        changeController(to: controllers[index])
    }
    

    private func changeController(to controller: UIViewController) {
        self.pageViewController.setViewControllers([controller], direction: .forward, animated: false, completion: nil)
    }
    
    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        pageViewController.delegate = self
        pageViewController.dataSource = self

        addChild(pageViewController)
        guard let controllerView = pageViewController.view else { return }
        containerView.addSubview(controllerView)
        controllerView.frame = containerView.bounds


        pageViewController.didMove(toParent: self)
    }
}

// MARK: - UIPageController methods
extension SubscriptionViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = controllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return controllers.last
        }
        
        guard controllers.count > previousIndex else {
            return nil
        }
        
        return controllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = controllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard controllers.count != nextIndex else {
            return controllers.first
        }
        
        guard controllers.count > nextIndex else {
            return nil
        }
        
        return controllers[nextIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let currentViewController = pageViewController.viewControllers?.first,
               let index = controllers.firstIndex(of: currentViewController) {
                planBtn.isSelected = index == planBtn.tag
                subBtn.isSelected = index == subBtn.tag
            }
        }
    }
}

