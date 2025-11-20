import UIKit
import SnapKit

class TrainingCompletedVC: UIViewController {
    
    // MARK: - Data Types
    enum MoodType {
        case bad, neutral, fine
    }
    
    enum Step {
        case initial
        case duration
        case tiredness
        case mood
    }
    
    // MARK: - Callbacks
    var onDone: (() -> Void)?
    
    // MARK: - State
    private let trainingTitle: String
    private var currentStep: Step = .initial
    
    private var trainedMinutes: Int = 5
    private var tirednessRating: Int = 3
    private var selectedMood: MoodType = .neutral
    
    private var starButtons: [UIButton] = []
    private var moodButtons: [UIButton] = []
    
    private let progressService = ProgressService()

    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 50
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.text = "\(trainedMinutes)\nmin"
        label.font = .systemFont(ofSize: 28, weight: .heavy)
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
        updateUI()
    }
    
    // MARK: - Layout
    private func setupContainerLayout() {
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func updateUI() {
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
        let iconContainer = UIView()
        iconContainer.backgroundColor = UIColor.activeColor.withAlphaComponent(0.4)
        iconContainer.layer.cornerRadius = 50
        
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "tick-circle")
        iconImageView.contentMode = .center
        iconImageView.tintColor = .primary
        
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
        
        containerView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(recordButton)
        containerView.addSubview(doneButton)
        
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
            let config = UIImage.SymbolConfiguration(pointSize: 35, weight: .medium)
            btn.setImage(UIImage(systemName: "star", withConfiguration: config), for: .normal)
            btn.setImage(UIImage(systemName: "star.fill", withConfiguration: config), for: .selected)
            btn.tintColor = .backgroundMain
            btn.tag = i
            btn.addTarget(self, action: #selector(starTapped(_:)), for: .touchUpInside)
            starStack.addArrangedSubview(btn)
            starButtons.append(btn)
        }
        updateStarAppearance()
        
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
        let moods: [MoodType] = [.bad, .neutral, .fine]
        
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
        progressService.saveProgress(
            ProgressServiceData(time: trainedMinutes, stars: tirednessRating, mood: "\(selectedMood)")
        )
        
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
                btn.tintColor = .activeColor
            } else {
                btn.isSelected = false
                btn.tintColor = .backgroundMain
            }
        }
    }
    
    @objc private func moodTapped(_ sender: UIButton) {
        let moods: [MoodType] = [.bad, .neutral, .fine]
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
        button.layer.cornerRadius = 32
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
