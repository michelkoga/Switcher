//
//  CloseButton.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/08/01.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class CloseButton: NSButton {
	@IBInspectable var relatedButton: String = ""
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
		self.isHidden = true
    }
    
}
