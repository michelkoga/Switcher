//
//  ViewController.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/07/31.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
	var modifiers: NSEvent.ModifierFlags = [.command, .shift, .option, .control]
//	lazy var apps = []()
	let chosenKey = "chosen_key"
	let customizeMode = "customize_mode"
	let isController = "is_controller"
	let appChanged = "app_changed"
	let customizeViewIdentifier = "customize_view_identifier"
	let url = "_url"
	
	fileprivate func drawRunningAppIndicator() {  //??
		let runningApps = NSWorkspace.shared.runningApplications
		for case let button as MainButton in self.view.subviews {
			for app in runningApps {
				if button.appName == app.localizedName {
					button.isRunning = true
					break
				}
				//				button.isRunning = false
			}
		}
	}
	fileprivate func drawRunningAppIndicator(with runningApps: [NSRunningApplication]) {  //??
		for case let button as MainButton in self.view.subviews {
			for app in runningApps {
				if button.appName == app.localizedName {
					button.isRunning = true
					break
				}
				//				button.isRunning = false
			}
		}
	}
	fileprivate func showRunningApplicationIndicator(with runningApp: String) {  //??
		for case let button as MainButton in self.view.subviews {
			if button.appName == runningApp {
				button.isRunning = true
				break
			}
		}
	}
	fileprivate func hideRunningApplicationIndicator(with runningApp: String) {  //??
		for case let button as MainButton in self.view.subviews {
			if button.appName == runningApp {
				button.isRunning = false
				break
			}
		}
	}
	
	fileprivate func drawButtons() {
		for case let button as MainButton in self.view.subviews {
			let buttonIsController = button.character + isController
			if !UserDefaults.standard.bool(forKey: buttonIsController) {
				if let appUrl = UserDefaults.standard.url(forKey: button.character + url) {
					button.image = NSImage(byReferencing: appUrl)
				} else {
					button.image = nil
				}
			} else {
				if let imageName = UserDefaults.standard.string(forKey: button.character) {
					button.image = NSImage(imageLiteralResourceName: imageName)
				}
			}
		}
	}
	
	static var apps = AppsLoader.getIconsAndUrlsFromApplicationsFolders()
	override func viewDidLoad() {
		super.viewDidLoad()
		if CustomizeViewController.appTuple == nil {
			CustomizeViewController.appTuple = AppsLoader.getIconsAndUrlsFromApplicationsFolders()
		}
		self.view.layer?.cornerRadius = 15
		// Observer (1) to redraw buttons when change customize mode
		UserDefaults.standard.addObserver(self, forKeyPath: customizeMode, options: NSKeyValueObservingOptions.new, context: nil)
		// Observer (2) to redraw buttons when app changed
		UserDefaults.standard.addObserver(self, forKeyPath: appChanged, options: NSKeyValueObservingOptions.new, context: nil)
		NSEvent.addGlobalMonitorForEvents(matching: .flagsChanged) {
//			do {
//				let data = UserDefaults.standard.object(forKey: "key_event")
//				let eventToSet = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as! Data) as! NSEvent
////				self.modifiers = eventToSet.modifierFlags
//				print("modifiersEvent retrieved")
//				
//			} catch {
//				print(error)
//			}
			switch $0.modifierFlags.intersection(.deviceIndependentFlagsMask) {
			case Preferences.modifiers:
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
			NSApp.deactivate()
			NSApp.hide(nil)
		}
		
		NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
			if UserDefaults.standard.bool(forKey: self.customizeMode) {
				if $0.keyCode == 53 {
					NSApp.deactivate()
					NSApp.hide(nil)
				} else {
					let character = $0.characters!
					self.launchApp(withCharacter: character)
				}
			} else { // customizeMode is true:
				if $0.keyCode == 53 {
					UserDefaults.standard.set(true, forKey: self.customizeMode)
				} else {
					let character = $0.characters!
					self.launchApp(withCharacter: character)
				}
			}
			return nil
		}
		
		UserDefaults.standard.set(false, forKey: customizeMode)
		
		drawButtons()
	}
	// When observer (1) observe change in customize mode user default, this function will start
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		drawButtons()
		if UserDefaults.standard.bool(forKey: appChanged) {
			UserDefaults.standard.set(false, forKey: appChanged)
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
		return self.storyboard!.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(customizeViewIdentifier)) as! NSViewController
		}() as! CustomizeViewController
	func displayCustomizeSheet() {
		self.presentAsSheet(customizeViewController)
//		self.presenting?.presentViewControllerAsSheet(customizeViewController)
	}
	@IBAction func toggleCustomizeMode(_ sender: Any) {
		UserDefaults.standard.set(false, forKey: appChanged)
		UserDefaults.standard.set(true, forKey: customizeMode)
		displayCustomizeSheet()
	}
	
	// MARK: Functions
	func launchApp(withCharacter character: String) {
		if !UserDefaults.standard.bool(forKey: customizeMode) {
			if let appName = UserDefaults.standard.string(forKey: character) {
				if appName == "" { return }
				if UserDefaults.standard.bool(forKey: isController) {
					executeControl(with: appName)
					// NSApp.hide(nil)
				} else {
					NSApp.hide(nil)
					if !NSWorkspace.shared.launchApplication(appName) {
						print("Couldn't open App: \(appName)")
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
				UserDefaults.standard.set(character, forKey: chosenKey)
				displayCustomizeSheet()
			default:
				
				break
			}
			
		}
	}
	
}
