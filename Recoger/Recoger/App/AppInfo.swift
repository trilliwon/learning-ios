//
//  AppInfo.swift
//  Recoger
//
//  Created by Won on 29/05/2017.
//  Copyright © 2017 Won. All rights reserved.
//

import Foundation

enum AppInfo {

	static let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
	static let shortVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
	static let bundleVersion = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
	static let versionAndBuild: String = "\(AppInfo.shortVersion!)(\(AppInfo.bundleVersion!))"

	static func saveVersionStringToSupportSettingBundle() {
		let defaults = UserDefaults.standard
		defaults.setValue(AppInfo.versionAndBuild, forKey: "appVersion")
		defaults.synchronize()
	}
}
