//
//  ViewController.swift
//  NumberToWordTask
//
//  Created by Kishore on 09/09/20.
//  Copyright © 2020 Kishore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var txtFldInput: UITextField!
    @IBOutlet weak var lblOutPut: UILabel!
    
    //MARK:- Constants and Variables
    var underTwenty = ["Zero","One","Two","Three","Four","Five","Six","Seven","Eight","Nine","Ten","Eleven","Twelve","Thirteen","Fourteen","Fifteen","Sixteen","Seventeen","Eighteen","Nineteen"]
    var tens = ["Twenty","Thirty","Forty","Fifty","Sixty","Seventy","Eighty","Ninety"]
    var aboveHundered = [100: "Hundred",1000:"Thousand", 1000000:"Million", 1000000000:"Billion"]
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK:- Additional Functions
    func numToWord(number: Int)->String{
        if number < 20{
            return underTwenty[number]
        }
        if number < 100{
            if number%10 != 0{
                return "\(tens[(number/10)-2]) \(underTwenty[number%10])"
            }
        }
        
        for key in aboveHundered.keys{
            if key < number{
                if number % key != 0{
                    return "\(numToWord(number: number/key)) \(aboveHundered[key]!) \(numToWord(number: number%key))"
                }
            }
        }
        return ""
    }
    
    //MARK:- Toast Message
    func toastMessage(_ message: String){
        guard let window = UIApplication.shared.keyWindow else {return}
        let messageLbl = UILabel()
        messageLbl.text = message
        messageLbl.textAlignment = .center
        messageLbl.font = UIFont.systemFont(ofSize: 12)
        messageLbl.textColor = .white
        messageLbl.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        let textSize:CGSize = messageLbl.intrinsicContentSize
        let labelWidth = min(textSize.width, window.frame.width - 40)
        
        messageLbl.frame = CGRect(x: 20, y: window.frame.height - 90, width: labelWidth + 30, height: textSize.height + 20)
        messageLbl.center.x = window.center.x
        messageLbl.layer.cornerRadius = messageLbl.frame.height/2
        messageLbl.layer.masksToBounds = true
        window.addSubview(messageLbl)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            UIView.animate(withDuration: 2, animations: {
                messageLbl.alpha = 0
            }) { (_) in
                messageLbl.removeFromSuperview()
            }
        }
    }
    //MARK:- IBActions
    @IBAction func actionSubmit(_ sender: Any) {
        if txtFldInput.text!.isEmpty{
            lblOutPut.text = ""
            toastMessage(" Please enter number ")
        } else {
        lblOutPut.text =  numToWord(number: Int(txtFldInput.text!) ?? 0)
    }
    
}

}
