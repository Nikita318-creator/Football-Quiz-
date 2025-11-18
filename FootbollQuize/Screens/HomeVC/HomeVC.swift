import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    // MARK: - UI Components
    
    // Контейнер для всех быстрых карточек
    private let quickCardsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16 // Расстояние между карточками
        stack.distribution = .fillEqually // Карточки будут иметь одинаковую высоту
        return stack
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupQuickCards()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        // Установка заголовка
        navigationItem.title = "Home"
        view.backgroundColor = .systemBackground // Светлый/темный фон
        
        // Добавление Stack View на экран
        view.addSubview(quickCardsStackView)
        
        // Настройка констрейнтов через SnapKit
        quickCardsStackView.snp.makeConstraints { make in
            // Отступы от безопасной зоны
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.right.equalToSuperview().inset(20) // Горизонтальные отступы
        }
    }
    
    private func setupQuickCards() {
        // 1. "My Training" Card
        let trainingCard = createCard(
            title: "My Training",
            subtitle: "Start your personalized session.",
            iconName: "figure.walk",
            action: #selector(didTapMyTraining)
        )
        
        // 2. "Quiz of the Day" Card
        let quizCard = createCard(
            title: "Quiz of the Day",
            subtitle: "Test your football knowledge.",
            iconName: "q.circle.fill",
            action: #selector(didTapQuizOfTheDay)
        )
        
        // 3. "Coach's Tip" Card
        let tipCard = createCard(
            title: "Coach's Tip",
            subtitle: "Get a new winning strategy.",
            iconName: "lightbulb.fill",
            action: #selector(didTapCoachesTip)
        )
        
        // Добавление карточек в Stack View
        quickCardsStackView.addArrangedSubview(trainingCard)
        quickCardsStackView.addArrangedSubview(quizCard)
        quickCardsStackView.addArrangedSubview(tipCard)
        
        // Установка минимальной высоты для Stack View (чтобы карточки не были слишком узкими)
        quickCardsStackView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(250)
        }
    }
    
    // MARK: - Card Factory (Фабрика для создания красивых карточек)
    
    private func createCard(title: String, subtitle: String, iconName: String, action: Selector) -> UIView {
        let cardView = UIView()
        cardView.backgroundColor = .secondarySystemGroupedBackground
        cardView.layer.cornerRadius = 16
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.08 // Легкая тень для эффекта приподнятости
        cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardView.layer.shadowRadius = 8
        
        // Добавление Tap Gesture Recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: action)
        cardView.addGestureRecognizer(tapGesture)
        
        // Иконка
        let iconImageView = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        iconImageView.image = UIImage(systemName: iconName, withConfiguration: config)
        iconImageView.tintColor = .systemTeal
        
        // Заголовок
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.textColor = .label
        
        // Подзаголовок
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = .systemFont(ofSize: 15, weight: .regular)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 0
        
        // Организация элементов внутри карточки
        let textStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        textStack.axis = .vertical
        textStack.spacing = 4
        
        cardView.addSubview(iconImageView)
        cardView.addSubview(textStack)
        
        // Констрейнты для элементов карточки
        iconImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(20)
            make.width.height.equalTo(35)
        }
        
        textStack.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview().inset(20)
        }
        
        return cardView
    }
    
    // MARK: - Actions
    
    @objc private func didTapMyTraining() {
        print("Tapped: My Training")
        // Заглушка: пушим новый контроллер
        let nextVC = UIViewController()
        nextVC.view.backgroundColor = .systemBackground
        nextVC.title = "My Training Details"
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func didTapQuizOfTheDay() {
        print("Tapped: Quiz of the Day")
        // Заглушка
        let nextVC = UIViewController()
        nextVC.view.backgroundColor = .systemBackground
        nextVC.title = "Daily Quiz"
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func didTapCoachesTip() {
        print("Tapped: Coach's Tip")
        // Заглушка
        let nextVC = UIViewController()
        nextVC.view.backgroundColor = .systemBackground
        nextVC.title = "Coach's Wisdom"
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
