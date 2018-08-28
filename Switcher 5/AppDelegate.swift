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
		// initialize icon status bar button
		if let button = statusItem.button {
			button.image = NSImage(imageLiteralResourceName: "switcherMenubarIcon")
		}
		constructMenu()
	}
	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}
	
	func constructMenu() {
		let menu = NSMenu()
		
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

