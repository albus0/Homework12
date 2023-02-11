//
//  ViewController.swift
//  Homework12
//
//  Created by Альбина on 10.02.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    //MARK: -Outlets
    
    private lazy var label: UILabel = {
           let label = UILabel()
           label.text = "25:00"
           label.textAlignment = .center
           label.font = UIFont.systemFont(ofSize: 60)
           label.textColor = .red
           return label
       }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setImage(UIImage(named: "play"), for: .normal)
        button.layer.cornerRadius = 60.0
        button.layer.shouldRasterize = true
        button.addTarget(self, action: #selector(makeTimer), for: .touchUpInside)
        return button
    }()
    
    var timer: Timer?
    
    var workTime = 25 * 100
    var relaxTime = 5 * 100
    var isWorkTime = true
    lazy var currentTime = workTime
    
   

    //MARK: -Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarcy()
        setupLayout()
    }
    
    //MARK: - Setup
    
    private func setupHierarcy() {
        view.addSubview(label)
        view.addSubview(button)
    }
    
    private func setupLayout() {
        
        label.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.height.equalTo(630)
        }
        
        button.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.height.equalTo(100)
            make.width.equalTo(100)
            make.left.equalTo(view).offset(150)
            make.right.equalTo(view).offset(-150)
            make.top.equalTo(label.snp.bottom).offset(-200)
        }
    }
    
    //MARK: -Actions
    
    @objc private func makeTimer() {
        currentTime = isWorkTime ? workTime : relaxTime
        button.isEnabled = false
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(makeSome), userInfo: nil, repeats: true)
    }
    
    @objc private func makeSome() {
        currentTime -= 1
        label.text = String(convertTimeToString(time: currentTime))
        
        if currentTime == 0 {
            isWorkTime.toggle()
            timer?.invalidate()
            let nextTime = convertTimeToString(time: isWorkTime ? workTime : relaxTime)
            label.text = nextTime
            button.isEnabled = true
        }
    }
    
    func convertTimeToString(time: Int) -> String {
        let min = time / 100
        let sec = time % 100
        
        return String("\(min):\(sec)")
    }


}

