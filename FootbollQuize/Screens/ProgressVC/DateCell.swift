import UIKit
import SnapKit

class DateCell: UICollectionViewCell {
    static let reuseID = "DateCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        return view
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(dayLabel)
        contentView.addSubview(monthLabel)
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(-2)
            make.centerX.equalToSuperview()
        }
        
        dayLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-5)
        }
    }
    
    func configure(with model: CalendarDate) {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "d"
        dayLabel.text = formatter.string(from: model.date)
        
        formatter.dateFormat = "MMM"
        monthLabel.text = formatter.string(from: model.date).uppercased()
        
        if model.isSelected {
            containerView.backgroundColor = .primary
            dayLabel.textColor = .activeColor
            monthLabel.textColor = .primary
            monthLabel.isHidden = true
            monthLabel.isHidden = false
            monthLabel.textColor = .primary
            
            monthLabel.textColor = .activeColor
            monthLabel.font = .systemFont(ofSize: 8, weight: .bold)
        } else {
            containerView.backgroundColor = .clear
            dayLabel.textColor = .secondTextColor
            
            monthLabel.textColor = .secondTextColor
            monthLabel.font = .systemFont(ofSize: 10, weight: .medium)
        }
    }
}
