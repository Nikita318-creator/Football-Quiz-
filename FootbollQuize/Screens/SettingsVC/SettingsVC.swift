import UIKit

class SettingsVC: UIViewController {

    // MARK: - UI Elements

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .textColor
        label.textAlignment = .center
        return label
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return button
    }()

    private lazy var termsButton: UIButton = {
        return createMenuButton(title: "Terms and Conditions", action: #selector(handleTerms))
    }()

    private lazy var privacyButton: UIButton = {
        return createMenuButton(title: "Privacy Policy", action: #selector(handlePrivacy))
    }()

    private let versionLabel: UILabel = {
        let label = UILabel()
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        label.text = "App Version \(appVersion) (\(buildNumber))"
        
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .textColor
        label.textAlignment = .center
        return label
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundMain
        setupLayout()
    }

    // MARK: - Layout

    private func setupLayout() {
        [titleLabel, backButton, termsButton, privacyButton, versionLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            termsButton.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30),
            termsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            termsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            termsButton.heightAnchor.constraint(equalToConstant: 60),

            privacyButton.topAnchor.constraint(equalTo: termsButton.bottomAnchor, constant: 12),
            privacyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            privacyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            privacyButton.heightAnchor.constraint(equalToConstant: 60),

            versionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    // MARK: - Helper Factory
    
    private func createMenuButton(title: String, action: Selector) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.isUserInteractionEnabled = false
        
        let arrowImage = UIImageView(image: UIImage(named: "arrowRight"))
        arrowImage.tintColor = .textColor
        arrowImage.isUserInteractionEnabled = false
        
        button.addSubview(label)
        button.addSubview(arrowImage)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            
            arrowImage.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -20),
            arrowImage.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        button.addTarget(self, action: action, for: .touchUpInside)
        
        button.addTarget(self, action: #selector(animateDown), for: .touchDown)
        button.addTarget(self, action: #selector(animateUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        
        return button
    }

    // MARK: - Actions

    @objc private func handleBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func handleTerms() {
        openUrl("https://google.com") // test111
    }

    @objc private func handlePrivacy() {
        openUrl("https://google.com") // test111
    }
    
    private func openUrl(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    // MARK: - Button Animations
    
    @objc private func animateDown(sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
            sender.backgroundColor = UIColor(white: 0.95, alpha: 1)
        }
    }
    
    @objc private func animateUp(sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
            sender.backgroundColor = .white
        }
    }
}
