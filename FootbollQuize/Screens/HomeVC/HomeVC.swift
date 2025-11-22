import UIKit
import SnapKit

// MARK: - HomeVC

class HomeVC: UIViewController {

    // MARK: - Data
    private let trainingItems: [TrainingItem] = [
        TrainingItem(title: "Short pass training", durationMinutes: 3),
        TrainingItem(title: "Short pass training", durationMinutes: 5),
        TrainingItem(title: "Short pass training", durationMinutes: 7)
    ]
    
    private var quizData = QuizModel(
        currentProgress: 1,
        totalQuestions: 50,
        continueText: "Continue quiz",
        subContinueText: ""
    )
    private var soccerQuizData: LastSoccerQuizData?
    
    private let soccerQuizService = SoccerQuizService()

    // MARK: - UI Components
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var logoButton: UIButton = {
        let button = UIButton(type: .system)
        if let image = UIImage(named: "LOGO") {
            button.setImage(image, for: .normal)
        }
        return button
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)
        return button
    }()
    
    private let navBarContainer = UIView()
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "MY TRAINING"
        label.font = .main(ofSize: 32)
        label.textColor = .primary
        return label
    }()
    
    private let mainSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Recommended for today"
        label.font = .second(ofSize: 17)
        label.textColor = .secondTextColor
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(TrainingCardCell.self, forCellWithReuseIdentifier: TrainingCardCell.reuseID)
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    private let quizTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "SOCCER QUIZ"
        label.font = .main(ofSize: 32)
        label.textColor = .primary
        return label
    }()
    
    private let quizSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Learn soccer theory and history"
        label.font = .second(ofSize: 17)
        label.textColor = .secondTextColor
        return label
    }()
    
    private lazy var quizCardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.08
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 8
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapQuizCard))
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "Quiz progression"
        label.font = .second(ofSize: 18)
        label.textColor = .textColor
        return label
    }()
    
    private let progressValueLabel: UILabel = {
        let label = UILabel()
        label.font = .main(ofSize: 32)
        label.textColor = .textColor
        return label
    }()
    
    private let progressBar: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progressTintColor = .activeColor 
        progress.trackTintColor = .primary
        progress.progress = 0.1
        progress.layer.cornerRadius = 7.5
        progress.layer.masksToBounds = true
        progress.layer.borderWidth = 3
        progress.layer.borderColor = UIColor.primary.cgColor
        return progress
    }()
    
    private let continueLabel: UILabel = {
        let label = UILabel()
        label.font = .second(ofSize: 17)
        label.textColor = .textColor
        return label
    }()
    
    private let continueSubLabel: UILabel = {
        let label = UILabel()
        label.font = .second(ofSize: 15)
        label.textColor = .secondTextColor
        label.numberOfLines = 0
        return label
    }()
    
    private let arrowAccessory: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "arrowRight"))
        iv.tintColor = .secondTextColor
        return iv
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        for family in UIFont.familyNames {
//            for name in UIFont.fontNames(forFamilyName: family) {
//                print(name) // Это и есть точное PostScript-имя
//            }
//        }
        
        setupUI()
        updateQuizCard(with: quizData)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let soccerQuizData = soccerQuizService.get() else { return }
        
        self.soccerQuizData = soccerQuizData
        quizData = QuizModel(
            currentProgress: soccerQuizData.questionNumber,
            totalQuestions: SoccerQuizViewModel(currentModelNumber: soccerQuizData.modelIndex).model.count,
            continueText: "Continue quiz",
            subContinueText: soccerQuizData.question
        )
        updateQuizCard(with: quizData)
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.backgroundColor = .backgroundMain
        
        // Скрываем стандартный Navigation Bar
        navigationController?.setNavigationBarHidden(true, animated: false)

        // 1. Scroll View Setup
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview() // Важно для вертикального скролла
        }
        
        // 2. Custom Navigation Bar (Logo and Settings)
        contentView.addSubview(navBarContainer)
        navBarContainer.addSubview(logoButton)
        navBarContainer.addSubview(settingsButton)
        
        navBarContainer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(44) // Стандартная высота nav bar
        }
        
        logoButton.snp.makeConstraints { make in
            make.centerY.left.equalToSuperview()
        }
        
        settingsButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(44)
        }
        
        // 3. Titles and Subtitles (Training)
        contentView.addSubview(mainTitleLabel)
        contentView.addSubview(mainSubtitleLabel)
        
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(navBarContainer.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        
        mainSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(20)
        }
        
        // 4. Collection View (Training Cards)
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(mainSubtitleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview() // Позволяет скроллить от края до края
            make.height.equalTo(180) // Фиксированная высота для карточек
        }
        
        // 5. Titles and Subtitles (Quiz)
        contentView.addSubview(quizTitleLabel)
        contentView.addSubview(quizSubtitleLabel)
        
        quizTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(20)
        }
        
        quizSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(quizTitleLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(20)
        }
        
        // 6. Quiz Card View
        contentView.addSubview(quizCardView)
        
        quizCardView.snp.makeConstraints { make in
            make.top.equalTo(quizSubtitleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-40) // Отступ снизу для скролла
        }
        
        // Элементы внутри Quiz Card
        quizCardView.addSubview(progressLabel)
        
        quizCardView.addSubview(progressValueLabel)
        quizCardView.addSubview(progressBar)
        
        let textStack = UIStackView(arrangedSubviews: [continueLabel, continueSubLabel])
        textStack.axis = .vertical
        textStack.spacing = 2
        
        let separator = UIView()
        separator.backgroundColor = .backgroundMain
        
        quizCardView.addSubview(textStack)
        quizCardView.addSubview(separator)
        quizCardView.addSubview(arrowAccessory)
        
        progressLabel.snp.makeConstraints { make in
            make.centerY.equalTo(progressValueLabel)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        
        progressValueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(progressValueLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(15)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(16)
            make.right.left.equalToSuperview()
            make.height.equalTo(1)
        }
        
        textStack.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(arrowAccessory.snp.left).offset(-10)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        arrowAccessory.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(textStack.snp.centerY)
            make.width.height.equalTo(24)
        }
    }
    
    // MARK: - Data Update
    
    private func updateQuizCard(with model: QuizModel) {
        progressValueLabel.text = "\(model.currentProgress) / \(model.totalQuestions)"
        
        let progress = Float(model.currentProgress) / Float(model.totalQuestions)
        progressBar.setProgress(progress, animated: true)
        
        continueLabel.text = model.continueText
        continueSubLabel.text = model.subContinueText
    }

    // MARK: - Actions

    @objc private func didTapSettings() {
        let settingsVC = SettingsVC()
//        soccerQuizVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    @objc private func didTapQuizCard() {
        guard let soccerQuizData else {
            let soccerQuizVC = SoccerQuizVC(viewModel: SoccerQuizViewModel(currentModelNumber: 0))
            soccerQuizVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(soccerQuizVC, animated: true)
            return
        }
        
        let soccerQuizVC = SoccerQuizVC(viewModel: SoccerQuizViewModel(currentModelNumber: soccerQuizData.modelIndex))
        soccerQuizVC.currentQuestion = soccerQuizData.questionNumber
        soccerQuizVC.setProgress()
        soccerQuizVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(soccerQuizVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trainingItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrainingCardCell.reuseID, for: indexPath) as? TrainingCardCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: trainingItems[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.45
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let soccerQuizVC = SoccerQuizVC(viewModel: SoccerQuizViewModel(currentModelNumber: indexPath.row))
        soccerQuizVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(soccerQuizVC, animated: true)
    }
}
