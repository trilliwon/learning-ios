//
//  StandardLibrary+Extensions.swift
//  SwitcherM
//
//  Created by Won on 15/05/2017.
//  Copyright © 2017 IO. All rights reserved.
//

import Foundation
import UIKit

extension Int {

	var binaryArray: [Bool] {
		return String(self, radix:2).pad(length: 8).map { (Int(String($0)) == 1)  }
	}

	var hex: String {
		return String(self, radix:16, uppercase: true)
	}

	var pad: String {
		if self >= 0 && self < 10 {
			return "0\(self)"
		}
		return "\(self)"
	}

	var paddedHex: String {
		let paddedHexStrings = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "0A", "0B", "0C", "0D", "0E", "0F"]
		return (self >= 0 && self < 16) ? paddedHexStrings[self] : String(self, radix:16, uppercase: true)
	}
}

extension Data {

	var intArray: [Int] {
		var intArr = [Int]()
		for index in 0..<self.count {
			var integer = 0
			(self as NSData).getBytes(&integer, range: NSRange(location: index, length: 1))
			intArr.append(integer)
		}
		return intArr
	}

	var int: Int {
		var integer = 0
		(self as NSData).getBytes(&integer, length: MemoryLayout<UInt8>.size)
		return integer
	}
}

extension Date {

	/**
	0: monday
	6: sunday

	@return 'day of week integer'
	*/
	var weekday: Int {
		let calendar: Calendar = Calendar.current
		let component: Int = calendar.component(.weekday, from: self)
		return component == 1 ? 6 : component - 2
	}

	/**
	@param number of plus, minus

	@return Date that plus, minus n
	*/
	func dDay(n: Int) -> Date {
		return self.addingTimeInterval(Double(n) * 24 * 60 * 60)
	}

	/**
	@return hour
	*/
	var hour: Int {
		let calendar: Calendar = Calendar.current
		let components: DateComponents = calendar.dateComponents([.hour], from: self)
		return components.hour!
	}

	/**
	@return minute
	*/
	var minute: Int {
		let calendar: Calendar = Calendar.current
		let components: DateComponents = calendar.dateComponents([.minute], from: self)
		return components.minute!
	}

	/**
	@return second
	*/
	var second: Int {
		let calendar: Calendar = Calendar.current
		let components: DateComponents = calendar.dateComponents([.second], from: self)
		return components.second!
	}

	/**
	@return tuple that contains hour, minute, second
	*/

	var hourMinuteSecond: [Int] {
		let calendar: Calendar = Calendar.current
		let components: DateComponents = calendar.dateComponents([.hour, .minute, .second], from: self)
		return [components.hour!, components.minute!, components.second!]
	}

	/**
	@return tuple that contains hour, minute
	*/
	var hourMinute: (hour: Int, minute: Int) {
		return (self.hourMinuteSecond[0], self.hourMinuteSecond[1])
	}

	/**
	@return tuple that contains week, hour, minute
	*/
	var weekHourMinute: [Int] {
		return [self.weekday, self.hourMinuteSecond[0], self.hourMinuteSecond[1]]
	}

	/**
	@return integer value of the year
	*/
	var year: Int {
		let calendar: Calendar = Calendar.current
		return calendar.component(.year, from: self)
	}

	/**
	0: monday
	6: sunday

	@return weekday in korean
	*/
	var weekdayInKorean: String {
		let weekdays: [String] = ["월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"]
		return weekdays[self.weekday]
	}

	/**
	@return "오전/오후 -시 : -분"
	*/
	var AMPM12Hour: String {
		let calendar: Calendar = Calendar.current
		let components: DateComponents = calendar.dateComponents([.hour, .minute], from: self)
		let  hour: Int = components.hour!
		let minute: Int = components.minute!

		if hour <= 12 {
			switch hour {
			case 0:
				return "오전 12시\(minute == 0 ? "" : " \(minute)분")"
			case 12:
				return "오후 12시\(minute == 0 ? "" : " \(minute)분")"
			default:
				return "오전 \(hour)시\(minute == 0 ? "" : " \(minute)분")"
			}
		} else {
			return "오후 \(hour-12)시\(minute == 0 ? "" : " \(minute)분")"
		}
	}
}

extension Notification {

	var keyboardHeight: CGFloat? {

		guard
			let userInfo = self.userInfo,
			let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue
			else { return nil }

		return keyboardFrame.cgRectValue.height
	}
}

extension NSObject {

	class var className: String {
		return String(describing: self)
	}

	var className: String {
		return type(of: self).className
	}
}

extension String {

	func makeRange(from: Int, to: Int) -> Range<String.Index>? {
		if from > to { return nil }
		if self.count < to { return nil }
		return self.index(self.startIndex, offsetBy: from)..<self.index(self.startIndex, offsetBy: to)
	}

	var date: Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		return dateFormatter.date(from: String(self.prefix(10)))
	}

	var localized: String {
		return NSLocalizedString(self, comment: "")
	}

	func colored(range: NSRange, color: UIColor = UIColor.default) -> NSAttributedString {
		let attributedString = NSMutableAttributedString(string: self)
		let attribute = [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.backgroundColor: .clear]
		attributedString.addAttributes(attribute, range: range)
		return attributedString
	}

	func underLined(substring: String? = nil) -> NSAttributedString{
		let attributedString = NSMutableAttributedString(string: self)
		let attribute = [NSAttributedStringKey.foregroundColor: UIColor.default,
		                 NSAttributedStringKey.backgroundColor: UIColor.clear,
                         NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue ] as [NSAttributedStringKey : Any]
		attributedString.addAttributes(attribute, range: (self as NSString).range(of: substring ?? self))
		return attributedString
	}

	var hexData: Data? {
		var data: Data = Data()
		var hexDic: [String: UInt8] = [String: UInt8]()
		(0...15).forEach {
				hexDic[$0.hex] = UInt8($0)
		}

		for c in self {
			guard let hex = hexDic[String(c).uppercased()] else { return nil }
			var mutableHex = hex
			data.append(UnsafeBufferPointer(start: &mutableHex, count: 1))
		}
		return data
	}

	var isInt: Bool {
		return (nil != Int(self))
	}

	func binaryStringToInt() -> Int {
		return Int(strtoul(self, nil, 2))
	}

	func pad(length: Int) -> String {
		let diff = length - self.count
		if diff > 0 {
			var padded = self
			for _ in 0..<diff {
				padded = "0" + padded
			}
			return padded
		}
		return self
	}

	func pad() -> String {
		guard let self_Int = Int(self) else {
			return ""
		}

		if self_Int >= 0 && self_Int < 10 {
			return "0\(self_Int)"
		}
		return "\(self)"
	}

	func customDateString() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		let date = dateFormatter.date(from: String(self.prefix(10)))
		dateFormatter.dateFormat = "yyyy년 M월 d일"
		if let date = date { return dateFormatter.string(from: date) }
		return ""
	}

	func dMinusOne() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		guard let date = dateFormatter.date(from: String(self.prefix(10))) else {
			return ""
		}
		var mutableDate = date
		mutableDate.addTimeInterval(-24 * 60 * 60)
		dateFormatter.dateFormat = "M월 d일"
		return dateFormatter.string(from: mutableDate)
	}
}

extension Optional {
	func ifSome(_ closure: (Wrapped) -> Void) {
		switch self {
		case .some(let wrapped): return closure(wrapped)
		case .none: break
		}
	}

	@discardableResult
	func ifNone(_ closure: () -> Void) -> Optional {
		switch self {
		case .some: return self
		case .none: closure(); return self
		}
	}
}

extension Bool {
	func ifTrue(_ closure: @autoclosure () -> Void) {
		switch self {
		case true: return closure()
		case false: return
		}
	}

	func ifFalse(_ closure: @autoclosure () -> Void) {
		switch self {
		case true: return
		case false: return closure()
		}
	}
}

extension Array {
	var binaryIntArrayToInt: Int {
		let binaryString = self.reduce("", {  "\($0)\($1)" })
		return Int(strtoul(binaryString, nil, 2))
	}

	/// comma seperated string
	var csString: String {
		return String(self.reduce("") { $0+"\($1)." }.dropLast())
	}
}
