import UIKit
import SnapKit

class SplashVC: UIViewController {

    var actionOnDismiss: (() -> Void)?

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 80, weight: .bold)
        imageView.image = UIImage(systemName: "sportscourt.fill", withConfiguration: config)
        imageView.tintColor = .white
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // test111
            self.actionOnDismiss?()
        }
    }
}
