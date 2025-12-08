import UIKit
import WebKit
import Foundation

final class MainPhotoImageVC: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    private let imageString: String
    private var mainImageView: WKWebView!
    
    init(imageString: String) {
        self.imageString = imageString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        let config = WKWebViewConfiguration()
        
        let configDataStr = "Version/17.2 Mobile/15E148 Safari/604.1"
        config.applicationNameForUserAgent = configDataStr
        
        config.websiteDataStore = .default()
        
        mainImageView = WKWebView(frame: .zero, configuration: config)
        mainImageView.uiDelegate = self
        mainImageView.navigationDelegate = self
        view = mainImageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: imageString) {
            let request = URLRequest(url: url)
            mainImageView.load(request)
        }
    }
}
