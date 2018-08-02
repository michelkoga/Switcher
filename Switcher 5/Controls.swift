//
//  Controls.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/08/02.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Foundation

extension String {
	var isController: Bool {
		switch self {
		case "Input Sources":
			return true
		default:
			return false
		}
	}
}

extension ViewController {
	
	func executeControl(with controlName: String) {
		switch controlName {
		case "Input Sources":
			switchInputSource()
		default:
			break
		}
	}
	
	func switchInputSource() {
		let inputSourceScript = "tell application \"System Events\" to key code 49 using control down"
		var error: NSDictionary?
		if let scriptObject = NSAppleScript(source: inputSourceScript) {
			if let outputString = scriptObject.executeAndReturnError(&error).stringValue {
				print(outputString.description)
			} else if (error != nil) {
				print("Error: ", error!)
			}
		}
	}
}
