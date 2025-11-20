import UIKit
import SnapKit

class DateCell: UICollectionViewCell {
    static let reuseID = "DateCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25 // Половина от размера (50x50)
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
        
        dayLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        monthLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configure(with model: CalendarDate) {
        let formatter = DateFormatter()
        
        // Day
        formatter.dateFormat = "d"
        dayLabel.text = formatter.string(from: model.date)
        
        // Month
        formatter.dateFormat = "MMM"
        monthLabel.text = formatter.string(from: model.date).uppercased()
        
        if model.isSelected {
            containerView.backgroundColor = .primary
            dayLabel.textColor = .activeColor
            monthLabel.textColor = .primary
            monthLabel.isHidden = true // На скрине у выбранного элемента нет месяца снизу, он внутри круга?
            // Впрочем, на скрине "12 SEP" - SEP внутри круга. Давай поправим layout под скрин.
            
            // Re-layout for selected state (Day centered, Month below inside circle)
             // Упростим: меняем цвета
             monthLabel.isHidden = false
             monthLabel.textColor = .primary // Текст месяца под кругом не виден или меняет цвет?
             // На скрине у неактивных: Число (серый), Месяц (серый) снизу.
             // У активного: Синий круг, Желтое число, Месяц внутри? На скрине "12 SEP" внутри синего круга.
             
             // Модификация под скрин:
             monthLabel.snp.remakeConstraints { make in
                 make.top.equalTo(dayLabel.snp.bottom).offset(-2)
                 make.centerX.equalToSuperview()
             }
             monthLabel.textColor = .activeColor
             monthLabel.font = .systemFont(ofSize: 8, weight: .bold)
             dayLabel.snp.remakeConstraints { make in
                 make.centerX.equalToSuperview()
                 make.centerY.equalToSuperview().offset(-5)
             }
             
        } else {
            containerView.backgroundColor = .clear
            dayLabel.textColor = .secondTextColor
            
            // Reset Layout
            monthLabel.snp.remakeConstraints { make in
                make.top.equalTo(containerView.snp.bottom).offset(4)
                make.centerX.equalToSuperview()
            }
            dayLabel.snp.remakeConstraints { make in
                 make.center.equalToSuperview()
            }
            monthLabel.textColor = .secondTextColor
            monthLabel.font = .systemFont(ofSize: 10, weight: .medium)
        }
    }
}
