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
		// Refresh when monitor chage(eg. from mac screen to extended monitor) to avoid uncentered view:
		NotificationCenter.default.addObserver(forName: NSApplication.didChangeScreenParametersNotification,
											   object: NSApplication.shared,
											   queue: OperationQueue.main) {
												notification -> Void in
												self.restarting()
		}
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
		restarting()
	}
	func restarting() {
		let url = URL(fileURLWithPath: Bundle.main.resourcePath!)
		let path = url.deletingLastPathComponent().deletingLastPathComponent().absoluteString
		let task = Process()
		task.launchPath = "/usr/bin/open"
		task.arguments = [path]
		task.launch()
		exit(0)
	}
}

