import UIKit
import SnapKit

class TrainingCompletedVC: UIViewController {
    
    // MARK: - Data Types
    enum MoodType {
        case bad, neutral, good
    }
    
    enum Step {
        case initial        // Экран с галочкой
        case duration       // Сколько тренировался
        case tiredness      // Звезды
        case mood           // Смайлы
    }
    
    // MARK: - Callbacks
    var onDone: (() -> Void)?
    // Передает (Минуты, Рейтинг усталости 1-5, Настроение)
    var onRecordFinished: ((Int, Int, MoodType?) -> Void)?
    
    // MARK: - State
    private let trainingTitle: String
    private var currentStep: Step = .initial
    
    // Данные пользователя
    private var trainedMinutes: Int = 5
    private var tirednessRating: Int = 0
    private var selectedMood: MoodType? = nil
    
    private var starButtons: [UIButton] = []
    private var moodButtons: [UIButton] = []
    
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 50
        view.layer.masksToBounds = true
        return view
    }()
    
    // Лейбл времени храним, чтобы обновлять текст
    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.text = "\(trainedMinutes)\nmin"
        label.font = .systemFont(ofSize: 28, weight: .heavy) // Жирный шрифт цифры
        label.textColor = .primary
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - Init
    init(trainingTitle: String) {
        self.trainingTitle = trainingTitle
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        setupContainerLayout()
        updateUI() // Отрисовка первого состояния
    }
    
    // MARK: - Layout
    private func setupContainerLayout() {
        view.addSubview(containerView)
        
        // ВЕРНУЛ ОТСТУПЫ 10
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10) // Отступ снизу 10, а не прилипание к safeArea
            // Высота определяется контентом внутри
        }
    }
    
    // Главный метод перерисовки
    private func updateUI() {
        // Очищаем старое
        containerView.subviews.forEach { $0.removeFromSuperview() }
        
        switch currentStep {
        case .initial:
            setupInitialView()
        case .duration:
            setupDurationView()
        case .tiredness:
            setupTirednessView()
        case .mood:
            setupMoodView()
        }
    }
    
    // MARK: - 1. Initial View
    private func setupInitialView() {
        // Фон иконки
        let iconContainer = UIView()
        iconContainer.backgroundColor = UIColor.activeColor.withAlphaComponent(0.4)
        iconContainer.layer.cornerRadius = 50
        
        // ВЕРНУЛ ВАШУ ИКОНКУ
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "tick-circle")
        iconImageView.contentMode = .center
        iconImageView.tintColor = .primary // Если иконка шаблонная (template), иначе уберите эту строку
        
        let titleLabel = UILabel()
        titleLabel.text = "TRAINING\nCOMPLETE"
        titleLabel.font = .systemFont(ofSize: 28, weight: .heavy)
        titleLabel.textColor = .primary
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "You have successfully completed\n“\(trainingTitle)”"
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        subtitleLabel.textColor = .secondTextColor
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        
        let recordButton = createButton(title: "RECORD MY FEELINGS", bgColor: .backgroundMain, titleColor: .primary)
        recordButton.addTarget(self, action: #selector(didTapRecord), for: .touchUpInside)
        
        let doneButton = createButton(title: "DONE", bgColor: .primary, titleColor: .activeColor)
        doneButton.addTarget(self, action: #selector(didTapDoneFinal), for: .touchUpInside)
        
        // Добавляем
        containerView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(recordButton)
        containerView.addSubview(doneButton)
        
        // Констрейнты
        iconContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconContainer.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        recordButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(64)
        }
        
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(recordButton.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(64)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: - 2. Duration View
    private func setupDurationView() {
        let titleLabel = createHeaderLabel(text: "How long have\nyou trained?")
        
        let minusBtn = createCounterButton(title: "-")
        minusBtn.addTarget(self, action: #selector(decreaseTime), for: .touchUpInside)
        
        let plusBtn = createCounterButton(title: "+")
        plusBtn.addTarget(self, action: #selector(increaseTime), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [minusBtn, durationLabel, plusBtn])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 20
        
        let nextBtn = createButton(title: "NEXT", bgColor: .primary, titleColor: .activeColor)
        nextBtn.addTarget(self, action: #selector(goToTiredness), for: .touchUpInside)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(stack)
        containerView.addSubview(nextBtn)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(220)
        }
        
        nextBtn.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(64)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: - 3. Tiredness View
    private func setupTirednessView() {
        let titleLabel = createHeaderLabel(text: "How tired are\nyou?")
        
        let starStack = UIStackView()
        starStack.axis = .horizontal
        starStack.distribution = .fillEqually
        starStack.spacing = 8
        
        starButtons = []
        for i in 1...5 {
            let btn = UIButton()
            // Используем системную звезду, так как название вашей звезды не указано,
            // но красим её в activeColor. Замените на UIImage(named: "star") при наличии.
            let config = UIImage.SymbolConfiguration(pointSize: 35, weight: .medium)
            btn.setImage(UIImage(systemName: "star", withConfiguration: config), for: .normal)
            btn.setImage(UIImage(systemName: "star.fill", withConfiguration: config), for: .selected)
            btn.tintColor = .backgroundMain // Цвет неактивной звезды
            btn.tag = i
            btn.addTarget(self, action: #selector(starTapped(_:)), for: .touchUpInside)
            starStack.addArrangedSubview(btn)
            starButtons.append(btn)
        }
        updateStarAppearance() // Покрасить если уже выбрано
        
        let nextBtn = createButton(title: "NEXT", bgColor: .primary, titleColor: .activeColor)
        nextBtn.addTarget(self, action: #selector(goToMood), for: .touchUpInside)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(starStack)
        containerView.addSubview(nextBtn)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        starStack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(260)
            make.height.equalTo(50)
        }
        
        nextBtn.snp.makeConstraints { make in
            make.top.equalTo(starStack.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(64)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: - 4. Mood View
    private func setupMoodView() {
        let titleLabel = createHeaderLabel(text: "How is your\nmood?")
        
        let moodStack = UIStackView()
        moodStack.axis = .horizontal
        moodStack.distribution = .fillEqually
        moodStack.spacing = 20
        
        moodButtons = []
        let moods: [MoodType] = [.bad, .neutral, .good]
        
        for (index, _) in moods.enumerated() {
            let btn = UIButton()
            btn.backgroundColor = .clear
            
            let iconName: String
            if index == 0 { iconName = "grammerlyDislike" }
            else if index == 1 { iconName = "grammerly" }
            else { iconName = "grammerlyLike" }
            
            btn.setImage(UIImage(named: iconName), for: .normal)
            btn.tintColor = .backgroundMain
            btn.tag = index
            btn.addTarget(self, action: #selector(moodTapped(_:)), for: .touchUpInside)
            
            moodStack.addArrangedSubview(btn)
            moodButtons.append(btn)
        }
        
        let doneBtn = createButton(title: "DONE", bgColor: .primary, titleColor: .activeColor)
        doneBtn.addTarget(self, action: #selector(didTapDoneFinal), for: .touchUpInside)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(moodStack)
        containerView.addSubview(doneBtn)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        moodStack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(70)
        }
        
        doneBtn.snp.makeConstraints { make in
            make.top.equalTo(moodStack.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(64)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: - Logic Actions
    
    @objc private func didTapRecord() {
        currentStep = .duration
        updateUI()
    }
    
    @objc private func goToTiredness() {
        currentStep = .tiredness
        updateUI()
    }
    
    @objc private func goToMood() {
        currentStep = .mood
        updateUI()
    }
    
    @objc private func didTapDoneFinal() {
        // Возвращаем данные и закрываем
        onRecordFinished?(trainedMinutes, tirednessRating, selectedMood)
        onDone?()
        dismiss(animated: true)
    }
    
    @objc private func increaseTime() {
        trainedMinutes += 1
        durationLabel.text = "\(trainedMinutes)\nmin"
    }
    
    @objc private func decreaseTime() {
        if trainedMinutes > 0 {
            trainedMinutes -= 1
            durationLabel.text = "\(trainedMinutes)\nmin"
        }
    }
    
    @objc private func starTapped(_ sender: UIButton) {
        tirednessRating = sender.tag
        updateStarAppearance()
    }
    
    private func updateStarAppearance() {
        for btn in starButtons {
            if btn.tag <= tirednessRating {
                btn.isSelected = true
                btn.tintColor = .activeColor // Ваши лаймовые звезды
            } else {
                btn.isSelected = false
                btn.tintColor = .backgroundMain // Серые звезды
            }
        }
    }
    
    @objc private func moodTapped(_ sender: UIButton) {
        let moods: [MoodType] = [.bad, .neutral, .good]
        selectedMood = moods[sender.tag]
        
        for (index, btn) in moodButtons.enumerated() {
            if index == sender.tag {
                btn.backgroundColor = .clear
                btn.tintColor = .activeColor
            } else {
                btn.backgroundColor = .clear
                btn.tintColor = .backgroundMain
            }
        }
    }
    
    // MARK: - UI Helpers
    
    private func createButton(title: String, bgColor: UIColor, titleColor: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = bgColor
        button.setTitleColor(titleColor, for: .normal)
        button.layer.cornerRadius = 32 // Высота кнопки 64, значит радиус 32
        return button
    }
    
    private func createHeaderLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 28, weight: .heavy)
        label.textColor = .primary
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }
    
    private func createCounterButton(title: String) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.primary, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 32, weight: .medium)
        btn.backgroundColor = .backgroundMain
        btn.layer.cornerRadius = 16
        btn.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }
        return btn
    }
}
