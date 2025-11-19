import UIKit
import SnapKit

class PersonalTrainingShortPassVC: UIViewController {

    // MARK: - Data
    // Данные для шагов (на английском)
    private let stepsData: [String] = [
        "Stand straight, feet shoulder-width apart. Keep your gaze forward and relax your shoulders.",
        "Place the ball in front of you at a comfortable distance. Prepare to make a pass.",
        "Approach the ball slightly, planting your non-kicking foot next to the ball.",
        "Swing your kicking leg and strike the center of the ball with the inside of your foot for accuracy.",
        "Follow through with your kicking leg towards the target to ensure the ball travels straight."
    ]

    // MARK: - UI Components

    // 1. Header Image (Та же картинка)
    private let headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "PersonaltrainingImage") 
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        iv.addSubview(overlay)
        overlay.snp.makeConstraints { make in make.edges.equalToSuperview() }
        
        return iv
    }()
    
    // 2. Back Button (Стиль как в SoccerQuizVC)
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)
        let image = UIImage(systemName: "chevron.left", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .gray 
        button.backgroundColor = .white
        button.layer.cornerRadius = 22
        
        // Тень кнопки
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return button
    }()

    // 3. Header Labels (С исправленными тенями)
    private let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "SHORT PASS\nTRAINING" // Перенос строки как на макете
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        
        // Хорошая тень
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 1.0
        label.layer.shadowRadius = 4
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.masksToBounds = false
        
        return label
    }()

    private let headerSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "3 minutes"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .white
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 1.0
        label.layer.shadowRadius = 4
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.masksToBounds = false
        
        return label
    }()

    // 4. ScrollView для контента (так как текст может быть длинным)
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.backgroundColor = .backgroundMain
        sv.layer.cornerRadius = 15
        sv.layer.masksToBounds = true
        return sv
    }()
    
    // Контейнер внутри скролла (StackView)
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12 // Отступ между карточками
        stack.distribution = .fill
        return stack
    }()

    // 5. Кнопка "COMPLETED" (внизу, фиксированная)
    private lazy var completedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("COMPLETED", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .primary
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 28
        button.addTarget(self, action: #selector(didTapCompleted), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureSteps()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // MARK: - Setup UI

    private func setupUI() {
        view.backgroundColor = .backgroundMain
        
        view.addSubview(headerImageView)
        view.addSubview(backButton)
        view.addSubview(headerTitleLabel)
        view.addSubview(headerSubtitleLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        view.addSubview(completedButton)

        // --- Constraints ---
        
        headerImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(310)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(44)
        }
        
        headerTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(headerSubtitleLabel.snp.top).offset(-2)
            make.right.equalToSuperview().offset(-20)
        }
        
        headerSubtitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(scrollView.snp.top).offset(-20) 
        }
        
        completedButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerImageView.snp.bottom).offset(-30)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 180, right: 20))
            make.width.equalTo(scrollView.snp.width).offset(-40) // Важно для вертикального скролла
        }
    }
    
    private func configureSteps() {
        for (index, text) in stepsData.enumerated() {
            let stepCard = TrainingStepCard()
            stepCard.configure(number: "\(index + 1)", text: text)
            contentStackView.addArrangedSubview(stepCard)
        }
    }

    // MARK: - Actions

    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapCompleted() {
        let popup = TrainingCompletedVC(trainingTitle: "Short Pass Training")
        
        popup.onDone = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        present(popup, animated: true)
    }
}
