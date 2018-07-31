//
//  ViewController.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/07/31.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

	@IBOutlet weak var buttonA: Button!
	@IBOutlet weak var buttonS: Button!
	@IBOutlet weak var buttonD: Button!
	@IBOutlet weak var buttonF: Button!
	@IBOutlet weak var buttonG: Button!
	@IBOutlet weak var buttonH: Button!
	@IBOutlet weak var buttonJ: Button!
	@IBOutlet weak var buttonK: Button!
	@IBOutlet weak var buttonL: Button!
	@IBOutlet weak var buttonSemicolon: Button!
	@IBOutlet weak var buttonQuote: Button!
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}
	// MARK: Actions
	// Button Press Case:
	@IBAction func buttonPressed(_ sender: Button) {
		launchApp(withAppName: sender.appName)
	}
	// Key Press Case:
	
	
	// MARK: Functions
	func launchApp(withAppName appName: String) {
		NSApp.hide(nil)
		NSWorkspace.shared.launchApplication(appName)
	}
	
}

