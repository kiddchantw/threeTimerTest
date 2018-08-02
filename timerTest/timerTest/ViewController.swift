//
//  ViewController.swift
//  timerTest
//
//  Created by kiddchantw on 2018/7/30.
//  Copyright © 2018年 kiddchantw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var btnA: UIButton!
    
    
    @IBOutlet var btnC: UIButton!
    @IBOutlet var btnB: UIButton!
    var boolTimer:Bool = false
    var boolGCD: Bool = false
    var boolCADisplayLink:Bool = false
    var count:Int = 0
    
    @IBOutlet var lblZero: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        btnA.setTitleColor(UIColor.black, for: .normal)
        btnA.setTitleColor(UIColor.red, for: .selected)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var myTimer:Timer?
    @IBAction func btnA(_ sender: UIButton) {
        if boolTimer {
            boolTimer = false
            count = 0
            lblZero.text = "0"
            myTimer?.invalidate()
            
        }else{
            boolTimer = true
            myTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(addCount), userInfo: nil, repeats: true)
        }
    }

    @objc func addCount(){
        count = count + 1
        lblZero.text = String(count)
    }
    
    
    
  
    @IBAction func btnB(_ sender: UIButton) {
        print(boolGCD)
        if boolGCD {
            boolGCD = false
            count = 0
            lblZero.text = "0"
            deinitTimer()
        }else{
            boolGCD = true
            setTheTimer()
        }
    }
    
    private var timerD: DispatchSourceTimer?
    var pageStepTime: DispatchTimeInterval = .seconds(1)
    func setTheTimer() {
        timerD = DispatchSource.makeTimerSource(queue: .main)
        timerD?.schedule(deadline: .now() + pageStepTime, repeating: pageStepTime)
        timerD?.setEventHandler {
            self.AddCountM2()
        }
        timerD?.resume()
    }
    
    func deinitTimer() {
        if self.timerD != nil {
            timerD?.cancel()
            timerD = nil
        }
    }
    
    func AddCountM2 (){
        count = count + 1
        lblZero.text = String(count)
    }
    
    
    
    var dis: CADisplayLink?
    @IBAction func btnC(_ sender: UIButton) {
        if boolCADisplayLink {
            boolCADisplayLink = false
            lblZero.text = "0"
            count = 0

            dis?.invalidate()
        }else{
            boolCADisplayLink = true
            
            dis = CADisplayLink (target: self, selector: #selector(addCount))
            dis?.preferredFramesPerSecond = 1 //設1秒/次
            dis?.add(to: RunLoop.current , forMode: RunLoopMode.defaultRunLoopMode)
        }
    }
    
}






