//
//  AppThemeProtocol.swift
//  Discussion App Design
//
//  Created by Hossam on 9/14/20.
//  Copyright © 2020 Hossam. All rights reserved.
//

import UIKit

protocol AppThemeProtocol {
  var lightTheme: UIColor { get }
  var darkTheme: UIColor { get }
}

extension UIColor {
     enum AppColor: AppThemeProtocol {
       
        case appBackground1
        case appBackground2
        case textColor
        case secondaryTextColor
        case iconColor
        case borderColor
        
        var lightTheme: UIColor {
            switch self {
            case .appBackground1:
                return UIColor.white
            case .appBackground2:
                return UIColor(white: 0, alpha: 0.03)
            case .textColor:
                return UIColor.black
            case .secondaryTextColor:
                return UIColor(white: 0, alpha: 0.6)
            case .iconColor:
                return UIColor(red: 159/255, green: 159/255, blue: 159/255, alpha: 1)
            case .borderColor:
                return UIColor(white: 0, alpha: 0.1)
            }
        }

        var darkTheme: UIColor {
            switch self {
            case .appBackground1:
                return UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
            case .appBackground2:
                return UIColor(red: 21/255, green: 24/255, blue: 29/255, alpha: 1)
            case .textColor:
                return UIColor.white
            case .secondaryTextColor:
                return UIColor.white
            case .iconColor:
                return UIColor.white
            case .borderColor:
                return UIColor(white: 1, alpha: 0.4)
            }
        }
        
     }
     
     // Add business logic here, depending to use case.
     static func dynamicColor(_ color: AppColor) -> UIColor {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return color.darkTheme
                } else {
                    return color.lightTheme
                }
            }
        } else {
            return color.lightTheme
        }
    }
}
