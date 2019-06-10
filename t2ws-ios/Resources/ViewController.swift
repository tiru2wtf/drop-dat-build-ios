//
//  ViewController.swift
//  t2ws-ios
//
//  Created by Bruno Alves on 07/06/19.
//  Copyright © 2019 t2ws. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var privada: UILabel!
    @IBOutlet weak var primaryButton: UIButton!
    @IBOutlet weak var singerLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0.2, green: 0.03137254902, blue: 0.4039215686, alpha: 1).cgColor, #colorLiteral(red: 0.1882352941, green: 0.8117647059, blue: 0.8156862745, alpha: 1).cgColor,]
        gradientLayer.shouldRasterize = true

        gradientView.layer.addSublayer(gradientLayer)

        primaryButton.setTitle("time to drop ?", for: UIControl.State.normal)
        primaryButton.layer.cornerRadius = 4
        
        card.layer.cornerRadius = 4
        card.isHidden = true

    }

    
    @IBAction func requestDropDatBuild(_ sender: UIButton) {
        primaryButton.setTitle("…carregando", for: UIControl.State.normal)
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession.init(configuration: config)
        let url = URL(string: "https://players.gc2.com.br/cron/alphafm/results.json")!
        let task = session.dataTask(with: url) { data, response, error in
            
            print(data ?? "")
            print(response ?? "")
            print(error ?? "")
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            
            guard let jsonData = data else { return }
            
            do {
                let dropDatBuildResponse = try JSONDecoder().decode(dropDatBuild.self, from: jsonData)
                let singer = dropDatBuildResponse.musicas[0].tocando[0].singer
                let song = dropDatBuildResponse.musicas[0].tocando[0].song
                print(singer,song)
                DispatchQueue.main.sync {
                    self.singerLabel.text = singer;
                    self.songLabel.text = song
                    self.primaryButton.setTitle("time to drop ?", for: UIControl.State.normal)
                    self.card.isHidden = false
                }
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
        URLCache.shared = URLCache()
    }

    @IBAction func closeCard(_ sender: UIButton) {
        card.isHidden = true
    }
}
