//
//  AppDelegate.swift
//  HashCode2018
//
//  Created by Alexandru Culeva on 3/1/18.
//  Copyright © 2018 Ellation. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        var sum = 0
        for file in ["a_example", "b_should_be_easy", "c_no_hurry", "d_metropolis", "e_high_bonus"] {
            let city = Parser().parse(file)
            city.simulate()
            sum += city.vehicles.reduce(0) { $0 + $1.profit }
        }

        print(sum)

        return true
    }
}

