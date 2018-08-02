//
//  CustomizeViewController.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/07/31.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class CustomizeViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//		drawButtons()
    }
	@IBAction func setApp(_ sender: NSButton) {
		let character = UserDefaults.standard.string(forKey: "chosenKey")
		UserDefaults.standard.set(sender.image?.name(), forKey: character!)
		UserDefaults.standard.set(true, forKey: "appChanged")
		self.dismiss(self)
	}
//	fileprivate func drawButtons() {
//		for case let button as CustomizeButton in self.view.subviews {
//			if button.tag != 1 {
//				let appName = button.appName
//				button.image = NSImage(named: NSImage.Name(rawValue: appName))
//			}
//
//		}
//	}
	@IBAction func removeApp(_ sender: NSButton) {
		let character = UserDefaults.standard.string(forKey: "chosenKey")
		UserDefaults.standard.set("", forKey: character!)
		UserDefaults.standard.set(true, forKey: "appChanged")
		self.dismiss(self)
	}
}
