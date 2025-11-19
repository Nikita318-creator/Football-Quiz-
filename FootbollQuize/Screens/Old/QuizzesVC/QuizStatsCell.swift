import UIKit
import SnapKit

class QuizStatsCell: UITableViewCell {
    static let reuseIdentifier = "QuizStatsCell"
    
    private let xpLabel = UILabel()
    private let rankLabel = UILabel()
    private let progressView = UIProgressView(progressViewStyle: .bar)
    private let progressLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Убираем стандартную подсветку
        selectionStyle = .none
        
        // UI
        let xpStack = UIStackView(arrangedSubviews: [xpLabel, rankLabel])
        xpStack.axis = .vertical
        xpStack.spacing = 4
        
        let headerStack = UIStackView(arrangedSubviews: [xpStack]) // Здесь можно добавить иконку бейджа
        headerStack.alignment = .center
        headerStack.spacing = 15
        
        let totalStack = UIStackView(arrangedSubviews: [headerStack, progressLabel, progressView])
        totalStack.axis = .vertical
        totalStack.spacing = 10
        
        contentView.addSubview(totalStack)
        
        // Настройка стилей
        xpLabel.font = .systemFont(ofSize: 30, weight: .black)
        xpLabel.textColor = .systemOrange // Цвет для XP
        
        rankLabel.font = .systemFont(ofSize: 15, weight: .medium)
        rankLabel.textColor = .secondaryLabel
        
        progressLabel.font = .systemFont(ofSize: 13, weight: .medium)
        progressLabel.textColor = .systemTeal
        progressView.tintColor = .systemTeal
        
        // Констрейнты
        totalStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
    }
    
    func configure(with stats: PlayerStats) {
        xpLabel.text = "\(stats.experiencePoints) XP"
        rankLabel.text = "Rank: \(stats.currentRank)"
        
        let progress = Float(stats.quizzesCompletedToday) / Float(stats.dailyGoal)
        progressView.setProgress(progress, animated: true)
        progressLabel.text = "Daily Goal: \(stats.quizzesCompletedToday) of \(stats.dailyGoal) Quizzes Completed"
    }
}
