//
//  MediaList.swift
//  Media Finder
//
//  Created by Hossam on 8/22/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit
import Foundation
import AVKit
import EmptyDataSet_Swift

class MediaList: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var SegmentedControl: UISegmentedControl!
    
    var mediaArr = [Media]()
    var currentMediaArr = [Media]()
    var mediaType: MediaTypes = .music
    var searchBarText: String = ""
      //var audioPlayer : AVPlayer!
    
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        
        UserDefaultManager.shared().isLoggedIn = true
        
        let addBtn = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(tapBTN))
        self.navigationItem.rightBarButtonItem = addBtn
        self.navigationItem.hidesBackButton = true
        
        TableView.rowHeight = UITableView.automaticDimension
        TableView.estimatedRowHeight = 100
        
        setMediaDataBase()
        setTableView()
        self.TableView.reloadData()
    
    
}
    
    func segmentedControlValue(media: Media) {
        switch media.kind {
        case "song":
            SegmentedControl.selectedSegmentIndex = 0
        case "feature-movie":
            SegmentedControl.selectedSegmentIndex = 1
        case "tv-episode":
            SegmentedControl.selectedSegmentIndex = 2
        default:
            SegmentedControl.selectedSegmentIndex = 0
        }
        
        
        
    }
    
    @objc func tapBTN() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let Prof = sb.instantiateViewController(withIdentifier: ViewController.profileVC) as! Profile

        navigationController?.pushViewController(Prof, animated: true)
    }
    
    
    func setTableView() {
        TableView.register(UINib(nibName: Cells.MoviesListCell, bundle: nil) , forCellReuseIdentifier: Cells.MoviesListCell )
        self.TableView.backgroundColor = .white
        TableView.tableFooterView = UIView(frame: .zero)
        SetDelegate()
        
    }
    
    
   
    private func SetDelegate(){
        TableView.dataSource = self
        TableView.delegate = self
        searchBar.delegate = self
        TableView.emptyDataSetSource = self
        TableView.emptyDataSetDelegate = self
    }
    
    
    private func setMediaDataBase(){
        MediaManager.Shared().setupConnection()
        MediaManager.Shared().createTable()
        MediaManager.Shared().getMediaDatabase{ mediaArray in
            if !mediaArray!.isEmpty{
                self.mediaArr = mediaArray!
                self.currentMediaArr = self.mediaArr
                  self.segmentedControlValue(media: self.currentMediaArr[0])
               
            
            }else{
                self.mediaArr = []
                self.currentMediaArr = self.mediaArr
            }
        }
    }
    
    func tableViewReloadData()
    {
        if self.searchBarText != ""{
            MediaManager.Shared().deleteMedia()
            getData()
        }else{
            MediaManager.Shared().deleteMedia()
            currentMediaArr = []
             mediaArr = []
            self.TableView.reloadData()
        }
    }
    
    
    
    
    
    
    
    @IBAction func segmentSwitch(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            mediaType =  MediaTypes.music
            tableViewReloadData()
        case 1:
            mediaType = MediaTypes.movie
            tableViewReloadData()
        case 2:
            mediaType = MediaTypes.tvShow
            tableViewReloadData()
        default:
            tableViewReloadData()
            return mediaType = MediaTypes.music
        }
        
    }
    
    private func getData(){
        APIManager.loadMovies(mediaType: mediaType.rawValue,criteria: searchBarText){ (error, media) in
            if let error = error{
                print(error)
            }else if let media = media{
                if media.isEmpty{
                    self.TableView.emptyDataSetView { view in
                        view.image(UIImage(named: "no-result"))
                    }
                }else{
                self.mediaArr = media
                self.currentMediaArr = self.mediaArr
                }
            }
            MediaManager.Shared().insertMedia(mediaArr: self.currentMediaArr)
            self.TableView.reloadData()
        }
        
    }
    
}

extension MediaList: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print( mediaArr.count)
        print(currentMediaArr.count )
        return self.currentMediaArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.MoviesListCell, for: indexPath) as? MoviesListCell else{
            return UITableViewCell()
        }
       cell.configure(media: self.currentMediaArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mediaKind = currentMediaArr[indexPath.row].kind
        if mediaKind == "song"{
            playAudioFromURL(PreviewUrl: currentMediaArr[indexPath.row].previewUrl)
        }else{
            playVideoFromURL(PreviewUrl: currentMediaArr[indexPath.row].previewUrl)
            
        }
    }
    
    private func playAudioFromURL(PreviewUrl: String) {
        guard let url = URL(string: PreviewUrl) else {
            print("Error to play song")
            return
        }
        
        let audioPlayer = AVPlayer(url: url)
        let controller = AVPlayerViewController()
        controller.player = audioPlayer
        present(controller, animated: true) {
            audioPlayer.play()
        }
    }
    
    private func playVideoFromURL(PreviewUrl: String) {
        guard let url = URL(string: PreviewUrl) else {
            return
        }
        let videoPlayer = AVPlayer(url: url)
        let controller = AVPlayerViewController()
        controller.player = videoPlayer
        present(controller, animated: true) {
            videoPlayer.play()
        }
    }
    
    
    
}

extension MediaList: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarText = searchBar.text!
        guard searchText != "" else {
            currentMediaArr = mediaArr
             
            self.TableView.reloadData()
            return
        }
        currentMediaArr = mediaArr.filter({ media -> Bool in
            searchBarText = searchText
            return (media.artistName?.contains(searchText))!
            
        })
        tableViewReloadData()
    }
    
    
}


extension MediaList:  EmptyDataSetSource, EmptyDataSetDelegate {
    func V(foremptyDataSet scrollView: UIScrollView) -> CGFloat {
        return 0
    }
}

