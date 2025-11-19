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
        let quizzesVC = QuizzesVC()
        let personalTrainingVC = PersonalTrainingVC()
        let trainingSkillsVC = TrainingSkillsVC()
        let profileVC = ProfileVC()
        
        // 2. Оборачивание каждого контроллера в UINavigationController
        let homeNavController = UINavigationController(rootViewController: homeVC)
        let quizzesNavController = UINavigationController(rootViewController: quizzesVC)
        let personalTrainingNavController = UINavigationController(rootViewController: personalTrainingVC)
        let trainingSkillsNavController = UINavigationController(rootViewController: trainingSkillsVC)
        let profileNavController = UINavigationController(rootViewController: profileVC)
        
        // 3. Настройка Tab Bar Items (названия и иконки)
        
        // HomeVC (Home)
        homeVC.title = "Home"
        homeNavController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        // QuizzesVC (Quizzes)
        quizzesVC.title = "Quizzes"
        quizzesNavController.tabBarItem = UITabBarItem(title: "Quizzes", image: UIImage(systemName: "q.circle"), tag: 1)
        
        // PersonalTrainingVC (Personal Training)
        personalTrainingVC.title = "Personal Training"
        personalTrainingNavController.tabBarItem = UITabBarItem(title: "Training", image: UIImage(systemName: "figure.walk"), tag: 2)
        
        // TrainingSkillsVC (Training Skills)
        trainingSkillsVC.title = "Skills"
        trainingSkillsNavController.tabBarItem = UITabBarItem(title: "Skills", image: UIImage(systemName: "flame"), tag: 3)
        
        // ProfileVC (Profile)
        profileVC.title = "Profile"
        profileNavController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 4)
        
        // 4. Создание UITabBarController
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            homeNavController,
            personalTrainingNavController,
            trainingSkillsNavController,
            quizzesNavController,
            profileNavController
        ]
        
        return tabBarController
    }
}
