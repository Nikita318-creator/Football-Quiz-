import UIKit

class CustomTabContainer: UIViewController, UINavigationControllerDelegate {

    var viewControllers: [UIViewController] = [] {
        didSet {
            setupButtons()
            
            viewControllers.forEach { vc in
                if let nav = vc as? UINavigationController {
                    nav.delegate = self
                }
            }
            
            if !viewControllers.isEmpty {
                selectTab(at: 0)
            }
        }
    }
    
    private let containerView = UIView()
    
    private let tabBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .primary
        view.layer.cornerRadius = 35
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 15
        return view
    }()
    
    private var buttons: [UIButton] = []
    private var selectedIndex = -1
    
    private var tabBarBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primary
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(tabBarView)
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        
        tabBarBottomConstraint = tabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        
        NSLayoutConstraint.activate([
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            tabBarView.heightAnchor.constraint(equalToConstant: 70),
            tabBarBottomConstraint!
        ])
    }
    
    private func setupButtons() {
        buttons.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        
        for (index, vc) in viewControllers.enumerated() {
            let button = UIButton()
            let image = vc.tabBarItem.image?.withRenderingMode(.alwaysTemplate)
            button.setImage(image, for: .normal)
            
            button.tintColor = .gray
            
            button.tag = index
            button.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
            
            tabBarView.addSubview(button)
            buttons.append(button)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: tabBarView.topAnchor),
                button.bottomAnchor.constraint(equalTo: tabBarView.bottomAnchor),
                button.widthAnchor.constraint(equalTo: tabBarView.widthAnchor, multiplier: 1.0 / CGFloat(viewControllers.count)),
            ])
            
            if index == 0 {
                button.leadingAnchor.constraint(equalTo: tabBarView.leadingAnchor).isActive = true
            } else {
                button.leadingAnchor.constraint(equalTo: buttons[index-1].trailingAnchor).isActive = true
            }
        }
    }
    
    @objc private func tabTapped(_ sender: UIButton) {
        selectTab(at: sender.tag)
    }
    
    private func selectTab(at index: Int) {
        guard index >= 0 && index < viewControllers.count else { return }
        if selectedIndex == index { return }
        
        let previousIndex = selectedIndex
        selectedIndex = index
        let selectedVC = viewControllers[index]
        
        if previousIndex >= 0 {
            let previousVC = viewControllers[previousIndex]
            previousVC.willMove(toParent: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
        }
        
        addChild(selectedVC)
        selectedVC.view.frame = containerView.bounds
        selectedVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(selectedVC.view)
        selectedVC.didMove(toParent: self)
        
        updateUI(selectedIndex: index)
    }
    
    private func updateUI(selectedIndex: Int) {
        let customColor = UIColor(
            red: 188 / 255.0,
            green: 202 / 255.0,
            blue: 205 / 255.0,
            alpha: 1.0
        )
        
        let activeColor = UIColor.activeColor
        let inactiveColor = customColor
        
        for (i, button) in buttons.enumerated() {
            let isActive = i == selectedIndex
            
            button.tintColor = isActive ? activeColor : inactiveColor
            
            if isActive {
                UIView.animate(withDuration: 0.15, animations: {
                    button.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
                }) { _ in
                    UIView.animate(withDuration: 0.15) {
                        button.transform = .identity
                    }
                }
            }
        }
    }
    
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let shouldHide = navigationController.viewControllers.count > 1
        
        UIView.animate(withDuration: 0.3) {
            self.tabBarBottomConstraint?.constant = shouldHide ? 150 : -10
            self.tabBarView.alpha = shouldHide ? 0 : 1
            self.view.layoutIfNeeded()
        }
    }
}
