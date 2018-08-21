//
//  UserDefaults.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/08/12.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Foundation

public extension UserDefaults {
	
	func contains(key: String) -> Bool {
			return UserDefaults.standard.object(forKey: key) != nil

	}
	@objc dynamic var customizeMode: Bool {
		return bool(forKey: "customizeMode")
	}
	
	@objc var CustomizeMode: Bool {
		get {
			if UserDefaults.standard.bool(forKey: "customizeMode") == true {
				return true
			} else {
				return false
			}
		}
		set(newValue) {
			if newValue == true {
				UserDefaults.standard.set(true, forKey: "customizeMode")
			} else {
				UserDefaults.standard.set(false, forKey: "customizeMode")
			}
		}
	}
	
	var isCustomizeMode: Bool {
		get {
			if UserDefaults.standard.bool(forKey: "customizeMode") == true {
				return true
			} else {
				return false
			}
		}
		set(newValue) {
			if newValue == true {
				UserDefaults.standard.set(true, forKey: "customizeMode")
			} else {
				UserDefaults.standard.set(false, forKey: "customizeMode")
			}
		}
	}
}
