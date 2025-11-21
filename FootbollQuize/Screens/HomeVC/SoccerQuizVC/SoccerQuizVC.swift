import UIKit
import SnapKit

class SoccerQuizVC: UIViewController {
    
    let viewModel: SoccerQuizViewModel
    var currentQuestion = 0
    
    private var currentSelectedOption = 1
    private let soccerQuizService = SoccerQuizService()
    private let progressService = ProgressService()

    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "backButton"), for: .normal)
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
        label.font = .second(ofSize: 18)
        label.textColor = .secondTextColor
        return label
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.font = .main(ofSize: 32)
        label.textColor = .primary
        label.numberOfLines = 0
        return label
    }()
    
    private let answersStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let whiteContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        return view
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CHECK", for: .normal)
        button.titleLabel?.font = .main(ofSize: 16)
        button.backgroundColor = .primary
        button.setTitleColor(.activeColor, for: .normal)
        button.layer.cornerRadius = 28
        button.addTarget(self, action: #selector(didTapCheck), for: .touchUpInside)
        return button
    }()
    
    private lazy var feedbackView: QuizFeedbackView = {
        let view = QuizFeedbackView()
        view.isHidden = true
        view.onActionTap = { [weak self] isCorrect in
            guard let self else { return }
            
            self.resetState()
            
            if isCorrect {
                currentQuestion += 1
                guard currentQuestion < viewModel.model.count else {
                    progressService.saveQuizeCompleted(id: viewModel.currentModelNumber)
                    navigationController?.popViewController(animated: true)
                    return
                }
                progressBar.progress = Float(currentQuestion) / Float(viewModel.model.count)
                self.setupData()
                self.answersStackView.isUserInteractionEnabled = true
                
                self.soccerQuizService.save(
                    LastSoccerQuizData(
                        modelIndex: self.viewModel.currentModelNumber,
                        question: self.viewModel.model[self.currentQuestion].question,
                        questionNumber: self.currentQuestion
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
    
    private func setupUI() {
        view.backgroundColor = .backgroundMain
        
        view.addSubview(backButton)
        view.addSubview(progressBar)
        view.addSubview(subtitleLabel)
        view.addSubview(questionLabel)
        view.addSubview(answersStackView)
        
        view.addSubview(whiteContainerView)
        whiteContainerView.addSubview(checkButton)
        
        view.addSubview(feedbackView)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(38)
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
            make.top.equalTo(questionLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(8)
        }
        
        whiteContainerView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.right.equalToSuperview().inset(8)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.height.equalTo(56)
        }
        
        feedbackView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview().inset(0)
            make.height.greaterThanOrEqualTo(140)
        }
    }
    
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
    
    @objc private func didTapCheck() {
        let correctOption = viewModel.model[currentQuestion].correctOption
        let isCorrect = correctOption == currentSelectedOption
        let correctAnswerText = "Option \(correctOption + 1)"
        
        feedbackView.configure(isCorrect: isCorrect, correctAnswer: correctAnswerText)

        UIView.animate(withDuration: 0.3) {
            self.whiteContainerView.alpha = 0
            self.feedbackView.isHidden = false
            self.feedbackView.alpha = 1
            self.optionViews[self.currentSelectedOption].updateAppearanceOnCheckTapped(isCorrect)
        }
        
        answersStackView.isUserInteractionEnabled = false
    }
    
    private func resetState() {
        UIView.animate(withDuration: 0.3) {
            self.whiteContainerView.alpha = 1
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
