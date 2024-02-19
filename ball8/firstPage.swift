//
//  ViewController.swift
//  ball8
//
//  Created by Farnoosh on 11/30/23.
//

import UIKit

class firstPage: UIViewController {

    @IBOutlet var numberLbl: UILabel!
    @IBOutlet var wheelBtn: UIButton!
    
    @IBOutlet var luckLbl: UILabel!
    
    let randomColors = [UIColor.orange, UIColor.systemPink, UIColor.yellow, UIColor.purple, UIColor.green,
                        UIColor.blue, UIColor.gray, UIColor.blue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    func setupView(){
        self.wheelBtn.layer.shadowColor = UIColor(rgb: 0xFFfddb3a).withAlphaComponent(0.5).cgColor
        self.wheelBtn.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        self.wheelBtn.layer.shadowOpacity = 1.0
        self.wheelBtn.layer.shadowRadius = 0.0
        self.wheelBtn.layer.masksToBounds = false
        //self.wheelBtn.layer.cornerRadius = 4.0
        self.wheelBtn.makeRadius(radius: 4.0)
        
        self.numberLbl.text = "."
        self.luckLbl.text = ""
    }

    func getRandomNumber(index: Int) -> UInt32 {
        let lower : UInt32 = 0
        let upper : UInt32 = 8
        
        let randomNumber = arc4random_uniform(upper - lower)  + lower
        self.wheelBtn.setTitle("\(self.getPersianNumber(number: randomNumber))", for: .normal)
        
        return randomNumber
    }
    
    func getPersianNumber (number: UInt32) -> String {
        return String(number)
    }
    
    func roundWheel(){
        var randomLuckyNumber: UInt32!
        
        DispatchQueue.global(qos: .userInitiated).async {
            for i in 0...7 {
                DispatchQueue.main.async {
                    randomLuckyNumber = self.getRandomNumber(index: i)
                    self.wheelBtn.backgroundColor = self.randomColors[i]
                    //print(i)
                    if (i == 7){
                        self.wheelBtn.isEnabled = true
                        self.numberLbl.text = self.getPersianNumber(number: randomLuckyNumber!)
                        self.wheelBtn.setTitle("شانستو امتحان کن", for: .normal)
                    } else {
                        self.wheelBtn.isEnabled = false
                    }
                }
                usleep(useconds_t(100000))
            }
        }
    }
    
    @IBAction func wheelBtnPressed(_ sender: Any) {
        self.roundWheel()
    }
    
}

extension UIColor{
    
    convenience init(rgb: Int){
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF),
            green: CGFloat((rgb >> 8) & 0xFF),
            blue: CGFloat(rgb & 0xFF), alpha: 1
        )
    }
}

extension UIButton {
    func makeRadius (radius: CGFloat){
        assert (radius > 0, "Invalid radius number")
        self.layer.cornerRadius = radius
    }
    
    
}
