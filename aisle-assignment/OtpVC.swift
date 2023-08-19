//
//  OtpVC.swift
//  aisle-assignment
//
//  Created by Shruti S on 18/08/23.
//

import UIKit

class OtpVC: UIViewController {
    
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var numberLabel: UILabel!
    
    var previousNumber = ""
    var previousNumberFormatted = ""
    var authToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        numberLabel.text = previousNumber
        continueButton.makeRoundedBorder()
    }
    
    @IBAction func continueClicked(_ sender: Any) {
        makeRequest(completion: segueToTabController(authToken:))
    }
    
    private var otp: String {
        return otpTextField.text ?? ""
    }
    
    private func segueToTabController(authToken: String) {
        self.authToken = authToken
        authorization = authToken
        
        if authToken != "" {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toTabController", sender: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTabController" {
            if let dest = segue.destination as? UITabBarController {
                dest.selectedIndex = 1
                
                if let notesVC = dest.viewControllers![1] as? NotesVC {
                    notesVC.authToken = self.authToken
                }
            }
        }
    }
    
    
    private func makeRequest(completion: @escaping (String) -> () ) {
        //TESTING ONLY
        otpTextField.text = "1234"
        
        let url = URL(string: "https://app.aisle.co/V1/users/verify_otp?number=\(previousNumberFormatted)&otp=\(otp)")!
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: AnyObject] {
                        if let token = json["token"] as? String {
                            print(json)
                            completion(token)
                        }
                    }
                } catch {}
                
            }
        }
        task.resume()
        
    }

}




var authorization = ""
