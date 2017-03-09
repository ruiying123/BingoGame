//
//  ViewController.swift
//  BingoDemo
//
//  Created by 杨锐 on 2016/11/4.
//  Copyright © 2016年 yang. All rights reserved.
//

import UIKit
//import podTest
import YRExtension

class ViewController: UIViewController {

    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    fileprivate var number: String = "0"
    fileprivate var timer: Timer?
    fileprivate var numberArray: [String] = []
    fileprivate var setNumberArray: [String] = []
    fileprivate var index: Int = 0
    fileprivate var maxNum: Int = 75
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bingo"
        for i in 1..<maxNum+1 {
            numberArray.append(String(i))
        }
        startButton.setTitle("开始", for: .normal)
        startButton.setTitle("结束", for: .selected)
        numLabel.textColor = UIColor.white.withAlphaComponent(0.5)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? HistoryViewController {
            vc.numberArray = setNumberArray
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 开始
    ///
    /// - Parameter sender: 按钮
    @IBAction func startAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            timerStart()
        } else {
            timerEnd()
        }
    }
    
    /// 定时器开始
    fileprivate func timerStart() {
        if let timer = self.timer {
            timer.fireDate = Date.distantPast
        } else {
            self.timer = Timer.scheduledTimer(timeInterval: 0.07, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            self.timer?.fireDate = Date.distantPast
        }
    }
    
    /// 定时器方法
    @objc fileprivate func timerAction() {
        index = Int(arc4random())%(numberArray.count)
        number = numberArray[index]
        numLabel.text = number
//        numLabel.textColor = UIColor(red: CGFloat(arc4random_uniform(255)) / CGFloat(255.0), green: CGFloat(arc4random_uniform(255)) / CGFloat(255.0), blue: CGFloat(arc4random_uniform(255)) / CGFloat(255.0), alpha: 1)
    }
    
    /// 定时器结束
    fileprivate func timerEnd() {
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
        }
        print(number)
        setNumberArray.append(number)
        numberArray.remove(at: index)
        if numberArray.isEmpty {
            startButton.isEnabled = false
            self.showAlert()
        }
//        print("已经出现的数字有\(setNumberArray)")
//        print("剩下的数字有\(numberArray)")
    }
    
    fileprivate func showAlert() {
        let alert = UIAlertController(title: "提示", message: "所有的数字已经都出现过了", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

