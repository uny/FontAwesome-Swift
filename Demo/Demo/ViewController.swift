//
//  ViewController.swift
//  Demo
//
//  Created by Yuki Nagai on 8/11/16.
//
//

import UIKit
import FontAwesome

final class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var barButtonItem: UIBarButtonItem!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // FontAwesome icon in label
        let label = self.label!
        label.font = UIFont.fontAwesome(of: 100)
        label.text = String.fontAwesomeIcon(with: .faGithub)
        
        // FontAwesome icon in button
        let button = self.button!
        button.titleLabel?.font = UIFont.fontAwesome(of: 100)
        button.setTitle(String.fontAwesomeIcon(with: .faGithub), for: .normal)
        
        let attributes = [NSFontAttributeName: UIFont.fontAwesome(of: 20)]
        
        // FontAwesome icon as navigation bar item
        let barButtonItem = self.barButtonItem!
        barButtonItem.setTitleTextAttributes(attributes, for: .normal)
        barButtonItem.title = String.fontAwesomeIcon(with: .faGithub)
        
        // FontAwesome icon as image
        let imageView1 = self.imageView1!
        imageView1.image = UIImage.fontAwesomeIcon(with: .faGithub, size: CGSize(width: 100, height: 100))
        
        // FontAwesome icon as image with color
        let imageView2 = self.imageView2!
        imageView2.image = UIImage.fontAwesomeIcon(with: .faGithub, size: CGSize(width: 100, height: 100), textColor: .white, backgroundColor: .black)
    }
}

