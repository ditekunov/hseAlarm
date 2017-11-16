//
//  ViewController.swift
//  HSE Alarm
//
//  Created by Daniil Tekunov on 11.05.17.
//  Copyright © 2017 Daniil Tekunov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let lessons = ["1", "2", "3", "4", "5", "6", "7", "8"]

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var lessonPicker: UIPickerView!
    
    @IBOutlet weak var ResultLabel: UILabel!
    @IBOutlet weak var recommButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapRecommButton(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateAsString = dateFormatter.string(from: self.datePicker.date)
        
        let selectedIndex = self.lessonPicker.selectedRow(inComponent: 0)
        
        // Data preparing
        let params = "Date=\(dateAsString)&Para=\(lessons[selectedIndex])"
//        let myParams = "Date=2017-05-11&Para=1"
        let postData = params.data(using: String.Encoding.ascii, allowLossyConversion: true)
        
        // We count the data size to form Content-length field
        let postLength = String(format: "%d", postData!.count)
        
        // Creating request
        let url = URL(string: "http://offended.orgfree.com/hsealarm/main.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // We set the headers
        request.setValue(postLength, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // We set the request body
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseString = String(data: data, encoding: String.Encoding.utf8) as String!
            DispatchQueue.main.async {
                self.ResultLabel.text = responseString
            }
            
        }
        
        task.resume()
        
        
        
    }

    @IBAction func didChooseDate(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        print(dateFormatter.string(from: self.datePicker.date))
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lessons.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return lessons[row]
    }
    
}

