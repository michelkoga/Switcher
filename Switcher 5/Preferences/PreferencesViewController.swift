//
//  PreferencesViewController.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/10/01.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class PreferencesViewController: NSViewController {
	@IBOutlet weak var shortcutTextField: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
		NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) {
			self.flagsChanged(with: $0)
			return nil
		}
		NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
			self.keyDown(with: $0)
			return nil
		}
		self.title = "Select Shortcut"
		
	}
	// ⌘⇧⌥⌃    ⎋⏎↩︎⏏︎⇥⇤⇪⌤⌦⌫ Space
	var isModifierOnly = false
//	var eventToSet: NSEvent? = nil
	var modifiersEvent: NSEvent.ModifierFlags = []
	var keyCodeEvent: CGKeyCode? = nil
	var released = false
	override func keyDown(with event: NSEvent) {
		print(event.keyCode)
		if isModifierOnly == false {
//			eventToSet = event
			modifiersEvent.insert(event.modifierFlags)
			var modifiers = ""
			switch event.modifierFlags.intersection(.deviceIndependentFlagsMask) {
			case [.shift]:
				modifiers = "⇧ "
			case [.control]:
				modifiers = "⌃ "
			case [.option] :
				modifiers = "⌥ "
			case [.command]:
				modifiers = "⌘ "
			case [.control, .shift]:
				modifiers = "⇧⌃ "
			case [.option, .shift]:
				modifiers = "⇧⌥ "
			case [.command, .shift]:
				modifiers = "⇧⌘ "
			case [.control, .option]:
				modifiers = "⌃⌥ "
			case [.control, .command]:
				modifiers = "⌃⌘ "
			case [.option, .command]:
				modifiers = "⌥⌘ "
			case [.shift, .control, .option]:
				modifiers = "⇧⌥⌃ "
			case [.shift, .control, .command]:
				modifiers = "⇧⌃⌘ "
			case [.control, .option, .command]:
				modifiers = "⌥⌃⌘ "
			case [.shift, .command, .option]:
				modifiers = "⇧⌥⌘ "
			case [.shift, .control, .option, .command]:
				modifiers = "⇧⌥⌃⌘ "
			default:
				break
				//				print("no modifier keys are pressed")
			}
			if !event.modifierFlags.intersection(.deviceIndependentFlagsMask).isEmpty {
				var key = ""
				switch event.keyCode {
				case 53:
					key = "⎋"
				case 48:
					key = "⇥"
				case 51:
					key = "⌫"
				case 49:
					key = "Space"
				case 36:
					key = "↩︎"
				default:
					key = (event.charactersIgnoringModifiers?.capitalized)!
				}
				let set = modifiers + key
				shortcutTextField.stringValue = set
			}
		}
		
	}
	override func flagsChanged(with event: NSEvent) {
//		print("Flags Changed")
		if isModifierOnly {
//			print("Is Modifier Only")
			var modifiers = ""
			if released == true {
				modifiersEvent = []
				print("Reseted")
			}
//			eventToSet = event
			modifiersEvent.insert(event.modifierFlags)
//			eventToSet?.modifierFlags = modifiersEvent
			switch modifiersEvent.intersection(.deviceIndependentFlagsMask) {
			case [.shift]:
				modifiers = "⇧"
			case [.control]:
				modifiers = "⌃"
			case [.option] :
				modifiers = "⌥"
			case [.command]:
				modifiers = "⌘"
			case [.control, .shift]:
				modifiers = "⇧⌃"
			case [.option, .shift]:
				modifiers = "⇧⌥"
			case [.command, .shift]:
				modifiers = "⇧⌘"
			case [.control, .option]:
				modifiers = "⌃⌥"
			case [.control, .command]:
				modifiers = "⌃⌘"
			case [.option, .command]:
				modifiers = "⌥⌘"
			case [.shift, .control, .option]:
				modifiers = "⇧⌥⌃"
			case [.shift, .control, .command]:
				modifiers = "⇧⌃⌘"
			case [.control, .option, .command]:
				modifiers = "⌥⌃⌘"
			case [.shift, .command, .option]:
				modifiers = "⇧⌥⌘"
			case [.shift, .control, .option, .command]:
				modifiers = "⇧⌥⌃⌘"
			default:
				print("no modifier keys are pressed")
			}
			self.shortcutTextField.stringValue = modifiers
			if event.modifierFlags.intersection(.deviceIndependentFlagsMask).isEmpty {
				released = true
				print("All Keys Released")
			} else {
				released = false
			}
		}
		
	}
	// TODO: Override Close button
	@IBAction func modifiersOnlySelectButton(_ sender: NSButton) {
		if sender.state == .off {
			isModifierOnly = false
		} else {
			isModifierOnly = true
		}
		shortcutTextField.stringValue = ""
	}
	
	@IBAction func done(_ sender: Any) {
		// Test
//		let event: NSEvent.ModifierFlags = [.command, .option]
		
		Preferences.changeModifiers(newValues: modifiersEvent)
		
//		do {
//			let data = try NSKeyedArchiver.archivedData(withRootObject: event, requiringSecureCoding: false)
//			UserDefaults.standard.set(data, forKey: "key_event")
//			print("key_event data set success!")
//		} catch {
//			print(error)
//		}
//		UserDefaults.standard.set(keyCodeEvent, forKey: "keyCodeEvent")
	}
	@IBAction func cancel(_ sender: Any) {
		self.view.window?.close()
	}
}
