//
//  RootViewController.swift
//  StudySession
//
//  Created by Jeremy Jung on 11/16/19.
//  Copyright © 2019 Jeremy Jung. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewController = ViewController()
        
        
        viewController.tabBarItem = UITabBarItem(title: "Study Sessions", image: UIImage(named: "bookmark"), selectedImage: UIImage(named: "bookmark"))
        
        let inputViewController = InputViewController()
        
        inputViewController.tabBarItem = UITabBarItem(title: "New Session", image: UIImage(named: "plus-sign"), selectedImage: UIImage(named: "plus-sign"))
        
        let viewControllerList = [viewController, inputViewController]
        
        viewControllers = viewControllerList
        viewControllers = viewControllerList.map {
            UINavigationController(rootViewController: $0)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
