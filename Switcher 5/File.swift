//
//  File.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/08/21.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Foundation
class Loader {
	
	let appStoreURL = URL(fileURLWithPath: "/Applications/App Store.app/Contents/Resources/AppIcon.icns")
	let appStorePath = "/Applications/App Store.app/Contents/Resources/AppIcon.icns"
	//let convertToString = appStorePath.file
	//let convert = convertToString.replacingOccurrences(of: "%20", with: " ")
	let fileManager = FileManager.default
	//try fileManager.contentsOfDirectory(atPath: applicationUrl.path)
	
	
	
	// 1. Get all files ***************************************************************************
	static func contentsOf(folder: URL) -> [URL] {
		let applicationUrl = URL(fileURLWithPath: "/Applications/")
		let fileManager = FileManager.default
		
		do {
			let contents = try fileManager.contentsOfDirectory(atPath: folder.path)
			
			let urls = contents.map { return folder.appendingPathComponent($0) }
			return urls
		} catch {
			return []
		}
	}
	//let urls = contentsOf(folder: applicationUrl)
	
	// 2. Filter to Apps only *************************************************************************
	static func filterToApplicationsOnly(of strings: [URL]) -> [URL] {
		var newArray = [URL]()
		for string in strings {
			let lastPath = string.lastPathComponent
			if lastPath.range(of: ".app") != nil {
				newArray.append(string)
			}
		}
		return newArray
	}
	// let onlyAppsUrl = filterToApplicationsOnly(of: urls)
	// 3.-1 Check if icon path exists ******************************************************************************
	static func checkIfContentsResourcesPathExists(path: String) -> Bool {
		let fileManager = FileManager()
		if fileManager.fileExists(atPath: path) {
			return true
		} else {
			print("\(path) path doesn't exist")
		}
		return false
	}
	//let checkTest = checkIfContentsResourcesPathExists(path: "/Applications/iBooks.app/Contents/Resources/")
	// 3 Append "Contents/Resources/" ***************************
	static func appendIconPath(urls: [URL]) -> [URL] {
		var extendedUrls = [URL]()
		let extraPath = "Contents/Resources/"
		for url in urls {
			let extendedUrl = url.appendingPathComponent(extraPath)
			if checkIfContentsResourcesPathExists(path: extendedUrl.path) {
				extendedUrls.append(extendedUrl)
			} else {
				print("This path doesn't exist: \(extendedUrl)")
			}
		}
		return extendedUrls
	}
	//let extendedPaths = appendIconPath(urls: onlyAppsUrl)
	//extendedPaths.count
	// 4.-2 get contents of folder *************************************************************
	static func getContentsOfFolder(withFolder folder: URL) -> [URL] {
		let fileManager = FileManager.default
		do {
			let contents = try fileManager.contentsOfDirectory(atPath: folder.path)
			let urls = contents.map { return folder.appendingPathComponent($0) }
			return urls
		} catch {
			print("getContentsOfFails: \(folder)")
			return []
		}
	}
	let appStoreURLResources = URL(fileURLWithPath: "/Applications/App Store.app/Contents/Resources/")
	//let testContents = getContentsOf(folder: appStoreURLResources) // Working!!
	// 4.-1 get iconFolder *************************************************************
	static func findIconFile(urls: [URL]) -> [URL] {
		var results = [URL]()
		for url in urls {
			if !url.path.contains("Xcode") {
				if url.path.contains(".icns") {
					results.append(url)
					return results
				}
			}
		}
		return results
	}
	//let textFindIconFile = findIconFile(urls: testContents)!
	// 4 get iconFolder *************************************************************
	static func getIconFolder(urls: [URL]) -> [URL] {
		var iconFolders = [URL]()
		for url in urls {
			let contents = getContentsOfFolder(withFolder: url)
			let iconFile = findIconFile(urls: contents)
			if iconFile != [] {
				iconFolders.append(contentsOf: iconFile)
			}
		}
		return iconFolders
	}
	// 5 Convert to Path ******************************************************
	static func urlToPath(urls: [URL]) -> [String] {
		var paths = [String]()
		for url in urls {
			let path = url.path
			paths.append(path)
		}
		return paths
	}
	// 7.-1.-1 URL to path ********REGEX**************************************
	// 7.-1 Get AppName ********REGEX**************************************
	static func getAppName(url: URL) -> String {
		var array = [String]()
		if let regex = try? NSRegularExpression(pattern: "/[\\w %]+.app/", options: .caseInsensitive) {
			let string = url.path as NSString
			
			array = regex.matches(in: string as String, options: [], range: NSRange(location: 0, length: string.length)).map {
				string.substring(with: $0.range).replacingOccurrences(of: "/", with: "").replacingOccurrences(of: ".app", with: "")
			}
			if array.first != nil {
				return array[0]
			} else {
				return "No Name"
			}
		}
		
		return ""
	}
	// 7 Get a dictionary of appName and path" ********REGEX********************************
	class App {
		var appUrl:URL = URL(fileURLWithPath: "file:///Applications/Safari.app/Contents/Resources/css.icns")
		var appName = "Safari"
	}
	class Apps {
		var apps = [App]()
	}
	// *******************************************************************************************
	let iconUrl = URL(fileURLWithPath: "/Applications/App Store.app/Contents/Resources/AppIcon.icns")
	// /Applications/App Store.app/Contents/Resources/AppIcon.icns
//	let image = NSImage(byReferencing: iconUrl) // Good!
	
	
	
	
	
	// *******************************************************************************************
	// *******************************************************************************************
	// *******************************************************************************************
	// *******************************************************************************************
	//for app in testContents {
	//	print(app)
	//}
	
}
