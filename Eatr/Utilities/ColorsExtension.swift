//
//  ColorsExtension.swift
//  Eatr
//
//  Created by Agustio Maitimu on 11/04/25.
//

import SwiftUI
import UIKit

extension Color {
	public static var orangeEatr: Color {
		return Color(red: 224/255, green: 122/255, blue: 95/255)
	}
	
	public static var peachEatr: Color {
		return Color(red: 241/255, green: 227/255, blue: 211/255)
	}
	
	public static var burgundyEatr: Color {
		return Color(red: 105/255, green: 11/255, blue: 34/255)
	}
	
	public static var primaryGreenEatr: Color {
		return Color(red: 0/255, green: 128/255, blue: 0/255)
	}
	
	static func random(randomOpacity: Bool = false) -> Color {
		Color(
			red: .random(in: 0...1),
			green: .random(in: 0...1),
			blue: .random(in: 0...1),
			opacity: randomOpacity ? .random(in: 0...1) : 1
		)
	}

}

extension UIColor {
	static var orangeEatr: UIColor {
		return UIColor(red: 224/255, green: 122/255, blue: 95/255, alpha: 1.0)
	}
	
	static var peachEatr: UIColor {
		return UIColor(red: 241/255, green: 227/255, blue: 211/255, alpha: 1.0)
	}
	
	static var burgundyEatr: UIColor {
		return UIColor(red: 105/255, green: 11/255, blue: 34/255, alpha: 1.0)
	}
	
	static var primaryGreenEatr: UIColor {
		return UIColor(red: 0/255, green: 128/255, blue: 0/255, alpha: 1.0)
	}
	
	static var secondaryGreenEatr: UIColor {
		return UIColor(red: 0/255, green: 128/255, blue: 0/255, alpha: 0.2)
	}
}
