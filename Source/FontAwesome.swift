//
//  FontAwesome.swift
//  FontAwesome
//
//  Created by Yuki Nagai on 8/11/16.
//  Copyright © 2016 Yuki Nagai. All rights reserved.
//

import UIKit

// MARK: - Public

// MARK: UIFont

private let fontAwesomeFontName = "FontAwesome"
private let fontAwesomeLoaded = { name -> Bool in
    if UIFont.fontNames(forFamilyName: name).isEmpty {
        FontLoader.load(name: name)
    }
    return true
}(fontAwesomeFontName)

extension UIFont {
    /**
     Get a UIFont object of FontAwesome.
     
     - parameter fontSize: The preferred font size.
     - returns: A UIFont object of FontAwesome.
     */
    public static func fontAwesome(of fontSize: CGFloat) -> UIFont {
        _ = fontAwesomeLoaded
        return UIFont(name: fontAwesomeFontName, size: fontSize)!
    }
}

// MARK: String

extension String {
    /**
     Get a FontAwesome icon string with the given icon name.
     
     - parameter name: The preferred icon name.
     - returns: A string that will appear as icon with FontAwesome.
     */
    public static func fontAwesomeIcon(with name: Icon) -> String {
        return name.unicode
    }
    
    /**
     Get a FontAwesome icon string with the given CSS icon code. Icon code can be found here: http://fontawesome.io/icons/
     
     - parameter code: The preferred icon name.
     - returns: A string that will appear as icon with FontAwesome. It returns an empty string for wrong icon name.
     */
    public static func fontAwesomeIcon(with name: String) -> String {
        guard let name = Icon(rawValue: name) else { return "" }
        return self.fontAwesomeIcon(with: name)
    }
}

// MARK: UIImage

extension UIImage {
    /**
     Get a FontAwesome image with the given icon name, size, text color, and background color.
     
     - parameters:
       - name: The preferred icon name.
       - size: The image size.
       - textColor: The text color. Default is UILabel's default.
       - backgroundColor: The background color. Default is `.clear`.
     */
    public static func fontAwesomeIcon(with name: Icon, size: CGSize, textColor: UIColor? = nil, backgroundColor: UIColor = .clear) -> UIImage {
        // Taken from FontAwesome.io's Fixed Width Icon CSS
        let aspectRatio: CGFloat = 1.28571429
        let fontSize = min(size.width / aspectRatio, size.height)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        label.font = UIFont.fontAwesome(of: fontSize)
        label.text = String.fontAwesomeIcon(with: name)
        label.textColor = textColor
        label.backgroundColor = backgroundColor
        label.textAlignment = .center
        UIGraphicsBeginImageContext(size)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    /**
     Get a FontAwesome image with the given icon name, size, text color, and background color.
     
     - parameters:
       - name: The preferred icon name.
       - size: The image size.
       - textColor: The text color. Default is UILabel's default.
       - backgroundColor: The background color. Default is `.clear`.
     */
    public static func fontAwesomeIcon(with name: String, size: CGSize, textColor: UIColor? = nil, backgroundColor: UIColor = .clear) -> UIImage {
        guard let name = Icon(rawValue: name) else {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            view.backgroundColor = backgroundColor
            UIGraphicsBeginImageContext(size)
            view.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return image
        }
        return self.fontAwesomeIcon(with: name, size: size, textColor: textColor, backgroundColor: backgroundColor)
    }
}


// MARK: - Private
private final class FontLoader {
    static func load(name: String, ext: String = "otf") {
        let bundle = Bundle(for: self)
        let fontURL = bundle.url(forResource: name, withExtension: ext)!
        let data = try! Data(contentsOf: fontURL)
        
        let provider = CGDataProvider(data: data as CFData)!
        let font = CGFont(provider)
        
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            guard let error = error?.takeUnretainedValue() else { return }
            let description = CFErrorCopyDescription(error) as String
            NSException(
                name: .internalInconsistencyException,
                reason: description,
                userInfo: [NSUnderlyingErrorKey: error as AnyObject as! NSError]).raise()
        }
    }
}
