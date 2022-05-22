//
//  SplashViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 21.01.22.
//

import UIKit

class SplashViewController: UIViewController {
    
    let storageManager = StorageManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        determineInitialView()
    }
    
    func determineInitialView() {
        showSplashLoader()
        if storageManager.isUserLoggedIn() {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                self.hideLoader()
                self.goToRegisterVC()
            }
        } else {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                self.hideLoader()
                self.goToRegisterVC()
            }
        }
    }
    
    private func goToRegisterVC() {
        let regiserVC = UIStoryboard(name: "Register", bundle: .main).instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        let nav = UINavigationController(rootViewController: regiserVC)
        nav.setAsRoot()
    }
    
    private func goToMainVC() {
        let tabBarVC = UIStoryboard(name: "TabBarViewController", bundle: .main).instantiateViewController(withIdentifier: "CustomTabBarViewController")
        let nav = UINavigationController(rootViewController: tabBarVC)
        nav.setAsRoot()
    }
}
