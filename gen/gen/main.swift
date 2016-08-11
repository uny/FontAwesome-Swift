//
//  main.swift
//  gen
//
//  Created by Yuki Nagai on 8/11/16.
//  Copyright © 2016 Yuki Nagai. All rights reserved.
//

import Yaml

struct Icon {
    let name: String
    let id: String
    let unicode: String
}

func main() {
    let fileURL = NSBundle.mainBundle().URLForResource("icons", withExtension: "yml")!
    let fileString = try! String(contentsOfURL: fileURL)
    let fileIcons = Yaml.load(fileString).value!["icons"].array ?? []
    let icons = fileIcons.map { fileIcon -> Icon in
        let id = fileIcon["id"].string!
        let name = { id -> String in
            let components = id.componentsSeparatedByString("-")
            return "fa" + components.enumerate().map { index, value in
                if value == "o" { return "Outlined" }
                return String(value.characters.prefix(1)).capitalizedString + String(value.characters.dropFirst())
                }.joinWithSeparator("")
        }(id)
        return Icon(name: name, id: id, unicode: fileIcon["unicode"].string!)
    }
    var lines = [
        "//",
        "//  Icon.swift",
        "//  FontAwesome",
        "//",
        "//  Created by Yuki Nagai on 8/11/16.",
        "//  Copyright © 2016 Yuki Nagai. All rights reserved.",
        "//",
        "",
        "/// An enumaration of FontAwesome icon names.",
        "public enum Icon: String {"
    ]
    lines += icons.map { "    case \($0.name) = \"fa-\($0.id)\"" }
    lines += [
        "",
        "    /// Unicode string.",
        "    var unicode: String {",
        "        let value: UInt32",
        "        switch self {"
    ]
    lines += icons.map { "        case .\($0.name): value = 0x\($0.unicode.capitalizedString)" }
    lines += [
        "        }",
        "        return String(UnicodeScalar(value))",
        "    }",
        "}",
        ""
    ]
    let destination = NSProcessInfo.processInfo().environment["FAGEN_DESTINATION"]!
    try! lines.joinWithSeparator("\n").writeToFile(destination, atomically: true, encoding: NSUTF8StringEncoding)
}
main()
