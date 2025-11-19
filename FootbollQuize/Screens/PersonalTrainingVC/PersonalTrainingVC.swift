import UIKit
import SnapKit

// MARK: - PersonalTrainingVC

class PersonalTrainingVC: UIViewController {

    // MARK: - Data
    // Используем ту же структуру данных, что и на прошлом экране
    private let trainingItems: [TrainingItem] = [
        TrainingItem(title: "Short pass training", durationMinutes: 3),
        TrainingItem(title: "Short pass training", durationMinutes: 5),
        TrainingItem(title: "Short pass training", durationMinutes: 4),
        TrainingItem(title: "Short pass training", durationMinutes: 12),
        TrainingItem(title: "Short pass training", durationMinutes: 8),
        TrainingItem(title: "Short pass training", durationMinutes: 10)
    ]

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
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        return label
    }()

    private let headerSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "New exercises!"
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .white
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
    
    // Кнопка "Назад" (опционально, если этот экран открывается через push)
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        // Используем системную стрелку или свою картинку из ассетов
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        let image = UIImage(systemName: "chevron.left", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return button
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
        
        // Картинка прибита к верху (включая зону статус бара)
        headerImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(280) // Высота как на дизайне (~30-35% экрана)
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
        
        // 3. Кнопка назад (поверх картинки)
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(40)
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
        let item = trainingItems[indexPath.row]
        print("Selected training: \(item.title)")
        // Логика перехода внутрь
    }
}
