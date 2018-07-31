//
//  AppDelegate.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/07/31.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
	let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Observer (1) to redraw buttons when change customize mode
//		UserDefaults.standard.addObserver(self, forKeyPath: "appChanged", options: NSKeyValueObservingOptions.new, context: nil)
		// initialize icon status bar button
		if let button = statusItem.button {
			button.image = NSImage(named:NSImage.Name("switcherMenubarIcon"))
		}
		constructMenu()
	}
	@objc func customizeMode(_ sender: NSMenuItem) {
		let customizeMode = UserDefaults.standard.bool(forKey: "customizeMode")
		if customizeMode == false {
			UserDefaults.standard.set(true, forKey: "customizeMode")
			sender.state = .on
		} else {
			UserDefaults.standard.set( false, forKey: "customizeMode")
			sender.state = .off
		}
		
	}
	// When observer (1) observe change in customize mode user default, this function will start
//	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//		let appChanged = UserDefaults.standard.bool(forKey: "appChanged")
//		if appChanged {
//			for item in (statusItem.menu?.items)! {
//				item.state = .off
//			}
//		}
//	}
	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}
	
	func constructMenu() {
		let menu = NSMenu()
		
		menu.addItem(NSMenuItem(title: "Customize", action: #selector(AppDelegate.customizeMode(_:)), keyEquivalent: "s"))
		menu.addItem(NSMenuItem.separator())
		menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
		
		statusItem.menu = menu
	}
}

