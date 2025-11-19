import UIKit
import SnapKit

class QuizOptionView: UIView {
    
    // State
    var isSelectedOption: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    // UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .textColor
        return label
    }()
    
    private let radioCircle: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.backgroundColor = .clear
        return view
    }()
    
    private let radioCenterDot: UIView = {
        let view = UIView()
        view.backgroundColor = .primary
        view.layer.cornerRadius = 8
        view.isHidden = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 16
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.03
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        
        addSubview(titleLabel)
        addSubview(radioCircle)
        radioCircle.addSubview(radioCenterDot)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        radioCircle.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        radioCenterDot.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(16)
        }
    }
    
    func configure(text: String) {
        titleLabel.text = text
    }
    
    private func updateAppearance() {
        radioCenterDot.backgroundColor = .primary
        
        if isSelectedOption {
            
            // 1. Фон самой плашки темный
            backgroundColor = .primary
            
            // 2. Цвет текста - светло-зеленый
            titleLabel.textColor = .activeColor
            
            // 3. Внешнее кольцо
            radioCircle.layer.borderColor = UIColor.activeColor.cgColor
            radioCircle.layer.borderWidth = 1.5
            radioCircle.backgroundColor = .clear
            
            // 4. Внутренняя точка
            radioCenterDot.isHidden = false
            radioCenterDot.backgroundColor = .activeColor // Точка тоже зеленая
            
        } else {            
            backgroundColor = .white
            titleLabel.textColor = .textColor
            
            radioCircle.layer.borderColor = UIColor.systemGray4.cgColor
            radioCircle.layer.borderWidth = 1.5
            radioCircle.backgroundColor = .clear
            
            radioCenterDot.isHidden = true
        }
    }
    
    func updateAppearanceOnCheckTapped(_ isCorrect: Bool) {
        backgroundColor = isCorrect ? UIColor.success : UIColor.error
        titleLabel.textColor = .white
        radioCircle.layer.borderColor = UIColor.white.cgColor
        radioCenterDot.backgroundColor = .white
    }
}
