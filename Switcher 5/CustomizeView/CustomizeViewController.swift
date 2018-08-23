//
//  CustomizeViewController.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/07/31.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class CustomizeViewController: NSViewController {
	@IBOutlet weak var appsCollectionView: NSCollectionView!
	let customizeMode = "customizeMode"
	var images = ["Safari","Numbers","Pages","Xcode-beta","Finder"]
    override func viewDidLoad() {
        super.viewDidLoad()
		drawButtons()
		if let contentSize = self.appsCollectionView.collectionViewLayout?.collectionViewContentSize {
			self.appsCollectionView.setFrameSize(contentSize)
		}
    }
	fileprivate func drawButtons() {
		for case let button as CustomizeButton in self.view.subviews {
			if let appUrl = UserDefaults.standard.url(forKey: button.character + "Url") {
				button.image = NSImage(byReferencing: appUrl)
			} else {
				if let imageName = UserDefaults.standard.string(forKey: button.character) {
					button.image = NSImage(named: imageName)
				}
			}
		}
	}
	// ***********
	//************
	lazy var lastSelectedButton = CustomizeButton()
	func switchSelectedButton(selectedButton: CustomizeButton) {
		lastSelectedButton.isBordered = false
//		for case let button as CustomizeButton in self.view.subviews {
//			button.isBordered = false
//		}
		selectedButton.isBordered = true
		lastSelectedButton = selectedButton
	}
	@IBAction func setChosenKey(_ sender: CustomizeButton) {
		UserDefaults.standard.set(sender.character, forKey: "chosenKey")
		// TDODO: Make button highlight
		switchSelectedButton(selectedButton: sender)
	}
	
	// Delete Action Button:
	@IBAction func clearButton(_ sender: CloseButton) {
		for case let button as CustomizeButton in self.view.subviews {
			if button.character == sender.relatedButton {
				let appName = button.character
				let imageUrl = button.character + "Url"
				UserDefaults.standard.set("", forKey: appName)
				UserDefaults.standard.set(nil, forKey: imageUrl)
				UserDefaults.standard.set(true, forKey: "appChanged")
				button.image = nil
			}
		}
	
	}
	// Controllers:
	@IBAction func setApp(_ sender: NSButton) {
		if let character = UserDefaults.standard.string(forKey: "chosenKey") {
			UserDefaults.standard.set(sender.image?.name(), forKey: character)
			UserDefaults.standard.set(nil, forKey: character + "Url")
			UserDefaults.standard.set(true, forKey: character + "isController")
			UserDefaults.standard.set(true, forKey: "appChanged")
			drawButtons()
		}
	}
	
	// Apps inside collection:
	@IBAction func selectApp(_ sender: ButtonInsideCollection) {
		if sender.appName != "" {
			let url = sender.url
			let character = UserDefaults.standard.string(forKey: "chosenKey")!
			UserDefaults.standard.set(sender.appName, forKey: character)
			UserDefaults.standard.set(url, forKey: character + "Url")
			UserDefaults.standard.set(false, forKey: character + "isController")
			UserDefaults.standard.set(true, forKey: "appChanged")
			drawButtons()
		} else {
			print("App don't have a name.")
		}
	}
	
	@IBAction func dismissModal(_ sender: Any) {
		UserDefaults.standard.set(false, forKey: customizeMode)
		self.dismiss(self)
	}
}

extension CustomizeViewController: NSCollectionViewDataSource {
	static let item = "CollectionViewItem"
	static let apps = AppsLoader.getIconsAndUrlsFromApplicationsFolders()
	
	func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
		return CustomizeViewController.apps.count
	}
	func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
		
		
		
		
		
		
		
		let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: CustomizeViewController.item), for: indexPath) as! CollectionViewItem
		let app = CustomizeViewController.apps[indexPath.item]
		item.button.image = NSImage(byReferencing: app.url)
		item.label.stringValue = app.appName
		item.button.appName = app.appName
		item.button.url = app.url
		item.button.image?.size = NSSize(width: 80, height: 80) // Adjust the size of the image
		return item
	}
}
