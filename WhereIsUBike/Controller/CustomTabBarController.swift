//
//  CustomTabBarController.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/10/16.
//  Copyright © 2018 t19960804. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.unselectedItemTintColor = UIColor(red: 202/255, green: 202/255, blue: 202/255, alpha: 1)
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
