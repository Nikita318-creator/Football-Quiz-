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
    
    private func createMainTabBar() -> UIViewController {
        
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
        
        let tabBarController = CustomTabContainer()
        
        tabBarController.viewControllers = [
            homeNavController,
            personalTrainingNavController,
            progressNavController
        ]
                
        return tabBarController
    }
}
