//
//  ViewController.swift
//  youtube-dayonebuile
//
//  Created by apple on 2/8/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ModelDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let model = Model()
    var videos = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Set itself as the data source and delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        /**
            Model.getVideos(): Duoc goi o viewDidLoad, do la 1 cuoc goi API.
         Khi no call de lay video, no se mong doi duoc tra ve 1 ds video.
         
         Problem: Khi thuc hien 1 cuoc goi mang (network call) se khong bao gio quay lai, hoac no co the mat nhieu thoi gian,
         trong khi tai videos tu API, ViewController bi treo tren dong nay cho cho ket qua quay lai, dan de bi treo (hang) hoac tham chi crash app.
         
         Solution: Thuc hien o background thread network call, va thong bao den ViewController khi du lieu duoc chuyen tro lai Main Thread de ve view.
         */
        
        // Set itself as the delegate of the model (Đặt chính nó làm đại biểu của mô hình)
        model.delegate = self
        
        model.getVideos()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Phuong thuc nay se auto call, khi 1 phan tach xay ra voi ViewController, nguoi dung dang chuyen den DetailViewController.
        
        // Confirm that a video was selected
        guard tableView.indexPathForSelectedRow != nil else {
            return
        }
        
        // Get a reference to the video that was tapped on
        let selectedVideo = videos[tableView.indexPathForSelectedRow!.row]
        
        // Get a reference to the DetailViewController
        let detailVC = segue.destination as! DetailViewController
        
        // Set the video property of the DetailViewController
        detailVC.video = selectedVideo
    }

    // I, TableView hoat dong dua tren 2 yeu to:
    // 1, ai do phai tu dat minh lam nguon dl (dataSource)
    // 2, ai do phai co phuong thuc cu the ma TableView se goi khi can dl de hien thi
    
    // ai do tro thanh DataSource se tuan thu theo protocol (Conforms to Protocol)
    // khi implement protocol chung ta phai tuan thu theo cac phuong thuc cua protocol do
    
    // II, Bat su kien nguoi dung tuong tac se tuan thu theo (conform protocol) (delegate: uy quyen)
    // ma o do cung cap cac phuong thuc ho tro envent nguoi dung tung tac.
    
    // MARK: - Model Delegate Methods
    func videosFetched(_ video: [Video]) {
        // Set the returned videos to our videos property
        self.videos = video
        
        // Refresh Table View
        tableView.reloadData()
    }
    
    // MARK: - TableView Methods
    // cho phep hien thi bao nhieu items (rows)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    // neu row == 0, no se khong bao gio goi phuong thuc nay [tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell]
    // moi lan goi den phuong thuc nay se la 1 lan ve 1 row
    // no su dung o nguyen mau de the hien cho tung row (giong view placeHolder)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Phuong thuc [dequeueReusableCell] cho phep co the tai su dung, bao gom
        // [withIdentifier]: dinh danh cua o nguyen mau
        // [indexPath]: duong dan chi muc
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VIDEO_CELL_ID, for: indexPath) as! VideoTableViewCell
        
        // Configure the cell with the data
        let video = videos[indexPath.row]
        
        cell.setCell(video)
        
        // Do data vao tung row, cu the la title
        //let title = video.title
        //cell.textLabel?.text = title
        
        // Return the cell
        return cell
    }
    
    // MARK: - Conform Delegate Protocols
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

