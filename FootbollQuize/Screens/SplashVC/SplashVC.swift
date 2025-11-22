import UIKit
import SnapKit

class SplashVC: UIViewController {

    var actionOnDismiss: (() -> Void)?

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "") //UIImage(named: "SplashIcon")
        imageView.contentMode = .scaleAspectFit
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
            make.height.width.equalTo(200)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.actionOnDismiss?()
        }
    }
}
