//
//  ViewController.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/07/31.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
	// MARK: Variables:
	var preferences = UserDefaults.standard
//	var customizeMode = "customizeMode"
	enum customize: String {
		case on = "true"
		case off = "false"
	}
	
//	enum preferences.
	
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
			if self.preferences.contains(key: button.character) {
				if !UserDefaults.standard.bool(forKey: "isController") {
					if let appUrl = UserDefaults.standard.url(forKey: button.character + "Url") {
						button.image = NSImage(byReferencing: appUrl)
						button.image?.size = NSSize(width: 80, height: 80)
					}
				} else {
					if let imageName = UserDefaults.standard.string(forKey: button.character) {
						button.image = NSImage(named: imageName)
					}
				}
			}
			if UserDefaults.standard.isCustomizeMode {
				button.isBordered = true
			} else {
				button.isBordered = false
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		let workspace = NSWorkspace()
		let icon = workspace.icon(forFile: "/Applications/App Store.app/Contents/Resources/AppIcon.icns")
		self.buttonA.image = icon
		
		// Observer (1) to redraw buttons when change customize mode
		preferences.addObserver(self, forKeyPath: "customizeMode", options: NSKeyValueObservingOptions.new, context: nil)
		// Observer (2) to redraw buttons when app changed
		preferences.addObserver(self, forKeyPath: "appChanged", options: NSKeyValueObservingOptions.new, context: nil)
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
			if !UserDefaults.standard.isCustomizeMode {
				NSApp.deactivate()
				NSApp.hide(nil)
			}
		}
		
		NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
			if UserDefaults.standard.isCustomizeMode {
				if $0.keyCode == 53 {
					NSApp.deactivate()
					NSApp.hide(nil)
				} else {
					let character = $0.characters!
					self.launchApp(withCharacter: character)
				}
			} else { // customizeMode is true:
				if $0.keyCode == 53 {
					UserDefaults.standard.isCustomizeMode = false
				} else {
					let character = $0.characters!
					self.launchApp(withCharacter: character)
				}
			}
			return nil
		}
		
		UserDefaults.standard.isCustomizeMode = false
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
		if preferences.bool(forKey: "appChanged") == true {
			preferences.set(false, forKey: "appChanged")
		}
		for case let closeButton as CloseButton in self.view.subviews {
			if UserDefaults.standard.isCustomizeMode {
				closeButton.isHidden = false
			} else {
				closeButton.isHidden = true
			}
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
		return self.storyboard!.instantiateController(withIdentifier: "customizeView") as! NSViewController
		}() as! CustomizeViewController
	func displayCustomizeSheet() {
		self.presentAsSheet(customizeViewController)
	}
	// Delete Action Button:
	@IBAction func deleteApp(_ sender: CloseButton) {
		for case let button as Button in self.view.subviews {
			if button.character == sender.relatedButton {
				button.image = nil
				preferences.set("", forKey: button.character)
				preferences.set(nil, forKey: button.character + "Url")
			}
		}
	}
	@IBAction func toggleCustomizeMode(_ sender: Any) {
		if UserDefaults.standard.isCustomizeMode {
			UserDefaults.standard.isCustomizeMode = false
		} else {
			UserDefaults.standard.isCustomizeMode = true
		}
	}
	
	// MARK: Functions
	func launchApp(withCharacter character: String) {
		if !UserDefaults.standard.isCustomizeMode {
			if preferences.contains(key: character) {
				let appName = preferences.string(forKey: character)
				print("Trying open \(appName!)")
				if UserDefaults.standard.bool(forKey: "isController") {
					executeControl(with: appName!)
					// NSApp.hide(nil)
				} else {
					NSApp.hide(nil)
					if !NSWorkspace.shared.launchApplication(appName!) {
						print("Couldn't open App: \(appName!)")
					}
				}
			} else {
				print("User Defaults doesn't contains value for \(character)")
				NSApp.deactivate()
				NSApp.hide(nil)
			}
		} else {
			// This will avoid set applications in modifiers, esc, tab and keys I dont want to set:
			switch character {
			case "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
				 "0","1","2","3","4","5","6","7","8","9",
				 "-","[",";","'",",",".","/":
				preferences.set(character, forKey: "chosenKey")
				displayCustomizeSheet()
			default:
				
				break
			}
			
		}
	}
	
}
