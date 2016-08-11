//
//  FontAwesomeTests.swift
//  FontAwesome
//
//  Created by Yuki Nagai on 8/11/16.
//  Copyright © 2016 Yuki Nagai. All rights reserved.
//

import XCTest
import UIKit
@testable import FontAwesome

final class FontAwesomeTests: XCTestCase {
    func testIconFontShouldBeRegisted() {
        let label = UILabel()
        label.font = UIFont.fontAwesome(of: 200)
        XCTAssertNotNil(label.font)
    }
    
    func testLabelText() {
        let expected = "\u{f09b}"
        let label = UILabel()
        label.font = UIFont.fontAwesome(of: 200)
        label.text = String.fontAwesomeIcon(with: .faGithub)
        XCTAssertEqual(label.text, expected)
        label.text = String.fontAwesomeIcon(with: "fa-github")
        XCTAssertEqual(label.text, expected)
    }
    
    func testLabelTextForWrongName() {
        let label = UILabel()
        label.font = UIFont.fontAwesome(of: 200)
        label.text = String.fontAwesomeIcon(with: "wrong-name")
        XCTAssertEqual(label.text, "")
    }
    
    func testButtonImage() {
        let button = UIButton()
        button.setImage(UIImage.fontAwesomeIcon(with: .faGithub, size: CGSize(width: 4000, height: 4000), textColor: .yellow, backgroundColor: .red), for: .normal)
        XCTAssertNotNil(button.image(for: .normal))
        button.setImage(UIImage.fontAwesomeIcon(with: "fa-github", size: CGSize(width: 4000, height: 4000), textColor: .yellow, backgroundColor: .red), for: .normal)
        XCTAssertNotNil(button.image(for: .normal))
    }
    
    func testButtonImageForWrongName() {
        let button = UIButton()
        button.setImage(UIImage.fontAwesomeIcon(with: "wrong-name", size: CGSize(width: 4000, height: 4000), textColor: .yellow, backgroundColor: .red), for: .normal)
        XCTAssertNotNil(button.image(for: .normal))
    }
}
