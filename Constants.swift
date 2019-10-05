//
//  Constants.swift
//  Math4Kids
//
//  Created by summer on 2019/7/30.
//  Copyright © 2019 summer. All rights reserved.
//

import UIKit

struct Colors {
    //    /// Used for background color
    //    static let pink = UIColor(red: 255/255, green: 200/255, blue: 255/255, alpha: 1.0)
    //    /// Used for title text
    //    static let red = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
    //    /// Used for buttons and question text
    //    static let aqua = UIColor(red: 40/255, green: 150/255, blue: 255/255, alpha: 1.0)
    //    /// Used for "Shuffle All" button, so it is different
    //    // TODO: Figure out a better way to darken the color already used (which is aqua, above)
    //    static let blue = UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1.0)
    //    /// Used for button text
    //    static let white = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    
    
    static let backgroundGradientTop = UIColor(named: "backgroundGradientTop")!
    static let backgroundGradientBottom = UIColor(named: "backgroundGradientBottom")!
    
    static let buttonGradientTop = UIColor(named: "buttonGradientTop")!
    static let buttonGradientBottom = UIColor(named: "buttonGradientBottom")!
    
    static let rightLabelColor = UIColor(named: "rightLabelColor")!
    static let wrongLabelColor = UIColor(named: "wrongLabelColor")!
}

struct FontNames {
    // TODO: Make font name and size separate so I can specify a font and different sizes for different places? Use a struct for the name string everywhere used?
    static let chalkduster = "Chalkduster"
}
