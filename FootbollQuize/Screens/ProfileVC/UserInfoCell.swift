import UIKit
import SnapKit

// MARK: - Profile Data Models

struct UserProfile {
    let name: String
    let country: String
    let level: Int
    let totalWorkouts: Int
    let totalXP: Int
}

struct Badge {
    let name: String
    let description: String
    let iconName: String
    let isUnlocked: Bool
}

class UserInfoCell: UITableViewCell {
    static let reuseIdentifier = "UserInfoCell"
    
    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let countryLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        
        // Аватар (заглушка)
        avatarImageView.image = UIImage(systemName: "person.circle.fill")
        avatarImageView.tintColor = .systemGray3
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.layer.cornerRadius = 40 // Круглый
        avatarImageView.clipsToBounds = true
        
        nameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        countryLabel.font = .systemFont(ofSize: 15, weight: .regular)
        countryLabel.textColor = .secondaryLabel
        
        let textStack = UIStackView(arrangedSubviews: [nameLabel, countryLabel])
        textStack.axis = .vertical
        textStack.spacing = 2
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(textStack)
        
        avatarImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        textStack.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(with profile: UserProfile) {
        nameLabel.text = profile.name
        countryLabel.text = profile.country
        // В реальном приложении: avatarImageView.kf.setImage(with: profile.avatarURL)
    }
}
