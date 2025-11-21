import UIKit
import SnapKit

class BadgeCell: UITableViewCell {
    static let reuseIdentifier = "BadgeCell"
    
    private let iconImageView = UIImageView()
    private let nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        accessoryType = .disclosureIndicator
        
        nameLabel.font = .second(ofSize: 16)
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(15)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(with badge: Badge) {
        nameLabel.text = badge.name
        
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        iconImageView.image = UIImage(systemName: badge.iconName, withConfiguration: config)
        
        // Визуальная индикация разблокированного/заблокированного бейджа
        if badge.isUnlocked {
            iconImageView.tintColor = .systemGreen
            nameLabel.textColor = .label
            // Бейдж разблокирован, показать его полностью
            iconImageView.alpha = 1.0
        } else {
            iconImageView.tintColor = .systemGray
            nameLabel.textColor = .systemGray
            // Бейдж заблокирован, сделать его полупрозрачным
            iconImageView.alpha = 0.5
        }
    }
}
