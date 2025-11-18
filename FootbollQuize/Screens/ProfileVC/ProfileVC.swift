import UIKit
import SnapKit

class ProfileVC: UIViewController {

    // MARK: - Properties
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // Моковые данные
    private let userProfile = UserProfile(
        name: "Alexey Petrov",
        country: "Russia",
        level: 8,
        totalWorkouts: 42,
        totalXP: 1250
    )
    
    private let badges: [Badge] = [
        Badge(name: "Rookie", description: "Completed 5 quizzes.", iconName: "person.badge.shield.checkmark.fill", isUnlocked: true),
        Badge(name: "Midfielder", description: "Logged 10 training sessions.", iconName: "figure.soccer", isUnlocked: true),
        Badge(name: "Captain", description: "Achieved Level 10.", iconName: "star.fill", isUnlocked: false),
        Badge(name: "Tactician", description: "Mastered the 'Defense Work' skill.", iconName: "shield.checkered", isUnlocked: false)
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        navigationItem.title = "Profile"
    }
    
    // MARK: - Setup
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGroupedBackground
        tableView.separatorStyle = .none
        
        // Регистрация ячеек
        tableView.register(UserInfoCell.self, forCellReuseIdentifier: UserInfoCell.reuseIdentifier)
        tableView.register(StatsCell.self, forCellReuseIdentifier: StatsCell.reuseIdentifier)
        tableView.register(BadgeCell.self, forCellReuseIdentifier: BadgeCell.reuseIdentifier)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource

extension ProfileVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3 // 0: User Info, 1: Stats, 2: Badges
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1 // User Info Cell
        case 1: return 1 // Combined Stats Cell
        case 2: return badges.count // Badge Cells
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1: return "Activity Stats"
        case 2: return "Badges"
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoCell.reuseIdentifier, for: indexPath) as? UserInfoCell else { return UITableViewCell() }
            cell.configure(with: userProfile)
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StatsCell.reuseIdentifier, for: indexPath) as? StatsCell else { return UITableViewCell() }
            cell.configure(with: userProfile)
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BadgeCell.reuseIdentifier, for: indexPath) as? BadgeCell else { return UITableViewCell() }
            let badge = badges[indexPath.row]
            cell.configure(with: badge)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension ProfileVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 100 // User Info
        case 1: return 80 // Stats
        default: return 60 // Badges
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 2 {
            let badge = badges[indexPath.row]
            print("Selected badge: \(badge.name). Unlocked: \(badge.isUnlocked)")
            // Здесь может быть логика показа детального view для бейджа
        }
    }
}
