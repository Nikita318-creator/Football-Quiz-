import UIKit
import WebKit
import SnapKit

final class MainPhotoImageVC: UIViewController, WKUIDelegate {
    
    private let urlString: String
    
    private var mainImageView: WKWebView!
    
    init(urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        mainImageView = WKWebView(frame: .zero, configuration: webConfiguration)
        mainImageView.uiDelegate = self
        view = mainImageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            mainImageView.load(request)
        }
    }
}
