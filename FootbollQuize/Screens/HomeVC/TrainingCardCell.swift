import UIKit
import SnapKit

class TrainingCardCell: UICollectionViewCell {
    
    static let reuseID = "TrainingCardCell"
    
    private let titleLabel = UILabel()
    private let durationLabel = UILabel()
    private let arrowImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.masksToBounds = false
        
        titleLabel.textColor = .textColor
        titleLabel.font = .second(ofSize: 18)
        titleLabel.numberOfLines = 0
        
        durationLabel.textColor = .textColor
        durationLabel.font = .main(ofSize: 32)
        
        let minutesTextLabel = UILabel()
        minutesTextLabel.text = "Min"
        minutesTextLabel.textColor = .secondTextColor
        minutesTextLabel.font = .second(ofSize: 15)
        
        arrowImageView.image = UIImage(named: "arrowTopRight")
        arrowImageView.tintColor = .primary
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(durationLabel)
        contentView.addSubview(minutesTextLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(arrowImageView.snp.left).offset(-10)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(38)
        }
        
        durationLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        minutesTextLabel.snp.makeConstraints { make in
            make.left.equalTo(durationLabel.snp.right).offset(2)
            make.bottom.equalToSuperview().offset(-26)
        }
    }
    
    func configure(with item: TrainingItem) {
        titleLabel.text = item.title
        durationLabel.text = "\(item.durationMinutes)"
    }
}

