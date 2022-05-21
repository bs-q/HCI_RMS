import UIKit


/**
 Ref:
    + https://stackoverflow.com/questions/62316572/how-to-use-a-custom-font-in-an-entire-ios-app-the-right-way
 
 Step:
    - Add Font to resource
    - Declare on info.split
    - Check font has load (Call on AppDelete func: didFinishLaunchingWithOptions):
        -> UIFont.showAllSystemFont()
    - Delclare AppFontName struct (bellow)
    - Call on AppDelete func: didFinishLaunchingWithOptions
        ->  UIFont.overrideInitialize()
 
 Override system font if not set
     SF Compact Display
     == SFCompactDisplay-Regular
     == SFCompactDisplay-Bold
     SF Pro Display
     == SFProDisplay-Italic
     == SFProDisplay-BoldItalic
 */
struct AppFontName {
    static let regular = "SFCompactDisplay-Regular"
    static let bold = "SFCompactDisplay-Bold"
    static let boldItablic = "SFProDisplay-BoldItalic"
    static let italic = "SFProDisplay-Italic"
}
//customise font
extension UIFontDescriptor.AttributeName {
  static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont{
    
    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
            return UIFont(name: AppFontName.regular, size: size)!
      }

      @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
            return UIFont(name: AppFontName.bold, size: size)!
      }

      @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
            return UIFont(name: AppFontName.italic, size: size)!
      }

    @objc class func myBoldItalicSystemFont(ofSize size: CGFloat) -> UIFont {
          return UIFont(name: AppFontName.boldItablic, size: size)!
    }

      @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
            self.init(myCoder: aDecoder)
            return
        }
        var fontName = ""
        switch fontAttribute {
        case "CTFontRegularUsage":
            fontName = AppFontName.regular
        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
            fontName = AppFontName.bold
        case "CTFontObliqueUsage":
                fontName = AppFontName.italic
        default:
            fontName = AppFontName.regular
        }
        self.init(name: fontName, size: fontDescriptor.pointSize)!
      }

    
    class func overrideInitialize() {
        guard self == UIFont.self else { return }

        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }

        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
        }

        if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:))) {
            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
        }

        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
      }
    
    
    /**
         SF Compact Display
         == SFCompactDisplay-Regular
         == SFCompactDisplay-Bold
         SF Pro Display
         == SFProDisplay-Italic
         == SFProDisplay-BoldItalic
     */
    public func showAllSystemFont(){
        for family: String in UIFont.familyNames
         {
             print("\(family)")
             for names: String in UIFont.fontNames(forFamilyName: family)
             {
                    print("== \(names)")
             }
         }
    }
}



