//
//  AppsFilesLoader.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/08/21.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Foundation
class AppsLoader {
	private static let applicationUrl = URL(fileURLWithPath: "/Applications/")
	private static let utilitiesUrl = URL(fileURLWithPath: "/Applications/Utilities")
	static func getIconsAndUrlsFromApplicationsFolders() -> [(appName: String, url: URL)] {
		
		let allFilesFromFolder = Loader.contentsOf(folder: applicationUrl)
		let allAppFilesOnly = Loader.filterToApplicationsOnly(of: allFilesFromFolder)
		let completeUrl = Loader.appendIconPath(urls: allAppFilesOnly)
		let allIconsUrl = Loader.getIconFolder(urls: completeUrl)
		
		// Utilities:
		let allFilesFromUFolder = Loader.contentsOf(folder: utilitiesUrl)
		let allUAppFilesOnly = Loader.filterToApplicationsOnly(of: allFilesFromUFolder)
		let completeUUrl = Loader.appendIconPath(urls: allUAppFilesOnly)
		let allIconsUUrl = Loader.getIconFolder(urls: completeUUrl)
		
		
		
		// Working above
		
		// Creating tuples
		let finderUrl = URL(fileURLWithPath: "/System/Library/CoreServices/Finder.app/Contents/Resources/Finder.icns")
		var tuples = [(appName: "Finder", url: finderUrl)]
		
		for url in allIconsUrl {
			let appName = Loader.getAppName(url: url)
			tuples.append((appName: appName, url: url))
		}
		for url in allIconsUUrl {
			let appName = Loader.getAppName(url: url)
			tuples.append((appName: appName, url: url))
		}
		let sortedtuples = tuples.sorted(by: {$0.appName < $1.appName})
//		for tuples in sortedtuples {
//			print("\(tuples.appName): \(tuples.url)")
//		}
		// Finder
//		tuples.append((appName: "Finder", url: URL(fileURLWithPath: "/System/Library/CoreServices"))
		return sortedtuples
	}
}
