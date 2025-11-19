import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        
        // 1. Создаем Splash Controller
        let splashVC = SplashVC()
        
        // 2. Настраиваем кложур, который будет вызван после задержки
        splashVC.actionOnDismiss = { [weak self] in
            guard let self = self else { return }
            
            // Плавная смена корневого контроллера
            UIView.transition(with: self.window!,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                self.window?.rootViewController = self.createMainTabBar()
            }, completion: nil)
        }
        
        // 3. Устанавливаем SplashVC как корневой контроллер окна
        self.window?.rootViewController = splashVC
        self.window?.overrideUserInterfaceStyle = .light
        self.window?.makeKeyAndVisible()
    }
    
    // Приватный метод для создания основного Tab Bar Controller
    private func createMainTabBar() -> UITabBarController {
        
        // 1. Создание экземпляров контроллеров
        let homeVC = HomeVC()
        let personalTrainingVC = PersonalTrainingVC()
        let progressVC = ProgressVC()
        
        // 2. Оборачивание каждого контроллера в UINavigationController
        let homeNavController = UINavigationController(rootViewController: homeVC)
        let personalTrainingNavController = UINavigationController(rootViewController: personalTrainingVC)
        let progressNavController = UINavigationController(rootViewController: progressVC)

        // 3. Настройка Tab Bar Items (названия и иконки)
        // Важно: Иконки должны быть загружены как .alwaysTemplate, чтобы tintColor работал
                
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
        
        // -----------------------------------------------------------------
        //  ✅ ИСПРАВЛЕННАЯ НАСТРОЙКА ЦВЕТОВ и ФОНА (через Appearance)
        // -----------------------------------------------------------------
        
        let activeColor = UIColor.activeColor // Цвет для активного таба
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
