//
//  TabManViewController.swift
//  InvestApp
//
//  Created by shm on 2023/11/25.
//

import UIKit
import Tabman
import Pageboy
import SwiftUI

class TradingTMViewController: TabmanViewController {
    //@IBOutlet weak var tabView: UIView!
    
    private var viewControllers: [UIViewController] = []
    private var titles: [String] = ["매매", "정정/취소"]
    let firstVC = UIHostingController(rootView: OrderCashTabView())
    let secondVC = UIHostingController(rootView: RvsecnclTabView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "매매"
        
        viewControllers.append(firstVC)
        viewControllers.append(secondVC)
        
        
        self.dataSource = self
        
        // Create bar
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.indicator.tintColor = .init(named: "AppColor")
        bar.indicator.transitionStyle = .snap
        bar.buttons.customize { button in
            button.tintColor = .lightGray
            button.selectedTintColor = .init(named: "AppColor")
        }
        // Add to view
        addBar(bar, dataSource: self, at: .top)
    }
}

//MARK: - PageViewControllerDataSource, TMBarDataSource
extension TradingTMViewController: PageboyViewControllerDataSource, TMBarDataSource {

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = titles[index]
        return TMBarItem(title: title)
    }
}
