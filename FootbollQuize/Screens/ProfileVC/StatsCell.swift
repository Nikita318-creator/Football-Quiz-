import UIKit
import SnapKit

class StatsCell: UITableViewCell {
    static let reuseIdentifier = "StatsCell"
    
    private let statsStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        
        statsStackView.axis = .horizontal
        statsStackView.distribution = .fillEqually
        statsStackView.spacing = 10
        
        contentView.addSubview(statsStackView)
        statsStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
        }
    }
    
    func configure(with profile: UserProfile) {
        statsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let levelView = createStatView(value: "\(profile.level)", title: "Level", color: .systemBlue)
        let workoutsView = createStatView(value: "\(profile.totalWorkouts)", title: "Workouts", color: .systemTeal)
        let xpView = createStatView(value: "\(profile.totalXP)", title: "Total XP", color: .systemOrange)
        
        statsStackView.addArrangedSubview(levelView)
        statsStackView.addArrangedSubview(workoutsView)
        statsStackView.addArrangedSubview(xpView)
    }
    
    private func createStatView(value: String, title: String, color: UIColor) -> UIView {
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 24, weight: .bold)
        valueLabel.textColor = color
        valueLabel.textAlignment = .center
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 13, weight: .medium)
        titleLabel.textColor = .secondaryLabel
        titleLabel.textAlignment = .center
        
        let stack = UIStackView(arrangedSubviews: [valueLabel, titleLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
        
        return stack
    }
}
