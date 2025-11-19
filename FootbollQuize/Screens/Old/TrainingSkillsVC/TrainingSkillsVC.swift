import UIKit
import SnapKit

// MARK: - Training Log Data Model

struct TrainingSession {
    let date: Date
    let duration: TimeInterval // seconds
    let effortLevel: Int // 1-5
    let mood: String // e.g., "Great", "Tired"
}

class TrainingSkillsVC: UIViewController {

    // MARK: - UI Components
    
    // Используем UIScrollView для всего контента
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // Форма для ввода тренировки
    private let logSectionHeader = UILabel()
    private let logFormStackView = UIStackView()
    
    // Элементы формы (заглушки)
    private let durationField = UITextField()
    private let effortSlider = UISlider()
    private let moodSegmentedControl = UISegmentedControl(items: ["Great", "Good", "Meh", "Tired"])
    private let logButton = UIButton(type: .system)
    
    // График прогресса
    private let progressSectionHeader = UILabel()
    private let progressGraphView = UIView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLogForm()
        setupProgressView()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        navigationItem.title = "Personal Log"
        view.backgroundColor = .systemGroupedBackground // Фон для секций
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
    }
    
    private func setupLogForm() {
        // --- 1. Header ---
        logSectionHeader.text = "Log New Session"
        logSectionHeader.font = .systemFont(ofSize: 22, weight: .bold)
        logSectionHeader.textColor = .label
        
        // --- 2. Form Stack View ---
        logFormStackView.axis = .vertical
        logFormStackView.spacing = 15
        logFormStackView.isLayoutMarginsRelativeArrangement = true
        logFormStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        logFormStackView.backgroundColor = .secondarySystemGroupedBackground
        logFormStackView.layer.cornerRadius = 12
        
        // --- 3. Form Fields ---
        
        // Duration Field
        durationField.placeholder = "Duration (in minutes)"
        durationField.keyboardType = .numberPad
        durationField.borderStyle = .roundedRect
        
        // Effort Slider
        effortSlider.minimumValue = 1
        effortSlider.maximumValue = 5
        effortSlider.value = 3
        let effortLabel = createLabel(text: "Effort Level (1-5): \(Int(effortSlider.value))")
        effortSlider.addTarget(self, action: #selector(effortSliderChanged(_:)), for: .valueChanged)

        // Mood Segmented Control
        moodSegmentedControl.selectedSegmentIndex = 0
        
        // Log Button
        logButton.setTitle("Log Session", for: .normal)
        logButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        logButton.backgroundColor = .systemTeal
        logButton.setTitleColor(.white, for: .normal)
        logButton.layer.cornerRadius = 8
        logButton.snp.makeConstraints { $0.height.equalTo(44) }
        logButton.addTarget(self, action: #selector(logSessionTapped), for: .touchUpInside)

        // Добавление элементов в Stack View
        logFormStackView.addArrangedSubview(durationField)
        logFormStackView.addArrangedSubview(effortLabel)
        logFormStackView.addArrangedSubview(effortSlider)
        logFormStackView.addArrangedSubview(createLabel(text: "Mood:"))
        logFormStackView.addArrangedSubview(moodSegmentedControl)
        logFormStackView.addArrangedSubview(logButton)

        // --- 4. Content Layout ---
        contentView.addSubview(logSectionHeader)
        contentView.addSubview(logFormStackView)
        
        logSectionHeader.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        
        logFormStackView.snp.makeConstraints { make in
            make.top.equalTo(logSectionHeader.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    private func setupProgressView() {
        // --- 1. Header ---
        progressSectionHeader.text = "Progress & Statistics"
        progressSectionHeader.font = .systemFont(ofSize: 22, weight: .bold)
        progressSectionHeader.textColor = .label
        
        // --- 2. Graph View (Моковая заглушка) ---
        progressGraphView.backgroundColor = .secondarySystemGroupedBackground
        progressGraphView.layer.cornerRadius = 12
        
        let graphLabel = UILabel()
        graphLabel.text = "Graph: Progress Over Days/Weeks (Total Duration/Effort)"
        graphLabel.textColor = .secondaryLabel
        graphLabel.textAlignment = .center
        graphLabel.numberOfLines = 2
        
        progressGraphView.addSubview(graphLabel)
        progressGraphView.snp.makeConstraints { make in
            make.height.equalTo(200) // Фиксированная высота для графика
        }
        graphLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
        
        // --- 3. Content Layout ---
        contentView.addSubview(progressSectionHeader)
        contentView.addSubview(progressGraphView)
        
        progressSectionHeader.snp.makeConstraints { make in
            make.top.equalTo(logFormStackView.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
        }
        
        progressGraphView.snp.makeConstraints { make in
            make.top.equalTo(progressSectionHeader.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-20) // Конец скролла
        }
    }
    
    // MARK: - Helpers
    
    private func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        return label
    }

    // MARK: - Actions
    
    @objc private func effortSliderChanged(_ sender: UISlider) {
        // Обновляем текст лейбла усилия
        if let stack = logFormStackView.arrangedSubviews.first(where: { ($0 as? UILabel)?.text?.contains("Effort Level") ?? false }) as? UILabel {
            stack.text = "Effort Level (1-5): \(Int(sender.value))"
        }
    }
    
    @objc private func logSessionTapped() {
        let durationText = durationField.text ?? ""
        
        // Базовая валидация
        guard let durationMinutes = Int(durationText), durationMinutes > 0 else {
            // Здесь должна быть логика показа ошибки
            print("Error: Invalid duration")
            return
        }
        
        let effort = Int(effortSlider.value)
        let moodIndex = moodSegmentedControl.selectedSegmentIndex
        let mood = moodSegmentedControl.titleForSegment(at: moodIndex) ?? "N/A"
        
        let newSession = TrainingSession(
            date: Date(),
            duration: TimeInterval(durationMinutes * 60), // Convert minutes to seconds
            effortLevel: effort,
            mood: mood
        )
        
        // Здесь должна быть логика сохранения в базу данных/Core Data/Realm
        print("--- Logged New Session ---")
        print("Date: \(newSession.date)")
        print("Duration: \(durationMinutes) min")
        print("Effort: \(newSession.effortLevel)")
        print("Mood: \(newSession.mood)")
        
        // Очистка формы
        durationField.text = nil
        // Здесь можно добавить всплывающее уведомление об успешном сохранении
    }
}
