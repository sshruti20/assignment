//
//  NotesVC.swift
//  aisle-assignment
//
//  Created by Shruti S on 18/08/23.
//

import UIKit

class NotesVC: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainNameLabel: UILabel!
    
    @IBOutlet weak var upgradeButton: UIButton!
    
    @IBOutlet weak var likeImageView1: UIImageView!
    @IBOutlet weak var likeNameLabel1: UILabel!
    
    @IBOutlet weak var likeImageView2: UIImageView!
    @IBOutlet weak var likeNameLabel2: UILabel!
    
    var authToken: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        upgradeButton.makeRoundedBorder()
        print("Auth token: \(authToken)")
        makeRequest(completion: loadPage(profileResponse:))
    }
    
    func loadPage(profileResponse: ProfilesResponse) {
        let mainName = profileResponse.invites.profiles.first?.generalInformation.firstName ?? ""
        let mainAge = profileResponse.invites.profiles.first?.generalInformation.age ?? 0
        
        DispatchQueue.main.async {
            self.mainNameLabel.text = "\(mainName), \(mainAge)"
            self.likeNameLabel1.text = profileResponse.likes.profiles[0].firstName
            self.likeNameLabel2.text = profileResponse.likes.profiles[1].firstName
        }
        
        
        let mainImgUrl = profileResponse.invites.profiles.first?.photos[0].photo ?? ""
        getImageFromUrl(imgUrl: mainImgUrl) { image in
            DispatchQueue.main.async {
                self.mainImageView.roundCorners()
                self.mainImageView.image = image
            }
        }
        
        let imgUrl1 = profileResponse.likes.profiles[0].avatar
        getImageFromUrl(imgUrl: imgUrl1) { image in
            DispatchQueue.main.async {
                self.likeImageView1.image = image
                self.likeImageView1.blurImage()
                self.likeImageView1.roundCorners()
            }
        }
        
        let imgUrl2 = profileResponse.likes.profiles[1].avatar
        getImageFromUrl(imgUrl: imgUrl2) { image in
            DispatchQueue.main.async {
                self.likeImageView2.image = image
                self.likeImageView2.blurImage()
                self.likeImageView2.roundCorners()
            }
        }
         
    }
    
    func getImageFromUrl(imgUrl: String, completion: @escaping (UIImage) -> ()) {
        let url = URL(string: imgUrl)!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let img = UIImage(data: data) ?? UIImage()
                completion(img)
            }
        }.resume()
        
    }

    
    func makeRequest(completion: @escaping (ProfilesResponse) -> () ) {
        let url = URL(string: "https://app.aisle.co/V1/users/test_profile_list")!
        
        var request: URLRequest = URLRequest(url: url)
        request.setValue(Authorization.shared.token, forHTTPHeaderField:"Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                
            } else if let data = data {
                let profilesResponse = try! JSONDecoder().decode(ProfilesResponse.self, from: data)
                completion(profilesResponse)
                print(profilesResponse)
            }
        }.resume()
    }

}

extension UIImageView {
    func blurImage() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.bounds;
        // add the UIVisualEffectView inside the ImageView
        self.addSubview(blurView)
    }
    
    func roundCorners() {
        self.layer.masksToBounds = true;
        self.layer.cornerRadius = 20
    }
}
