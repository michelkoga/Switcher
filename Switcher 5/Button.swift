//
//  Button.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/07/31.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class Button: NSButton {
	
	@IBInspectable var keyName: String = ""
	@IBInspectable var appName: String = ""
	
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
}
