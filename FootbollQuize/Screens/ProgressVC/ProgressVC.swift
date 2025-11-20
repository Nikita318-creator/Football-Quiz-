import UIKit
import SnapKit

class ProgressVC: UIViewController {
    
    // MARK: - Data
    private var calendarDates: [CalendarDate] = []
    private var trainings: [TrainingSession] = []
    
    // MARK: - UI Components
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // --- TOP SECTION ---
    private let topContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        return view
    }()
    
    private let progressImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "progressImage1"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let rankTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "CAPTAIN"
        label.font = .systemFont(ofSize: 28, weight: .heavy)
        label.textColor = .primary
        label.textAlignment = .center
        return label
    }()
    
    private let rankSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Complete 50 trainings"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .secondTextColor
        label.textAlignment = .center
        return label
    }()
    
    private let scoreBadgeView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundMain
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "30 / 50"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .primary
        return label
    }()
    
    private let customProgressBar: UIProgressView = {
        let pv = UIProgressView(progressViewStyle: .bar)
        pv.trackTintColor = .backgroundMain
        pv.progressTintColor = .activeColor
        pv.layer.cornerRadius = 8
        pv.clipsToBounds = true
        pv.progress = 0.6
        return pv
    }()
    
    private let nextRankLabel: UILabel = {
        let label = UILabel()
        label.text = "Next Rank:"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .secondTextColor
        return label
    }()
    
    private let legendBadge: UILabel = {
        let label = UILabel()
        label.text = "Legend"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white // Или .primary в зависимости от точности
        label.backgroundColor = UIColor(hex: "#D4AF37") // Золотой цвет (или используй .activeColor если строго по палитре)
        // Если строго по палитре:
        // label.backgroundColor = .activeColor
        // label.textColor = .primary
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()

    // --- DATE COLLECTION ---
    private lazy var dateCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 50, height: 70)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.register(DateCell.self, forCellWithReuseIdentifier: DateCell.reuseID)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    // --- EMPTY STATE VIEW ---
    private let emptyStateContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isHidden = true
        return view
    }()
    
    private let emptyStateIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "emptyProgress")
        return view
    }()
    
    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "You haven’t trained today"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondTextColor
        label.textAlignment = .center
        return label
    }()
    
    // --- TRAINING LIST ---
    private lazy var trainingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        cv.register(TrainingListCell.self, forCellWithReuseIdentifier: TrainingListCell.reuseID)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
        updateState() // Проверяем состояние при загрузке
        
        DispatchQueue.main.async {
            let lastIndexPath = IndexPath(item: self.calendarDates.count - 1, section: 0)
            self.dateCollectionView.scrollToItem(at: lastIndexPath, at: .centeredHorizontally, animated: false)
        }
    }
    
    // MARK: - Setup
    
    private func setupData() {
        let calendar = Calendar.current
        let today = Date()
        
        for i in (0..<30).reversed() {
            if let date = calendar.date(byAdding: .day, value: -i, to: today) {
                let isToday = i == 0
                calendarDates.append(CalendarDate(date: date, isSelected: isToday))
            }
        }
        
        // Изначально заполняем данными
        trainings = [
            TrainingSession(title: "Short pass training", duration: 5, mood: "Fine", fatigue: 3),
            TrainingSession(title: "Short pass training", duration: 5, mood: "Good", fatigue: 2),
            TrainingSession(title: "Long pass practice", duration: 10, mood: "Tired", fatigue: 4),
            TrainingSession(title: "Dribbling drill", duration: 15, mood: "Fine", fatigue: 3)
        ]
    }
    
    private func setupUI() {
        view.backgroundColor = .backgroundMain
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            // Важно: make.height не фиксируем, он растянется контентом
        }
        
        // --- Top Section Layout ---
        contentView.addSubview(topContainerView)
        topContainerView.addSubview(progressImageView)
        topContainerView.addSubview(rankTitleLabel)
        topContainerView.addSubview(rankSubtitleLabel)
        topContainerView.addSubview(scoreBadgeView)
        scoreBadgeView.addSubview(scoreLabel)
        topContainerView.addSubview(customProgressBar)
        topContainerView.addSubview(nextRankLabel)
        topContainerView.addSubview(legendBadge)
        
        topContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        progressImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(150)
        }
        
        rankTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(progressImageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        
        rankSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(rankTitleLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
        
        scoreBadgeView.snp.makeConstraints { make in
            make.top.equalTo(rankSubtitleLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(26)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(12)
        }
        
        customProgressBar.snp.makeConstraints { make in
            make.top.equalTo(scoreBadgeView.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(16)
        }
        
        nextRankLabel.snp.makeConstraints { make in
            make.top.equalTo(customProgressBar.snp.bottom).offset(16)
            make.left.equalTo(customProgressBar)
            make.bottom.equalToSuperview().offset(-24)
        }
        
        legendBadge.snp.makeConstraints { make in
            make.centerY.equalTo(nextRankLabel)
            make.right.equalTo(customProgressBar)
            make.width.equalTo(70)
            make.height.equalTo(22)
        }
        
        // --- Calendar Layout ---
        contentView.addSubview(dateCollectionView)
        dateCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topContainerView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
        
        // --- Empty State Layout ---
        contentView.addSubview(emptyStateContainer)
        emptyStateContainer.addSubview(emptyStateIcon)
        emptyStateContainer.addSubview(emptyStateLabel)
        
        emptyStateContainer.snp.makeConstraints { make in
            make.top.equalTo(dateCollectionView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-40)
        }

        emptyStateIcon.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        emptyStateLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyStateIcon.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
        // --- Training List Layout ---
        contentView.addSubview(trainingCollectionView)
        trainingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(dateCollectionView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(400)
        }
    }
    
    private func updateState() {
        if trainings.isEmpty {
            // Показываем Empty State
            trainingCollectionView.isHidden = true
            emptyStateContainer.isHidden = false
            
            // Сбрасываем констрейнт высоты коллекции, чтобы скролл работал корректно
            trainingCollectionView.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
        } else {
            // Показываем список
            trainingCollectionView.isHidden = false
            emptyStateContainer.isHidden = true
            updateTrainingsHeight()
        }
    }
    
    private func updateTrainingsHeight() {
        guard !trainings.isEmpty else { return }
        let height = CGFloat(trainings.count) * 122.0 // Высота ячейки + отступ
        trainingCollectionView.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
        view.layoutIfNeeded()
    }
}

// MARK: - CollectionView Delegate & DataSource
extension ProgressVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dateCollectionView {
            return calendarDates.count
        } else {
            return trainings.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == dateCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCell.reuseID, for: indexPath) as! DateCell
            cell.configure(with: calendarDates[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrainingListCell.reuseID, for: indexPath) as! TrainingListCell
            cell.configure(with: trainings[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == dateCollectionView {
            // 1. Update Selection UI
            for i in 0..<calendarDates.count {
                calendarDates[i].isSelected = false
            }
            calendarDates[indexPath.item].isSelected = true
            dateCollectionView.reloadData()
            
            // 2. MOCK LOGIC FOR TESTING EMPTY STATE
            // Если выбрали последний элемент (сегодня) - показываем данные
            // Если любой другой день - показываем пустой экран
            if indexPath.item == calendarDates.count - 1 {
                trainings = [
                    TrainingSession(title: "Short pass training", duration: 5, mood: "Fine", fatigue: 3),
                    TrainingSession(title: "Short pass training", duration: 5, mood: "Good", fatigue: 2),
                    TrainingSession(title: "Long pass practice", duration: 10, mood: "Tired", fatigue: 4),
                    TrainingSession(title: "Dribbling drill", duration: 15, mood: "Fine", fatigue: 3)
                ]
            } else {
                trainings = [] // Очищаем для теста
            }
            
            // 3. Update UI Logic
            trainingCollectionView.reloadData()
            updateState()
        }
    }
    
    // Size settings
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == dateCollectionView {
            return CGSize(width: 50, height: 70)
        } else {
            let width = collectionView.frame.width
            return CGSize(width: width, height: 110)
        }
    }
    
    // Insets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == dateCollectionView {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
        return .zero
    }
}
