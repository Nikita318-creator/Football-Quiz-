import UIKit
import SnapKit

class QuizSessionVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let exampleQuestion = QuizQuestion(
            text: "How many players are in the starting line-up of a football team?",
            options: ["9", "10", "11", "12"]
        )
        
        let questionLabel = UILabel()
        questionLabel.text = exampleQuestion.text
        questionLabel.font = .systemFont(ofSize: 24, weight: .bold)
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        
        let optionsStack = UIStackView()
        optionsStack.axis = .vertical
        optionsStack.spacing = 15
        
        for (index, option) in exampleQuestion.options.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle("\(index + 1). \(option)", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
            button.backgroundColor = .systemFill
            button.setTitleColor(.label, for: .normal)
            button.layer.cornerRadius = 10
            button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 15, bottom: 12, right: 15)
            button.snp.makeConstraints { $0.height.equalTo(50) }
            optionsStack.addArrangedSubview(button)
        }
        
        let totalStack = UIStackView(arrangedSubviews: [questionLabel, optionsStack])
        totalStack.axis = .vertical
        totalStack.spacing = 50
        
        view.addSubview(totalStack)
        totalStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.right.equalToSuperview().inset(30)
        }
    }
}
