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
		NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
			self.launchApp(withCharacter: $0.characters!)
			return nil
		}
		UserDefaults.standard.set("Finder", forKey: "a")
		UserDefaults.standard.set("Terminal", forKey: "o")
		UserDefaults.standard.set("Day One", forKey: "e")
		UserDefaults.standard.set("UlyssesMac", forKey: "u")
		UserDefaults.standard.set("Bear", forKey: "i")
		
		UserDefaults.standard.set("Pixelmator", forKey: "d")
		UserDefaults.standard.set("Safari", forKey: "h")
		UserDefaults.standard.set("Xcode-beta", forKey: "t")
		UserDefaults.standard.set("Sublime Text", forKey: "n")
		UserDefaults.standard.set("Notes", forKey: "s")
		UserDefaults.standard.set("Dictionary", forKey: "-")
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}
	// MARK: Actions
	// Key Press Case:
	func keyDown(with keyName: String) {
		print("Key Down")
	}
	// Button Press Case:
	@IBAction func buttonPressed(_ sender: Button) {
		launchApp(withCharacter: sender.character)
	}
	
	// MARK: Functions
//	func launchApp(withAppName appName: String) {
//		//NSApp.hide(nil)
//		NSWorkspace.shared.launchApplication(appName)
//	}
	func launchApp(withCharacter character: String) {
		if UserDefaults.standard.contains(key: character) {
			print("User Defaults Contain Value for \(character)")
			let appName = UserDefaults.standard.string(forKey: character)
			print("Opening \(appName!)")
			NSWorkspace.shared.launchApplication(appName!)
		} else {
			print("User Defaults doesn't contains value for \(character)")
		}
	}
	
}
extension UserDefaults {
	func contains(key: String) -> Bool {
			return UserDefaults.standard.object(forKey: key) != nil
	}
}
