//
//  PhoneNumVC.swift
//  aisle-assignment
//
//  Created by Shruti S on 18/08/23.
//

import UIKit

class PhoneNumVC: UIViewController {
    
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        continueButton.makeRoundedBorder()
    }
    
    @IBAction func continueClicked(_ sender: Any) {
        makeRequest(completion: segueToOtpScreen)
    }
    
    private func segueToOtpScreen () {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "toOtpVC", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toOtpVC" {
            let dest = segue.destination as! OtpVC
            dest.previousNumber = self.phoneNumber
            dest.previousNumberFormatted = self.phoneNumberFormatted
        }
    }
    
    private var phoneNumber: String {
        return (codeTextField.text ?? "") + " " + (numberTextField.text ?? "")
    }
    
    private var phoneNumberFormatted: String {
        let enteredCode = codeTextField.text ?? ""
        let formattedCode = enteredCode.replacingOccurrences(of: "+", with: "%2B")
        return formattedCode + (numberTextField.text ?? "")
    }
    
    private func makeRequest(completion: @escaping () -> () ) {
        //TESTING ONLY
        codeTextField.text = "+91"
        numberTextField.text = "9876543212"
        
        let url = URL(string: "https://app.aisle.co/V1/users/phone_number_login?number=\(phoneNumberFormatted)")!
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: AnyObject] {
                        if let status = json["status"] as? Bool {
                            print(json)
                            if status == true {
                                completion()
                            }
                        }
                    }
                } catch {}
                
            }
        }
        task.resume()
        
    } //makeReq ends
    
}

extension UIButton {
    func makeRoundedBorder() {
        self.layer.cornerRadius = 20
    }
}
