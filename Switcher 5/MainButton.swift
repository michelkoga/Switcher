//
//  MainButton.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/08/23.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class MainButton: Button {
	var isRunning = false
	var appName = ""
	let accentColor = NSColor.controlColor
	override func draw(_ dirtyRect: NSRect) {
		super.draw(dirtyRect)
		if self.character == "f" || self.character == "j" {
			let jfKeyBumps = NSBezierPath()
			jfKeyBumps.lineWidth = 6
			jfKeyBumps.lineCapStyle = .round
			jfKeyBumps.move(to: CGPoint(x: 40, y: 96))
			jfKeyBumps.line(to: CGPoint(x: 60, y: 96))
			accentColor.setStroke()
			//			NSColor.init(calibratedWhite: 0.9, alpha: 0.8).setStroke()
			jfKeyBumps.stroke()
		}
		
		
		if isRunning == true {
			drawRunningIndicator()  //??
		}
		//		drawRunningIndicator()
		
		// (M)Tracking mouse:
		let area = NSTrackingArea.init(rect: self.bounds, options: [.mouseEnteredAndExited, .activeAlways], owner: self, userInfo: nil)
		self.addTrackingArea(area)
	}
	func drawRunningIndicator() {
		let fillColor = accentColor
		let circleRect = NSRect(x: 45, y: 90, width: 10, height: 10)
		let path = NSBezierPath(ovalIn: circleRect)
		fillColor.setFill()
		path.fill()
	}
	// (M)Tracking Mouse:
	override func mouseEntered(with event: NSEvent) {
		self.layer?.backgroundColor = NSColor.controlLightHighlightColor.cgColor
	}
	override func mouseExited(with event: NSEvent) {
		self.layer?.backgroundColor = CGColor.clear
	}
}
