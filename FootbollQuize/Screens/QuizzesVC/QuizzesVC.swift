import UIKit
import SnapKit

class QuizzesVC: UIViewController {

    // MARK: - Properties
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let playerStats = PlayerStats(experiencePoints: 1250, currentRank: "Rookie Striker", quizzesCompletedToday: 1)
    
    private let quizCategories: [QuizCategory] = [
        QuizCategory(title: "Rules of the Game", description: "Test your knowledge of FIFA regulations.", iconName: "list.number"),
        QuizCategory(title: "Legendary Matches", description: "Relive epic moments in football history.", iconName: "sportscourt.fill"),
        QuizCategory(title: "Championship History", description: "Learn about the history of major tournaments.", iconName: "calendar")
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        navigationItem.title = "Football Quizzes"
    }
    
    // MARK: - Setup
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGroupedBackground
        tableView.separatorStyle = .none
        
        // Регистрация ячеек
        tableView.register(QuizStatsCell.self, forCellReuseIdentifier: QuizStatsCell.reuseIdentifier)
        tableView.register(QuizCategoryCell.self, forCellReuseIdentifier: QuizCategoryCell.reuseIdentifier)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    private func startQuiz(category: QuizCategory) {
        print("Starting quiz: \(category.title)")
        
        // Здесь мы создаем моковый QuizViewController и пушим его
        let quizVC = QuizSessionVC()
        quizVC.title = category.title
        navigationController?.pushViewController(quizVC, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension QuizzesVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // 0: Stats, 1: Quiz Categories
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1 // Одна ячейка для статистики
        } else {
            return quizCategories.count // Количество доступных викторин
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 1 ? "Daily Quizzes" : nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizStatsCell.reuseIdentifier, for: indexPath) as? QuizStatsCell else {
                return UITableViewCell()
            }
            cell.configure(with: playerStats)
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizCategoryCell.reuseIdentifier, for: indexPath) as? QuizCategoryCell else {
                return UITableViewCell()
            }
            let category = quizCategories[indexPath.row]
            cell.configure(with: category)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension QuizzesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 {
            let category = quizCategories[indexPath.row]
            startQuiz(category: category)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 100 : 70
    }
}
