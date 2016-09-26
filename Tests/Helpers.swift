//
//  Helpers.swift
//
//  Created by Brian King on 8/29/16.
//  Copyright © 2016 Raizlabs. All rights reserved.
//

import BonMot
import XCTest

#if os(OSX)
#else
    import UIKit
#if swift(>=3.0)
    let titleTextStyle = UIFontTextStyle.title1
    @available(iOS 10.0, *)
    let largeTraitCollection = UITraitCollection(preferredContentSizeCategory: .large)
#elseif swift(>=2.3)
    let titleTextStyle = UIFontTextStyleTitle1
    @available(iOS 10.0, *)
    let largeTraitCollection = UITraitCollection(preferredContentSizeCategory: UIContentSizeCategoryLarge)
#else
    let titleTextStyle = UIFontTextStyleTitle1
 #endif
#endif

#if swift(>=3.0)
    extension BONColor {
        static var colorA: BONColor {
            return red
        }
        static var colorB: BONColor {
            return red
        }
    }
#else
    extension BONColor {
        static var colorA: BONColor {
            return redColor()
        }
        static var colorB: BONColor {
            return redColor()
        }
    }
#endif

extension BONFont {
    static var fontA: BONFont {
        return BONFont(name: "Avenir-Roman", size: 30)!
    }
    static var fontB: BONFont {
        return BONFont(name: "Avenir-Roman", size: 20)!
    }
}

let styleA = BonMot(
    .font(.fontA),
    .textColor(.colorA)
)

let styleB = BonMot(
    .font(.fontB),
    .textColor(.colorB),
    .headIndent(10),
    .tailIndent(10)
)

#if os(OSX)
#else
let adaptiveStyle = BonMot(
    .font(.fontA),
    .textColor(.colorA),
    .adapt(.body)
)
#endif

let styleBi = BonMotI(
    font: .fontB,
    textColor: .colorB,
    headIndent: 10,
    tailIndent: 10
)

let styleBz = BonMotC { style in
    style.font = .fontB
    style.textColor = .colorB
    style.headIndent = 10
    style.tailIndent = 10
}

class EBGarandLoader: NSObject {

    static func loadFontIfNeeded() {
        let _ = loadFont
    }

    // Can't include font the normal (Plist) way for logic tests, so load it the hard way
    // Source: http://stackoverflow.com/questions/14735522/can-i-embed-a-custom-font-in-a-bundle-and-access-it-from-an-ios-framework
    // Method: https://marco.org/2012/12/21/ios-dynamic-font-loading
    static var loadFont: Void = {
        #if swift(>=3.0)
        guard let path = Bundle(for: EBGarandLoader.self).path(forResource: "EBGaramond12-Regular", ofType: "otf"),
            let data = NSData(contentsOfFile: path)
            else {
                fatalError("Can not load EBGaramond12")
        }
        guard let provider = CGDataProvider(data: data) else {
            fatalError("Can not create provider")
        }

        #if swift(>=2.3)
            let fontRef = CGFont(provider)
        #else
            guard let fontRef = CGFontCreateWithDataProvider(provider) else {
            fatalError("Can not create CGFont")
            }
        #endif
        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(fontRef, &error)
        if let error = error {
            fatalError("Unable to load font: \(error)")
        }
        #else
            guard let path = NSBundle(forClass: EBGarandLoader.self).pathForResource("EBGaramond12-Regular", ofType: "otf"),
            let data = NSData(contentsOfFile: path)
            else {
            fatalError("Can not load EBGaramond12")
            }
            guard let provider = CGDataProviderCreateWithCFData(data) else {
            fatalError("Can not create provider")
            }

            #if swift(>=2.3)
            let fontRef = CGFontCreateWithDataProvider(provider)
            #else
            guard let fontRef = CGFontCreateWithDataProvider(provider) else {
            fatalError("Can not create CGFont")
            }
            #endif
            var error: Unmanaged<CFError>?
            CTFontManagerRegisterGraphicsFont(fontRef, &error)
            if let error = error {
            fatalError("Unable to load font: \(error)")
            }
        #endif
        return ()
    }()
}

extension NSAttributedString {

    func rangesFor<T>(attribute name: String) -> [String: T] {
        var attributesByRange: [String: T] = [:]
        enumerateAttribute(name, in: NSRange(location: 0, length: length), options: []) { value, range, stop in
            if let object = value as? T {
                attributesByRange["\(range.location):\(range.length)"] = object
            }
        }
        return attributesByRange
    }

}

#if swift(>=3.0)
#else
extension XCTestCase {
    func measure(block: () -> Void) {
        measureBlock(block)
    }
}
#endif