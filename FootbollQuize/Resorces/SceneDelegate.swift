import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        
        let splashVC = SplashVC()
        
        splashVC.actionOnDismiss = { [weak self] in
            guard let self = self else { return }
            
            UIView.transition(with: self.window!,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                self.window?.rootViewController = self.createMainTabBar()
            }, completion: nil)
        }
        
        self.window?.rootViewController = splashVC
        self.window?.overrideUserInterfaceStyle = .light
        self.window?.makeKeyAndVisible()
    }
    
    private func createMainTabBar() -> UITabBarController {
        
        let homeVC = HomeVC()
        let personalTrainingVC = PersonalTrainingVC()
        let progressVC = ProgressVC()
        
        let homeNavController = UINavigationController(rootViewController: homeVC)
        let personalTrainingNavController = UINavigationController(rootViewController: personalTrainingVC)
        let progressNavController = UINavigationController(rootViewController: progressVC)

        homeVC.title = "Home"
        homeNavController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "homeTab")?.withRenderingMode(.alwaysTemplate), tag: 0)

        personalTrainingVC.title = "Training"
        personalTrainingNavController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "historyTab")?.withRenderingMode(.alwaysTemplate), tag: 1)
        
        progressVC.title = "Progress"
        progressNavController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "profileTab")?.withRenderingMode(.alwaysTemplate), tag: 2)
        
        // 4. Создание UITabBarController
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            homeNavController,
            personalTrainingNavController,
            progressNavController
        ]
        
        let activeColor = UIColor.activeColor
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .primary
        appearance.stackedLayoutAppearance.selected.iconColor = activeColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: activeColor]
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance
        tabBarController.tabBar.tintColor = activeColor

        return tabBarController
    }
}
