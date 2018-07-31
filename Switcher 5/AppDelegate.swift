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

	// @property NSWindowController *myController
	let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// initialize icon status bar button
		if let button = statusItem.button {
			button.image = NSImage(named:NSImage.Name("switcherMenubarIcon"))
		}
		constructMenu()
	}
	@objc func customizeMode(_ sender: NSMenuItem) {
		if sender.state == .off {
			UserDefaults.standard.set( true, forKey: "customizeMode")
			sender.state = .on
		} else {
			UserDefaults.standard.set( false, forKey: "customizeMode")
			sender.state = .off
		}
		
	}
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

