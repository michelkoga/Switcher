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
	let customizeMode = "customizeMode"
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		//Observer(1) to changes in customize mode
		UserDefaults.standard.addObserver(self, forKeyPath: "customizeMode", options: NSKeyValueObservingOptions.new, context: nil)
		// initialize icon status bar button
		if let button = statusItem.button {
			button.image = NSImage(named:"switcherMenubarIcon")
		}
		constructMenu()
	}
	@objc func customizeMode(_ sender: NSMenuItem) {
//		let customizeMode = UserDefaults.standard.bool(forKey: "customizeMode")
		if !UserDefaults.standard.bool(forKey: customizeMode) {
			UserDefaults.standard.set(true, forKey: customizeMode)
			sender.state = .on
		} else {
			UserDefaults.standard.set(false, forKey: customizeMode)
			sender.state = .off
		}
		
	}
	// When observer(1) observe change in customize mode user default, this function will start
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if UserDefaults.standard.bool(forKey: customizeMode) {
			statusItem.menu?.items[0].state = .on // This is the first item in Menu
		} else {
			statusItem.menu?.items[0].state = .off
		}
	}
	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}
	
	func constructMenu() {
		let menu = NSMenu()
		
		menu.addItem(NSMenuItem(title: "Customize", action: #selector(AppDelegate.customizeMode(_:)), keyEquivalent: "c"))
		menu.addItem(NSMenuItem.separator())
		menu.addItem(NSMenuItem(title: "Refresh", action: #selector(AppDelegate.restart(_:)), keyEquivalent: "r"))
		menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
		
		statusItem.menu = menu
	}
	@objc func restart(_ sender: NSMenuItem) {
		let url = URL(fileURLWithPath: Bundle.main.resourcePath!)
		let path = url.deletingLastPathComponent().deletingLastPathComponent().absoluteString
		let task = Process()
		task.launchPath = "/usr/bin/open"
		task.arguments = [path]
		task.launch()
		exit(0)
	}
}

