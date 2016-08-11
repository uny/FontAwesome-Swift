# FontAwesome.swift

Use Font Awesome in your Swift projects

## Installation

### Carthage

To integrate FontAwesome into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "uny/FontAwesome-Swift"
```

Then add `import FontAwesome` to the top of the files using FontAwesome.

## Examples

### FontAwesome icon in label
```swift
label.font = UIFont.fontAwesome(of: 200)
label.text = String.fontAwesomeIcon(with: .faGithub)
```

### FontAwesome icon in label from css class name
```swift
label.font = UIFont.fontAwesome(of: 200)
label.text = String.fontAwesomeIcon(with: "fa-github")
```

### FontAwesome icon as an image
```swift
imageView.image = UIImage.fontAwesomeIcon(with: .faGithub, size: CGSize(width: 200, height: 200), textColor: .blue, backgroundColor: .white)
```

## Requirements
* iOS 8.0+, watchOS 2.0+
* Xcode 8 beta 5

## License
- FontAwesome.otf file licensed under [SIL OFL 1.1](http://scripts.sil.org/OFL)
- FontAwesome.swift licensed under [MIT](./LICENSE)
