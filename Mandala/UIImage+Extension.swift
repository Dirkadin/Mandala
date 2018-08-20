//
//  UIImage+Extension.swift
//  Mandala
//
//  Created by Dirk on 8/20/18.
//  Copyright © 2018 Dirk. All rights reserved.
//

import UIKit

enum ImageResource: String {
	case angry
	case confused
	case crying
	case goofy
	case happy
	case meh
	case sad
	case sleepy
}

extension UIImage {
	
	convenience init(resource: ImageResource) {
		self.init(named: resource.rawValue)!
	}
	
}
