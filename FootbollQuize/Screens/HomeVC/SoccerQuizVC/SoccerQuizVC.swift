import UIKit
import SnapKit

class SoccerQuizVC: UIViewController {
    
    // MARK: - UI Components
    
    let viewModel: SoccerQuizViewModel
    var currentQuestion = 0
    
    private var currentSelectedOption = 1
    private let soccerQuizService = SoccerQuizService()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)
        let image = UIImage(systemName: "chevron.left", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .secondTextColor
        button.backgroundColor = .white
        button.layer.cornerRadius = 22
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.05
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return button
    }()
    
    private let progressBar: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progressTintColor = .primary
        progress.trackTintColor = .white
        progress.progress = 0.0
        progress.layer.cornerRadius = 8
        progress.layer.masksToBounds = true
        progress.layer.borderWidth = 2
        progress.layer.borderColor = UIColor.white.cgColor
        return progress
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Soccer Quiz"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondTextColor
        return label
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .primary
        label.numberOfLines = 0
        return label
    }()
    
    private let answersStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fillEqually
        return stack
    }()
    
    // Кнопка проверки (обычная)
    private lazy var checkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CHECK", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .primary
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 28
        button.addTarget(self, action: #selector(didTapCheck), for: .touchUpInside)
        return button
    }()
    
    // НОВЫЙ КОМПОНЕНТ: Вьюшка с результатом
    private lazy var feedbackView: QuizFeedbackView = {
        let view = QuizFeedbackView()
        view.isHidden = true // Скрыта по умолчанию
        view.onActionTap = { [weak self] isCorrect in
            guard let self else { return }
            
            self.resetState()
            
            if isCorrect {
                currentQuestion += 1
                guard currentQuestion < viewModel.model.count else {
                    navigationController?.popViewController(animated: true)
                    return
                }
                progressBar.progress = Float(currentQuestion) / Float(viewModel.model.count)
                setupData()
                answersStackView.isUserInteractionEnabled = true
                
                soccerQuizService.save(
                    LastSoccerQuizData(
                        modelIndex: viewModel.currentModelNumber,
                        question: viewModel.model[currentQuestion].question,
                        questionNumber: currentQuestion
                    )
                )
            }
        }
        return view
    }()
    
    private var optionViews: [QuizOptionView] = []
    
    init(viewModel: SoccerQuizViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setProgress() {
        progressBar.progress = Float(currentQuestion) / Float(viewModel.model.count)
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.backgroundColor = .backgroundMain
        
        view.addSubview(backButton)
        view.addSubview(progressBar)
        view.addSubview(subtitleLabel)
        view.addSubview(questionLabel)
        view.addSubview(answersStackView)
        view.addSubview(checkButton)
        view.addSubview(feedbackView) // Добавляем новую вьюшку
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(44)
        }
        
        progressBar.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.left.equalTo(backButton.snp.right).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(20)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(20)
        }
        
        answersStackView.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
        }
        
        // Обычная кнопка CHECK
        checkButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
        
        feedbackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.left.right.equalToSuperview().inset(20)
            make.height.greaterThanOrEqualTo(140)
        }
    }
    
    // MARK: - Data & Logic
    
    private func setupData() {
        answersStackView.arrangedSubviews.forEach { view in
            answersStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        optionViews = []
        
        questionLabel.text = viewModel.model[currentQuestion].question
        
        let options = viewModel.model[currentQuestion].options
        
        for (index, text) in options.enumerated() {
            let optionView = QuizOptionView()
            optionView.configure(text: text)
            optionView.tag = index
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(optionTapped(_:)))
            optionView.addGestureRecognizer(tap)
            
            answersStackView.addArrangedSubview(optionView)
            optionViews.append(optionView)
            
            optionView.snp.makeConstraints { make in
                make.height.equalTo(60)
            }
        }
        
        if optionViews.count > 1 {
            selectOption(at: currentSelectedOption)
        }
    }
    
    private func selectOption(at index: Int) {
        optionViews.forEach { $0.isSelectedOption = false }
        optionViews[index].isSelectedOption = true
    }
    
    // MARK: - Actions
    
    @objc private func didTapCheck() {
        let correctOption = viewModel.model[currentQuestion].correctOption
        let isCorrect = correctOption == currentSelectedOption
        let correctAnswerText = "Option \(correctOption + 1)" // так как с 0 начинается счет
        
        // 1. Конфигурируем вьюшку
        feedbackView.configure(isCorrect: isCorrect, correctAnswer: correctAnswerText)

        // 2. Анимация смены состояния
        UIView.animate(withDuration: 0.3) {
            self.checkButton.alpha = 0
            self.feedbackView.isHidden = false
            self.feedbackView.alpha = 1
            self.optionViews[self.currentSelectedOption].updateAppearanceOnCheckTapped(isCorrect)
        }
        
        // 3. Блокируем нажатия на ответы, пока показывается результат
        answersStackView.isUserInteractionEnabled = false
    }
    
    // Нажатие на кнопку Continue / Got It
    private func resetState() {
        // Тут логика перехода к следующему вопросу
        print("Next Question Logic")
        
        // Для теста вернем кнопку Check обратно
        UIView.animate(withDuration: 0.3) {
            self.checkButton.alpha = 1
            self.feedbackView.alpha = 0
        } completion: { _ in
            self.feedbackView.isHidden = true
            self.answersStackView.isUserInteractionEnabled = true
        }
    }
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func optionTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view as? QuizOptionView else { return }
        currentSelectedOption = tappedView.tag
        selectOption(at: tappedView.tag)
    }
}
