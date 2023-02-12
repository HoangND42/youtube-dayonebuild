//
//  DetailViewController.swift
//  youtube-dayonebuile
//
//  Created by apple on 2/12/23.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    // MARK: - Reference Interface View Controller
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var webview: WKWebView!
    
    @IBOutlet weak var textView: UITextView!
    
    // MARK: - Properties
    var video: Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Warning: Hien thi noi dung Webview o [viewDidLoad] gay ra 1 so van de, su dung [viewWillAppear] de load WebView no se chay sau viewDidLoad
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Clear the fields
        titleLabel.text = ""
        dateLabel.text = ""
        textView.text = ""
        
        // Check if there a video
        guard video != nil else {
            return
        }
        
        // Create the embed URL
        let embedUrlString = Constants.YT_EMBED_URL + video!.videoId
        
        // Load it into the Webview
        let url = URL(string: embedUrlString)
        let request = URLRequest(url: url!)
        webview.load(request)
        
        // Set the title
        titleLabel.text = video!.title
        
        // Set the date
        let df = DateFormatter()
        df.dateFormat = "MM-dd-yyyy HH:mm"
        dateLabel.text = df.string(from: video!.published)
        
        // Set the description
        textView.text = video!.description
    }
    
}
