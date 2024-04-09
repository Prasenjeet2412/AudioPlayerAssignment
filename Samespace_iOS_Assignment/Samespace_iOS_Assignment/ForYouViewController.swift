//
//  ForYouViewController.swift
//  Samespace_iOS_Assignment
//
//  Created by Prasenjeet Pandagale on 05/04/24.
//

import UIKit
import AVFoundation

class ForYouViewController: UIViewController {

    @IBOutlet var forYouTableView: UITableView!
    var songs: [Song] = []
    var demoImage = UIImage(named: "imagee")
    var url: String?
    var urlSession: URLSession?
    var urlRequest: URLRequest?
    var uiNib: UINib?
    var forYouTableViewCell: ForYouTableViewCell?
    var cellIdentifier1 = "ForYouTableViewCell"
    var player1ViewController: Player1ViewController?
    var player1ViewControllerIdentifier = "Player1ViewController"
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serializeJSON()
        initializeTableView()
        registeringXIBWithTableView()
        }
    
    func initializeTableView(){
        forYouTableView.delegate = self
        forYouTableView.dataSource = self
    }
    
    func registeringXIBWithTableView(){
        let uiNib = UINib(nibName: "ForYouTableViewCell", bundle: nil)
        forYouTableView.register(uiNib, forCellReuseIdentifier: cellIdentifier1)
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
                let songObject = Song(id: eachId, name: eachName, artist: eachArtist, top_track: eachTopTrack, url: eachUrl)
                
                self.songs.append(songObject)
                }
            DispatchQueue.main.async {
                self.forYouTableView.reloadData()
            }
            print(self.songs)
        }
        dataTask?.resume()
    }
    
}

extension ForYouViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        forYouTableViewCell = (self.forYouTableView.dequeueReusableCell(withIdentifier: cellIdentifier1, for: indexPath) as! ForYouTableViewCell)
        forYouTableViewCell?.backgroundColor = .cyan
        forYouTableViewCell?.songLabel.text = songs[indexPath.row].name
        forYouTableViewCell?.artistLabel.text = songs[indexPath.row].artist
        forYouTableViewCell?.forYouImageView.image = UIImage(named: "imagee")
        return forYouTableViewCell!
    }
}

extension ForYouViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSong = songs[indexPath.row]
        showPlayer1ViewController(with: selectedSong)
    }
     
    func showPlayer1ViewController(with song: Song) {
        if let player1ViewController = storyboard?.instantiateViewController(withIdentifier: player1ViewControllerIdentifier) as? Player1ViewController {
            player1ViewController.song = song
            navigationController?.pushViewController(player1ViewController, animated: true)
        }
    }
}

