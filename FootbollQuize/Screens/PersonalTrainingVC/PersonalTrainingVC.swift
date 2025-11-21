import UIKit
import SnapKit

class PersonalTrainingVC: UIViewController {

    // MARK: - Data
    private let trainingItems: [TrainingItem] = {
        var items: [TrainingItem] = []
        for _ in 0..<50 {
            let randomDuration = Int.random(in: 3...12)
            let item = TrainingItem(title: "Short pass training", durationMinutes: randomDuration)
            items.append(item)
        }
        return items
    }()

    // MARK: - UI Components
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        let startColor = UIColor(red: 0x0A/255.0, green: 0x23/255.0, blue: 0x4F/255.0, alpha: 0.0).cgColor
        let endColor = UIColor(red: 0x0A/255.0, green: 0x23/255.0, blue: 0x4F/255.0, alpha: 1.0).cgColor
        
        layer.colors = [startColor, endColor]
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        return layer
    }()

    private let headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "PersonaltrainingImage")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    private let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "TRAINING"
        label.font = .main(ofSize: 32)
        label.textColor = .white
        return label
    }()

    private let headerSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "New exercises!"
        label.font = .second(ofSize: 16)
        label.textColor = .white
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(TrainingCardCell.self, forCellWithReuseIdentifier: TrainingCardCell.reuseID)
        cv.dataSource = self
        cv.delegate = self
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .backgroundMain
        cv.contentInset = UIEdgeInsets(top: 8, left: 3, bottom: 20, right: 3)
        
        cv.layer.cornerRadius = 15
        cv.layer.masksToBounds = true
        
        return cv
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = headerImageView.bounds
    }

    // MARK: - Setup UI

    private func setupUI() {
        view.backgroundColor = .backgroundMain

        view.addSubview(headerImageView)
        
        headerImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(310)
        }
        
        headerImageView.layer.addSublayer(gradientLayer)

        headerImageView.addSubview(headerTitleLabel)
        headerImageView.addSubview(headerSubtitleLabel)
        
        headerTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(headerSubtitleLabel.snp.top)
        }
        
        headerSubtitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-46)
        }

        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerImageView.snp.bottom).offset(-30)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    // MARK: - Actions

    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension PersonalTrainingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trainingItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrainingCardCell.reuseID, for: indexPath) as? TrainingCardCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: trainingItems[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PersonalTrainingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.frame.width
        
        let padding: CGFloat = 7 * 2
        let spacing: CGFloat = 4
        
        let availableWidth = totalWidth - padding - spacing

        let cellWidth = availableWidth / 2
        return CGSize(width: cellWidth, height: cellWidth * 1.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let personalTrainingShortPassVC = PersonalTrainingShortPassVC()
        personalTrainingShortPassVC.hidesBottomBarWhenPushed = true
        personalTrainingShortPassVC.currentIndex = indexPath.row
        personalTrainingShortPassVC.durationMinutes = trainingItems[indexPath.row].durationMinutes
        navigationController?.pushViewController(personalTrainingShortPassVC, animated: true)
    }
}
