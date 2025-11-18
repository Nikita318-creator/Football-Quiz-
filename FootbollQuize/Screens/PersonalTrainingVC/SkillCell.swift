import UIKit
import SnapKit

// MARK: - Skill Data Model

struct TrainingSkill {
    let name: String
    let iconName: String // SF Symbol name
}

class SkillCell: UICollectionViewCell {
    static let reuseIdentifier = "SkillCell"
    
    private let titleLabel = UILabel()
    private let iconImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray4.cgColor
        
        let stackView = UIStackView(arrangedSubviews: [iconImageView, titleLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.lessThanOrEqualTo(contentView).offset(-16)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(40)
        }
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .label
    }
    
    func configure(with skill: TrainingSkill) {
        titleLabel.text = skill.name
        
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        iconImageView.image = UIImage(systemName: skill.iconName, withConfiguration: config)
        iconImageView.tintColor = .systemTeal
    }
}
