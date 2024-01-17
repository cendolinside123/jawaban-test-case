//
//  AppDelegate.swift
//  Case Bank
//
//  Created by Jan Sebastian on 15/01/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    private var userInfoViewModel: DummyUserInfoVm<UserInfoModel>?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        setupUseCase()
        setupController()
        
        self.window?.rootViewController = SplashScreenViewController()
        self.window?.makeKeyAndVisible()
        
        userInfoViewModel?.createUser(nama: "Jan Sebastian", saldo: 500000)
        
        
        return true
    }
    
    private func setupController() {
        userInfoViewModel = UserInfoViewModelImpl()
        userInfoViewModel?.onSuccessInput = { [weak self] in
            self?.toHomePage()
        }
    }
    
    private func toHomePage() {
        let nav = UINavigationController(rootViewController: HomeViewController())
        nav.isNavigationBarHidden = true
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
    }
    
    private func setupUseCase() {
        ServiceContainer.register(type: UserInfoDataSource.self, UserInfoDataSourceImpl())
        ServiceContainer.register(type: TransactionDataSource.self, TransactionDataSourceImpl())
        ServiceContainer.register(type: PromoDataSource.self, PromoDataSourceImpl())
        ServiceContainer.register(type: PortoDataSource.self, PortoDataSourceImpl())
    }


}

