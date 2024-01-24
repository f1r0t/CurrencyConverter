//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Fırat AKBULUT on 28.07.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getButton(_ sender: Any) {
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=c24ff39c839eae009526548e8904086e")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else{
                if data != nil {
                    do {
                        let jsonResponse = try  JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String:Any]{
                                if let cad = rates["CAD"]{
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"]{
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                if let gbp = rates["GBP"]{
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                if let jpy = rates["JPY"]{
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                                if let usd = rates["USD"]{
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                if let tr = rates["TRY"]{
                                    self.tryLabel.text = "TRY: \(tr)"
                                }
                            }
                        }
                    } catch  {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        task.resume()
    }
    
}

