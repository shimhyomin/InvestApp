//
//  TabBarController.swift
//  InvestApp
//
//  Created by shm on 2023/11/25.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.backgroundColor = .init(named: "AppColor")
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
    }
    
}
