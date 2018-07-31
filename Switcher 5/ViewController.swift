//
//  ViewController.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/07/31.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
//	var observer: NSKeyValueObservation?
//
//	init() {
//		observer = UserDefaults.standard.observe(\.customizeMode, options: [.initial, .new], changeHandler: { (defaults, change) in
//			print("changed")
//			})
//	}
	// MARK: Variables:
	
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
	
	enum LaunchAppError: Error {
		case invalidApp
	}
	
	fileprivate func drawButtons() {
		for case let button as Button in self.view.subviews {
			if UserDefaults.standard.contains(key: button.character) {
				let appName = UserDefaults.standard.string(forKey: button.character)
				button.image = NSImage(named: NSImage.Name(rawValue: appName!))
			}
			if UserDefaults.standard.bool(forKey: "customizeMode") == true {
				//button.isBordered = true
			} else {
				//button.isBordered = false
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Observer (1) to redraw buttons when change customize mode
		UserDefaults.standard.addObserver(self, forKeyPath: "customizeMode", options: NSKeyValueObservingOptions.new, context: nil)
		// Observer (2) to redraw buttons when app changed
		UserDefaults.standard.addObserver(self, forKeyPath: "appChanged", options: NSKeyValueObservingOptions.new, context: nil)
		NSEvent.addGlobalMonitorForEvents(matching: .flagsChanged) {
			switch $0.modifierFlags.intersection(.deviceIndependentFlagsMask) {
			case [.command, .option]:
				NSApp.activate(ignoringOtherApps: true)
			default:
				break
			}
		}
		NSEvent.addGlobalMonitorForEvents(matching: .keyUp){_ in
			// print("Release Keys") confirmated
			NSApp.hide(nil) // necessário
		}
		NSEvent.addGlobalMonitorForEvents(matching: .leftMouseUp) {_ in
			if UserDefaults.standard.bool(forKey: "customizeMode") == false {
				NSApp.deactivate()
				NSApp.hide(nil)
			}
		}
		
		NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
			self.launchApp(withCharacter: $0.characters!)
			return nil
		}
		UserDefaults.standard.set(false, forKey: "customizeMode")
//		UserDefaults.standard.set("Finder", forKey: "a")
//		UserDefaults.standard.set("Terminal", forKey: "o")
//		UserDefaults.standard.set("Day One", forKey: "e")
//		UserDefaults.standard.set("UlyssesMac", forKey: "u")
//		UserDefaults.standard.set("Bear", forKey: "i")
//		
//		UserDefaults.standard.set("Pixelmator", forKey: "d")
//		UserDefaults.standard.set("Safari", forKey: "h")
//		UserDefaults.standard.set("Xcode-beta", forKey: "t")
//		UserDefaults.standard.set("Sublime Text", forKey: "n")
//		UserDefaults.standard.set("Notes", forKey: "s")
//		UserDefaults.standard.set("Dictionary", forKey: "-")
		
		drawButtons()
	}
	// When observer (1) observe change in customize mode user default, this function will start
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		drawButtons()
		if UserDefaults.standard.bool(forKey: "appChanged") == true {
			UserDefaults.standard.set(false, forKey: "appChanged")
		}
	}
	override var representedObject: Any? {
		didSet {
		print("RepresentedObject")
		}
	}
	// MARK: Actions
	// Button Press Case:
	@IBAction func buttonPressed(_ sender: Button) {
		launchApp(withCharacter: sender.character)
	}
	// MARK: display customize View Controller:
	lazy var customizeViewController: CustomizeViewController = {
		return self.storyboard!.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "customizeView")) as! NSViewController
		}() as! CustomizeViewController
	func displayCustomizeSheet() {
		self.presentViewControllerAsSheet(customizeViewController)
	}
	// MARK: Functions
	func launchApp(withCharacter character: String) {
		if UserDefaults.standard.bool(forKey: "customizeMode") == false {
			if UserDefaults.standard.contains(key: character) {
				let appName = UserDefaults.standard.string(forKey: character)
				NSApp.hide(nil)
				if !NSWorkspace.shared.launchApplication(appName!) {
					print("Couldn't open App: \(appName!)")
				}
			} else {
				print("User Defaults doesn't contains value for \(character)")
				NSApp.deactivate()
				NSApp.hide(nil)
			}
		} else {
			UserDefaults.standard.set(character, forKey: "chosenKey")
			displayCustomizeSheet()
			
		}
	}
}
extension UserDefaults {
	func contains(key: String) -> Bool {
			return UserDefaults.standard.object(forKey: key) != nil
	}
	@objc dynamic var customizeMode: Bool {
		return bool(forKey: "customizeMode")
	}
}
