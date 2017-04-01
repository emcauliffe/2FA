//: Playground - noun: a place where people can play

import UIKit
import Foundation

var test: = 5

extension String {
	public func base32Decode() -> IntMax{
		let value : [Character] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","2","3","4","5","6","7"]
		var outputInteger:IntMax = 0
		var multiplier = 1
		for character in self.characters.reversed() {
//			print(character)
//			print(outputInteger)
			print(Int(value.index(of: character)!) * multiplier)
			outputInteger += Int(value.index(of: character)!) * multiplier
			multiplier = multiplier*32
		}
		return outputInteger
	}
}


var dataString = "srqxbd2jahfx5xhpka4lzdnrntg6ynkh"

let time = Int(Date().timeIntervalSince1970)/30

dataString = dataString.uppercased()

dataString.characters.count

dataString

time

//let test1 = String(0xFFFFFFFFFFFFFFF)
//let test2 = String(0xFFFFFFFFFFFFFFF+100000000)
//test1
//test2


//dataString.base32Decode()

var test = String(9223372036854775806 + 9223372036854775806)

//let bytes = Array("string".utf8)

//data.append(time)//add u/data = data.sha1()//hmac part 1
