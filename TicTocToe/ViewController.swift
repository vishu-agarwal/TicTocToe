//
//  ViewController.swift
//  TicTocToe
//
//  Created by DCS on 02/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let myImg: UIImageView = {
        
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = UIImage(named: "bgImg")
        img.layer.cornerRadius = 6
        img.clipsToBounds = true
        return img
    }()
    
    private let mybtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Start", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.borderWidth = 5
        
        btn.addTarget(self, action: #selector(nextvc), for: .touchUpInside)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 27
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mybtn)
        view.addSubview(myImg)
        
        
        // Do any additional setup after loading the view.
    }
    @objc func nextvc(){
        
        let vc = TicTacToe()
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLayoutSubviews() {
        // bgimg.frame = CGRect(x:0, y: view.safeAreaInsets.top, width: view.width, height: 700)
        myImg.frame = CGRect(x: 5, y: 200, width : view.width - 10, height: 550)
        mybtn.frame = CGRect(x: 20,y: 100,width: view.width - 40,height: 60)
    }

}

