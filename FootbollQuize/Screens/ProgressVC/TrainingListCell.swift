import UIKit
import SnapKit

class TrainingListCell: UICollectionViewCell {
    static let reuseID = "TrainingListCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        // Тень
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.05).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 10
        return view
    }()
    
    private let clockIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "clock.fill"))
        iv.tintColor = .secondTextColor
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .second(ofSize: 12)
        label.textColor = .secondTextColor
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .second(ofSize: 17)
        label.textColor = .textColor
        return label
    }()
    
    private let badgesStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(clockIcon)
        containerView.addSubview(timeLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(badgesStack)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        clockIcon.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.width.height.equalTo(14)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(clockIcon)
            make.left.equalTo(clockIcon.snp.right).offset(6)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(clockIcon.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
        }
        
        badgesStack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(26)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func configure(with item: TrainingSession) {
        timeLabel.text = "\(item.duration) minutes long"
        titleLabel.text = item.title
        
        // Clear old badges
        badgesStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Mood Badge
        let moodBadge = createBadge(icon: "face.smiling", text: "Mood: \(item.mood)")
        badgesStack.addArrangedSubview(moodBadge)
        
        // Fatigue Badge
        let fatigueBadge = createBadge(icon: "star.fill", text: "Fatigue: \(item.fatigue)/5")
        badgesStack.addArrangedSubview(fatigueBadge)
    }
    
    private func createBadge(icon: String, text: String) -> UIView {
        let view = UIView()
        view.backgroundColor = .backgroundMain
        view.layer.cornerRadius = 13
        
        let iv = UIImageView(image: UIImage(systemName: icon))
        iv.tintColor = .secondTextColor
        
        let lbl = UILabel()
        lbl.text = text
        lbl.font = .second(ofSize: 12)
        lbl.textColor = .primary
        
        view.addSubview(iv)
        view.addSubview(lbl)
        
        iv.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(12)
        }
        
        lbl.snp.makeConstraints { make in
            make.left.equalTo(iv.snp.right).offset(6)
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        
        view.snp.makeConstraints { make in
            make.height.equalTo(26)
        }
        
        return view
    }
}
