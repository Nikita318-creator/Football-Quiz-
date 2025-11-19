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
        
        let activeColor = UIColor.red // Цвет для активного таба
        let inactiveColor = UIColor.green // Ваш цвет для неактивного таба
        
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
        
        let appearance = UITabBarAppearance()
        
        // 1. Установка ФОНОВОГО ЦВЕТА Tab Bar
        appearance.backgroundColor = .primary // <-- Фон таббара теперь PRIMARY
        
        // 2. Настройка активного (выбранного) таба: .red
        appearance.stackedLayoutAppearance.selected.iconColor = activeColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: activeColor]
        
        // 3. Настройка неактивного (нормального) таба: secondTextColor
        appearance.stackedLayoutAppearance.normal.iconColor = inactiveColor // <-- Исправленный цвет неактивного таба
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: inactiveColor]
        
        // 4. Применение настроек к Tab Bar
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance
        
        // Для старых iOS (до iOS 13), где Appearance может не работать полностью,
        // сохраним настройки tintColor (хотя Appearance имеет приоритет)
        tabBarController.tabBar.tintColor = activeColor
        // Note: unselectedItemTintColor не работает надежно с Appearance,
        // поэтому мы полагаемся на appearance.stackedLayoutAppearance.normal.iconColor

        return tabBarController
    }
}
