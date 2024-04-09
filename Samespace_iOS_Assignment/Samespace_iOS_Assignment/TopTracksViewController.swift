//
//  TopTracksViewController.swift
//  Samespace_iOS_Assignment
//
//  Created by Prasenjeet Pandagale on 05/04/24.
//

import UIKit
import AVFoundation

class TopTracksViewController: UIViewController {

    @IBOutlet var topTracksTableView: UITableView!
    var songs: [Song] = []
    var demoImage = UIImage(named: "imagee")
    var url: String?
    var urlSession: URLSession?
    var urlRequest: URLRequest?
    var uiNib: UINib?
    var topTracksTableViewCell: TopTracksTableViewCell?
    var cellIdentifier2 = "TopTracksTableViewCell"
    var player2ViewController: Player2ViewController?
    var player2ViewControllerIdentifier = "Player2ViewController"
    var player: AVPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTableView()
        registeringXIBWithTableView()
        serializeJSON()
    }

    func initializeTableView(){
        topTracksTableView.delegate = self
        topTracksTableView.dataSource = self
    }
    
    func registeringXIBWithTableView(){
        let uiNib = UINib(nibName: "TopTracksTableViewCell", bundle: nil)
        topTracksTableView.register(uiNib, forCellReuseIdentifier: cellIdentifier2)
    }
    
    
    func serializeJSON(){
    let url = URL(string: "https://cms.samespace.com/items/songs")
        urlRequest = URLRequest(url: url!)
        urlRequest?.httpMethod = "GET"
        urlSession = URLSession(configuration: .default)
        let dataTask = urlSession?.dataTask(with: urlRequest!) { data, response, error in
            print(data)
            print(response)
            print(error)
            
            let jsonResponse = try! JSONSerialization.jsonObject(with: data!) as! [String: Any]
            let songs = jsonResponse["data"] as! [[String: Any]]
            
            for song in songs{
                
                let eachId = song["id"] as! Int
                let eachName = song["name"] as! String
                let eachArtist = song["artist"] as! String
                let eachTopTrack = song["top_track"] as! Bool
                let eachUrl = song["url"] as! String
                print(jsonResponse)
                if eachTopTrack == true{
                    let songObject = Song(id: eachId, name: eachName, artist: eachArtist, top_track: eachTopTrack, url: eachUrl)
                    self.songs.append(songObject)
                }else{
                    print("No top tracks found")
                }
              
                }
            DispatchQueue.main.async {
                self.topTracksTableView.reloadData()
            }
            print(self.songs)
        }
        dataTask?.resume()
    }
    
}

extension TopTracksViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        topTracksTableViewCell = (self.topTracksTableView.dequeueReusableCell(withIdentifier: cellIdentifier2, for: indexPath) as! TopTracksTableViewCell)
        topTracksTableViewCell?.songNameLabel.text = songs[indexPath.row].name
        topTracksTableViewCell?.artistNameLabel.text = songs[indexPath.row].artist
        topTracksTableViewCell?.topTrackImageView.image = UIImage(named: "imagee")
        
        return topTracksTableViewCell!
    }
}

extension TopTracksViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSong = songs[indexPath.row]
        showPlayer2ViewController(with: selectedSong)
    }
     
    func showPlayer2ViewController(with song: Song) {
        if let player2ViewController = storyboard?.instantiateViewController(withIdentifier: player2ViewControllerIdentifier) as? Player2ViewController {
            player2ViewController.song = song
            navigationController?.pushViewController(player2ViewController, animated: true)
        }
    }
}
