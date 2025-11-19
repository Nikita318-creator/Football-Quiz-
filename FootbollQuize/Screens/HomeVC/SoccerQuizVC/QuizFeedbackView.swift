import UIKit
import SnapKit

class QuizFeedbackView: UIView {
    
    var onActionTap: ((Bool) -> Void)?
    
    var isCorrect = false
    
    // UI Elements
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 24 // Скругление белой кнопки
        return button
    }()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .white
        return iv
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white.withAlphaComponent(0.9)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.cornerRadius = 24 // Скругление самой плашки
        clipsToBounds = true
        
        addSubview(actionButton)
        addSubview(iconImageView)
        addSubview(statusLabel)
        addSubview(subtitleLabel)
        
        actionButton.addTarget(self, action: #selector(didTapAction), for: .touchUpInside)
        
        // Констрейнты
        
        actionButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(actionButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview().offset(10) // Чуть сдвинем вправо из-за иконки
        }
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalTo(statusLabel)
            make.right.equalTo(statusLabel.snp.left).offset(-8)
            make.width.height.equalTo(24)
        }
        
        // Подзаголовок (для ошибки)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
    }
    
    func configure(isCorrect: Bool, correctAnswer: String = "") {
        self.isCorrect = isCorrect
        
        if isCorrect {
            backgroundColor = .success
            actionButton.setTitle("CONTINUE", for: .normal)
            actionButton.setTitleColor(.success, for: .normal)
            
            statusLabel.text = "Correct!"
            iconImageView.image = UIImage(named: "emoji-happy")
            
            subtitleLabel.isHidden = true
            
        } else {
            backgroundColor = .error
            actionButton.setTitle("GOT IT", for: .normal)
            actionButton.setTitleColor(.error, for: .normal)
            
            statusLabel.text = "Incorrect"
            iconImageView.image = UIImage(named: "emoji-sad")
            
            subtitleLabel.text = "Correct answer: \(correctAnswer)"
            subtitleLabel.isHidden = false
        }
    }
    
    @objc private func didTapAction() {
        onActionTap?(isCorrect)
    }
}
