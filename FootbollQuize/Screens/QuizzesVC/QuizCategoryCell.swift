import UIKit
import SnapKit

// MARK: - Quiz Data Models

// Информация о текущем прогрессе игрока
struct PlayerStats {
    let experiencePoints: Int
    let currentRank: String
    let quizzesCompletedToday: Int
    let dailyGoal: Int = 3
}

// Тип доступной викторины
struct QuizCategory {
    let title: String
    let description: String
    let iconName: String
}

// Пример вопроса
struct QuizQuestion {
    let text: String
    let options: [String]
    // В реальном приложении здесь был бы correctAnswerIndex
}

// MARK: - QuizCategoryCell (Ячейка для категорий викторин)

class QuizCategoryCell: UITableViewCell {
    static let reuseIdentifier = "QuizCategoryCell"
    
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        accessoryType = .disclosureIndicator // Стрелка для перехода
        backgroundColor = .secondarySystemGroupedBackground
        
        let textStack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        textStack.axis = .vertical
        textStack.spacing = 2
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(textStack)
        
        // Настройка стилей
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        descriptionLabel.font = .systemFont(ofSize: 13, weight: .regular)
        descriptionLabel.textColor = .secondaryLabel
        
        // Констрейнты
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        textStack.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(15)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-40) // Отступ от стрелки
        }
    }
    
    func configure(with category: QuizCategory) {
        titleLabel.text = category.title
        descriptionLabel.text = category.description
        
        let config = UIImage.SymbolConfiguration(pointSize: 22)
        iconImageView.image = UIImage(systemName: category.iconName, withConfiguration: config)
        iconImageView.tintColor = .systemBlue
    }
}
