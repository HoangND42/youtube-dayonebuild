//
//  VideoTableViewCell.swift
//  youtube-dayonebuile
//
//  Created by apple on 2/12/23.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var video: Video?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ v: Video) {
        
        self.video = v
        
        // Ensure (dam bao) that we have a video
        guard self.video != nil else {
            return
        }
        
        // Set the title and date label
        self.titleLabel.text = video!.title
        
        let df = DateFormatter()
        df.dateFormat = "MM-dd-yyyy HH:mm"
        self.dateLabel.text = df.string(from: video!.published)
        
        // Tai xuong hinh anh voi URL string
        // Set the thumbnail
        guard video!.thumbnail != "" else {
            return
        }
        
        // Check cache before downloading data
        if let cacheData = CacheManager.getVideoCache(self.video!.thumbnail) {
            
            // Logging cache data
            dump("cache data image: \(CacheManager.cache)")
            
            // Set the thumbnail image
            self.thumbnailImageView.image = UIImage(data: cacheData)
            return
        }
        
        // Download the thumbnail data
        
        // Create a URL object
        let url = URL(string: self.video!.thumbnail)
        
        // Chia se hinh anh duoi dang phien
        // Get the shared URLSession object
        let session = URLSession.shared
        
        // Create a data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check sussess data task
            if error == nil && data != nil {
                
                // Save the data in the cache
                CacheManager.setVideoCache(url!.absoluteString, data)
                
                /**
                    Kiem tra URL tai xuong co khop voi URL thumbnail cua video,
                 Boi vi: TableView se duoc su dung lai, khi ban cuon khoi che do xem, no se duoc tai che va su dung lai.
                 
                 Problem: Co 1 tinh huong xay ra, khi du lieu cho hinh anh tai xuong, sau do O bi cuon ra khoi che do xem, o do co
                 the da tai che cho 1 video khac va neu do la truong hop khi du lieu tra ve cho video cu, ban khong muon thumbnail cho video cu ma no dang hien thi.
                 
                 Solution: Khi du lieu quay tro lai hay kiem tra noi dung ban dang tai xuong co thuc su danh cho video ban dang co gang hien thi khong.
                 
                 url!.absoluteString != self.video!.thumbnail -> NOT MATCHES
                 */
                
                // Check that the downloaded url matches the video thumbnail url that this cell is currently set to display
                if url!.absoluteString != self.video!.thumbnail {
                    
                    // Video cell has been recycled for another video and no longer matches the thumbnail that was downloaded
                    // Ô video đã được tái chế cho một video khác và không còn khớp với hình thu nhỏ đã được tải xuống
                    return
                }
                
                // Create the image object
                let image = UIImage(data: data!)
                
                // Set the image view
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
                
                dump("Downloaded image")
            }
            
        }
        
        // Kick off data task
        dataTask.resume()
    }

}
