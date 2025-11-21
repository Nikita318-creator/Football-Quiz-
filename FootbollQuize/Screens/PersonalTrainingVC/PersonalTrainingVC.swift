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

    // 1. Header Image View
    private let headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "PersonaltrainingImage")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        iv.addSubview(overlay)
        overlay.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return iv
    }()

    // 2. Header Labels
    private let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "TRAINING"
        label.font = .main(ofSize: 32)
        label.textColor = .white
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 1.0
        label.layer.shadowRadius = 4
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.masksToBounds = false
        
        return label
    }()

    private let headerSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "New exercises!"
        label.font = .second(ofSize: 17)
        label.textColor = .white
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 1.0
        label.layer.shadowRadius = 4
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.masksToBounds = false
        
        return label
    }()

    // 3. Collection View (Grid Layout)
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 4 // Отступ между строками
        layout.minimumInteritemSpacing = 4 // Отступ между столбцами
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // Используем уже существующую ячейку
        cv.register(TrainingCardCell.self, forCellWithReuseIdentifier: TrainingCardCell.reuseID)
        cv.dataSource = self
        cv.delegate = self
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .backgroundMain
        // Отступ контента снизу, чтобы не прилипало к краю экрана
        cv.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        
        cv.layer.cornerRadius = 15
        cv.layer.masksToBounds = true
        
        return cv
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // Скрываем NavigationBar, так как у нас свой кастомный хедер с картинкой
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // MARK: - Setup UI

    private func setupUI() {
        view.backgroundColor = .backgroundMain

        // 1. Добавляем Header Image
        view.addSubview(headerImageView)
        
        headerImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(310)
        }
        
        // 2. Добавляем тексты на картинку
        headerImageView.addSubview(headerTitleLabel)
        headerImageView.addSubview(headerSubtitleLabel)
        
        headerTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(headerSubtitleLabel.snp.top).offset(-4)
        }
        
        headerSubtitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-50) // Отступ от низа картинки
        }

        // 4. Добавляем Collection View
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
        
        let padding: CGFloat = 4 * 2
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
        navigationController?.pushViewController(personalTrainingShortPassVC, animated: true)
    }
}
