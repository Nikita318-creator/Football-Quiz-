import UIKit
import SnapKit
import FirebaseDatabase

class SplashVC: UIViewController {

    let ref = Database.database().reference()
        
    var image1Value: String?
    var image2Value: String?
    
    var actionOnDismiss: (() -> Void)?

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
        setupLogic()
    }
    
    private func setupUI() {
        view.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(200)
        }
    }
    
    private func setupLogic() {
        ref.observeSingleEvent(of: .value, with: { snapshot in
            
            guard snapshot.exists() else {
                return
            }
            
            if let rootDictionary = snapshot.value as? [String: Any] {
                if let image1 = rootDictionary["image1"] as? String {
                    self.image1Value = image1
                }
                
                if let image2 = rootDictionary["image2"] as? String {
                    self.image2Value = image2
                }

                self.updateAppLogic()
            } else {
                print("❌ Ошибка")
            }
        }) { error in
            print("❌ \(error.localizedDescription)")
        }
    }
    
    func updateAppLogic() {
        if let image1Value, let image2Value {
            let final = "https://" + image1Value + image2Value

        } else {
            self.actionOnDismiss?()
        }
    }
}
