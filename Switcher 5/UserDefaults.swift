//
//  UserDefaults.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/08/12.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Foundation

extension ViewController {
	enum Custom {
		case off
		case on
	}
	var customizeMode: Custom {
		get {
			if UserDefaults.standard.bool(forKey: "customizeMode") == true {
				return .on
			} else {
				return .off
			}
		}
		set(newValue) {
			print(newValue)
			switch newValue {
			case .off:
				UserDefaults.standard.set(false, forKey: "customizeMode")
			case .on:
				UserDefaults.standard.set(true, forKey: "customizeMode")
			}
			
		}
	}

}
