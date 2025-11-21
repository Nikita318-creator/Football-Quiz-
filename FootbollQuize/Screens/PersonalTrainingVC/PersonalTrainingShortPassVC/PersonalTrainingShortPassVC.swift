import UIKit
import SnapKit

class PersonalTrainingShortPassVC: UIViewController {

    // MARK: - Data

    var currentIndex: Int = 0
    var durationMinutes: Int = 3
    private let viewModel = PersonalTrainingShortPassViewModel()
    private let progressService = ProgressService()

    private var stepsData: [String] {
        viewModel.model[currentIndex].steps
    }
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        let startColor = UIColor(red: 0x0A/255.0, green: 0x23/255.0, blue: 0x4F/255.0, alpha: 0.0).cgColor
        let endColor = UIColor(red: 0x0A/255.0, green: 0x23/255.0, blue: 0x4F/255.0, alpha: 1.0).cgColor
        
        layer.colors = [startColor, endColor]
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        return layer
    }()
    
    // MARK: - UI Components

    private let headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "PersonaltrainingImage")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return button
    }()

    private let headerTitleLabel: UILabel = {
        let label = UILabel()
//        label.text = "SHORT PASS\nTRAINING"
        label.numberOfLines = 2
        label.font = .main(ofSize: 32)
        label.textColor = .white
        return label
    }()

    private let headerSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .second(ofSize: 16)
        label.textColor = .white
        return label
    }()

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.backgroundColor = .backgroundMain
        sv.layer.cornerRadius = 22
        sv.layer.masksToBounds = true
        return sv
    }()
    
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fill
        return stack
    }()

    private lazy var completedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("COMPLETED", for: .normal)
        button.titleLabel?.font = .main(ofSize: 16)
        button.backgroundColor = .primary
        button.setTitleColor(.activeColor, for: .normal)
        button.layer.cornerRadius = 32
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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = headerImageView.bounds
    }

    // MARK: - Setup UI

    private func setupUI() {
        headerTitleLabel.text = viewModel.model[currentIndex].title
        headerSubtitleLabel.text = "\(durationMinutes) minutes"
        
        view.backgroundColor = .backgroundMain
        
        view.addSubview(headerImageView)

        headerImageView.layer.addSublayer(gradientLayer)
        
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
            make.width.height.equalTo(38)
        }
        
        headerTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(headerSubtitleLabel.snp.top)
            make.right.equalToSuperview().offset(-20)
        }
        
        headerSubtitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(scrollView.snp.top).offset(-16)
        }
        
        completedButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(64)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerImageView.snp.bottom).offset(-30)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 8, bottom: 180, right: 8))
            make.width.equalTo(scrollView.snp.width).offset(-16)
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
            self?.progressService.saveTrainingCompleted(id: self?.currentIndex ?? 0)
            self?.navigationController?.popViewController(animated: true)
        }
        
        present(popup, animated: true)
    }
}
