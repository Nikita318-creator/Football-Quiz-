import UIKit
import SnapKit

class PersonalTrainingVC: UIViewController {

    // MARK: - Properties
    
    private var collectionView: UICollectionView!
    
    private let skills: [TrainingSkill] = [
        TrainingSkill(name: "Passing", iconName: "arrow.left.arrow.right"),
        TrainingSkill(name: "Shooting", iconName: "target"),
        TrainingSkill(name: "Dribbling", iconName: "figure.soccer"),
        TrainingSkill(name: "Coordination", iconName: "figure.coordination"),
        TrainingSkill(name: "Defense Work", iconName: "shield"),
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        navigationItem.title = "Training & Development"
        view.backgroundColor = .systemGroupedBackground
    }
    
    // MARK: - Setup
    
    private func setupCollectionView() {
        // Создание композиционного (Compositional) Layout
        let layout = createGridLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SkillCell.self, forCellWithReuseIdentifier: SkillCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        
        view.addSubview(collectionView)
        
        // Констрейнты через SnapKit
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        }
    }
    
    // MARK: - Layout Configuration
    
    private func createGridLayout() -> UICollectionViewLayout {
        // Элемент (Item): Занимает 1/2 ширины группы
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        // Группа (Group): Горизонтальная, содержит 2 элемента
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.45)) // Высота = почти половине ширины экрана
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Секция (Section)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: - UICollectionViewDataSource

extension PersonalTrainingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SkillCell.reuseIdentifier, for: indexPath) as? SkillCell else {
            fatalError("Unable to dequeue SkillCell")
        }
        let skill = skills[indexPath.item]
        cell.configure(with: skill)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension PersonalTrainingVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let skill = skills[indexPath.item]
        print("Selected skill: \(skill.name)")
        
        // Имитация пуша на экран с деталями тренировки
        let detailVC = TrainingDetailVC()
        detailVC.title = skill.name
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - TrainingDetailVC (Заглушка для экрана деталей)

class TrainingDetailVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .label
        
        // Пример контента:
        label.text = """
        \(title ?? "Skill Name")
        
        ---
        
        Description: Focus on short, sharp passes and receiving the ball with control.
        
        Goals: Improve short-range passing accuracy and first touch.
        
        Safety Guidelines: Always warm up before training. Stop immediately if you feel pain. Ensure adequate space around you to avoid collisions.
        """
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
    }
}
