import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // 1. Создание экземпляров контроллеров
        let homeVC = HomeVC()
        let quizzesVC = QuizzesVC()
        let personalTrainingVC = PersonalTrainingVC()
        let trainingSkillsVC = TrainingSkillsVC()
        let profileVC = ProfileVC()
        
        // 2. Оборачивание каждого контроллера в UINavigationController
        // Это позволит каждому экрану иметь свою навигационную панель
        let homeNavController = UINavigationController(rootViewController: homeVC)
        let quizzesNavController = UINavigationController(rootViewController: quizzesVC)
        let personalTrainingNavController = UINavigationController(rootViewController: personalTrainingVC)
        let trainingSkillsNavController = UINavigationController(rootViewController: trainingSkillsVC)
        let profileNavController = UINavigationController(rootViewController: profileVC)
        
        // 3. Настройка Tab Bar Items (названия и иконки)
        // Иконки системы SF Symbols используются для примера
        
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
            trainingSkillsNavController,
            personalTrainingNavController,
            quizzesNavController,
            profileNavController
        ]
        
        // 5. Установка Tab Bar Controller как корневого контроллера окна
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }
}
