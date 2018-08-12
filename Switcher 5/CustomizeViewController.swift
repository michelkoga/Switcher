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
    }
	
	@IBAction func setApp(_ sender: NSButton) {
		let character = UserDefaults.standard.string(forKey: "chosenKey")
		UserDefaults.standard.set(sender.image?.name(), forKey: character!)
		UserDefaults.standard.set(true, forKey: "appChanged")
		self.dismiss(self)
	}
	
	@IBAction func dismissModal(_ sender: Any) {
		self.dismiss(self)
	}
}
