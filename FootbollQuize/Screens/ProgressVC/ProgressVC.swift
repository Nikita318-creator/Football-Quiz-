import UIKit
import SnapKit

class ProgressVC: UIViewController {
    
    // MARK: - Data
    private var calendarDates: [CalendarDate] = []
    private var trainings: [TrainingSession] = []
    private let viewModel = ProgressViewModel()
    
    // MARK: - UI Components
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let topContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        return view
    }()
    
    private lazy var progressImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: viewModel.model.imageName))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private lazy var rankTitleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.model.title
        label.font = .main(ofSize: 28)
        label.textColor = .primary
        label.textAlignment = .center
        return label
    }()
    
    private lazy var rankSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.model.subtitle
        label.font = .second(ofSize: 15)
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
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "\(viewModel.model.currentProgress) / \(viewModel.model.fullProgress)"
        label.font = .main(ofSize: 14)
        label.textColor = .primary
        return label
    }()
    
    private let customProgressBar: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar)
        progress.progressTintColor = .activeColor
        progress.trackTintColor = .primary
        progress.progress = 0.1 
        progress.layer.cornerRadius = 7.5
        progress.layer.masksToBounds = true
        progress.layer.borderWidth = 3
        progress.layer.borderColor = UIColor.primary.cgColor
        return progress
    }()
    
    private let nextRankLabel: UILabel = {
        let label = UILabel()
        label.text = "Next Rank:"
        label.font = .second(ofSize: 15)
        label.textColor = .secondTextColor
        return label
    }()
    
    private lazy var legendBadge: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: viewModel.model.nextRankImageName)
        return imageView
    }()

    private lazy var dateCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 64, height: 64)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.register(DateCell.self, forCellWithReuseIdentifier: DateCell.reuseID)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
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
        label.text = "You haven’t trained on that day"
        label.font = .second(ofSize: 16)
        label.textColor = .secondTextColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var trainingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 4
        
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
        updateState()
        
        DispatchQueue.main.async {
            let lastIndexPath = IndexPath(item: self.calendarDates.count - 1, section: 0)
            self.dateCollectionView.scrollToItem(at: lastIndexPath, at: .centeredHorizontally, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.updateState()
        
        rankTitleLabel.text = viewModel.model.title
        rankSubtitleLabel.text = viewModel.model.subtitle
        progressImageView.image = UIImage(named: viewModel.model.imageName)
        
        let current = viewModel.model.currentProgress
        let full = viewModel.model.fullProgress
        scoreLabel.text = "\(current) / \(full)"
        
        let progressRatio = full > 0 ? Float(current) / Float(full) : 0.0
        customProgressBar.setProgress(progressRatio, animated: true)
        
        legendBadge.image = UIImage(named: viewModel.model.nextRankImageName)
        setupData()
        
        dateCollectionView.reloadData()
        trainingCollectionView.reloadData()
        updateState()
    }
    
    // MARK: - Setup
    
    private func setupData() {
        let calendar = Calendar.current
        let today = Date()
        
        calendarDates = []
        
        for i in (0..<30).reversed() {
            if let date = calendar.date(byAdding: .day, value: -i, to: today) {
                let isToday = i == 0
                calendarDates.append(CalendarDate(date: date, isSelected: isToday))
            }
        }
        
        trainings = viewModel.progressRecords.map {
            TrainingSession(title: "Short pass training", duration: $0.time, mood: $0.mood, fatigue: $0.stars)
        }
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
            make.left.right.equalToSuperview().inset(8)
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
            make.height.equalTo(15)
        }
        
        nextRankLabel.snp.makeConstraints { make in
            make.top.equalTo(customProgressBar.snp.bottom).offset(16)
            make.left.equalTo(customProgressBar)
            make.bottom.equalToSuperview().offset(-24)
        }
        
        legendBadge.snp.makeConstraints { make in
            make.centerY.equalTo(nextRankLabel)
            make.right.equalTo(customProgressBar)
        }
        
        contentView.addSubview(dateCollectionView)
        dateCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topContainerView.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
        
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
            make.top.equalTo(dateCollectionView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(400)
        }
    }
    
    private func updateState() {
        if trainings.isEmpty {
            trainingCollectionView.isHidden = true
            emptyStateContainer.isHidden = false
            
            trainingCollectionView.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
        } else {
            trainingCollectionView.isHidden = false
            emptyStateContainer.isHidden = true
            updateTrainingsHeight()
        }
    }
    
    private func updateTrainingsHeight() {
        guard !trainings.isEmpty else { return }
        let height = CGFloat(trainings.count) * 132.0
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
            for i in 0..<calendarDates.count {
                calendarDates[i].isSelected = false
            }
            calendarDates[indexPath.item].isSelected = true
            dateCollectionView.reloadData()
            
            if indexPath.item == calendarDates.count - 1 {
                trainings = viewModel.progressRecords.map {
                    TrainingSession(title: "Short pass training", duration: $0.time, mood: $0.mood, fatigue: $0.stars)
                }
            } else {
                trainings = []
            }
            
            trainingCollectionView.reloadData()
            updateState()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == dateCollectionView {
            return CGSize(width: 64, height: 64)
        } else {
            let width = collectionView.frame.width
            return CGSize(width: width, height: 120)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == dateCollectionView {
            return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        }
        return .zero
    }
}
