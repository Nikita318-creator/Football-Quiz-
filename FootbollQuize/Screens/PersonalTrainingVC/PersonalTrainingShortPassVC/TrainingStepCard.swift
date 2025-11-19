import UIKit
import SnapKit

class TrainingStepCard: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        // Легкая тень для карточки
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .secondTextColor
        label.textAlignment = .center
        // Делаем кружок вокруг цифры
        label.layer.borderColor = UIColor.systemGray5.cgColor
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 20 // Половина от размера 40
        label.layer.masksToBounds = true
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondTextColor
        label.numberOfLines = 0 // Многострочный текст
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(number: String, text: String) {
        numberLabel.text = number
        descriptionLabel.text = text
    }
    
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(numberLabel)
        containerView.addSubview(descriptionLabel)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        numberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(40)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(numberLabel.snp.right).offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}
