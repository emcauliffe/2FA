//: Playground - noun: a place where people can play

import Cocoa

var str = "jhsdfaljadsfk;afsdkadfsj;kjf;alskdjf;lkajsd;flkjasd;flkjas;dlkfjas;ldkfjlkasdjhlkasjdbvkabsvlkjasdbvlkjbasdlkjbasdlkhfbalskdjbvlkasdbvlkasjdbvlkjbasdlkvjbasdlkjvb"
var hash : String = ""
var h0 = 0x67452301
var h1 = 0xEFCDAB89
var h2 = 0x98BADCFE
var h3 = 0x10325476
var h4 = 0xC3D2E1F0
var chunkedStringArray : [[String]] = [[""]]
var numberArray : [[uint32]] = [[0]]


extension UInt64 {
	public func binary() -> String {
		let short = String(self,radix:2)
		
		let padded = String(repeating: "0", count: 64 - short.characters.count) + short
		return padded
	}
}
extension UInt32 {
	public func binary() -> String {
		let short = String(self,radix:2)
		
		let padded = String(repeating: "0", count: 32 - short.characters.count) + short
		return padded
	}
}
extension String {
	public func segment() -> [String] {
		return self.characters.map { String($0) }//creates an array of the string where each character in the string has it's own specific index
	}
	public func blockArray(charactersPerBlock: Int, blockStartPosition: Int, blockLength: Int) -> [String] {//retruns an array of the string with blockLength indexes that are charactersPerBlock long and start at blockStartPosition*blockLength (values accepted are the length of the array divided by the blockLength)
		var outputArray:[String] = [""]//initialize output array
		var characterPosition:Int = 0//keeps track of where the loop is along the array
		let	evenOrOdd = self.characters.count%2//determines if there are an even or odd number of characters in the array
		for character in self.segment() {
			if characterPosition%charactersPerBlock==0{//determines if an index needs to be added
				outputArray+=[""]//adds the required index to complete the code below
			}
			outputArray[characterPosition/charactersPerBlock].append(character)//adds the character being iterated over to the selected array index
			characterPosition+=1//increases the character position to keep track of characters recorded
		}
		if (evenOrOdd==0){
			outputArray.removeLast()//removes extra index if there are an even number of characters
		}
		if blockStartPosition>0 {
			for _ in 0...blockLength*blockStartPosition-1{//removes characters from beginning of array depending on position selected
				outputArray.remove(at: 0)
			}
		}
		if blockStartPosition<(outputArray.count-1)/blockLength {
			for _ in 0...outputArray.count-blockLength-1{
				outputArray.remove(at: blockLength)//removes characters from end of array depending on position selected
			}
		}
		return outputArray//returns final array
	}
	public func binaryToInteger() -> uint {
		return uint(strtoul(self, nil, 2))
	}
	
}

for binaryValue in str.unicodeScalars {
	hash.append(String(binaryValue.value, radix: 2))//converts string to ASCII/Unicode binary values
}

var length64:UInt64 = UInt64(hash.characters.count)//determies length of the ASCII string and makes it a 64 bit integer

hash.append("1")//adds "1" to end of string

while (hash.characters.count % 512 != 448) {
	hash.append("0")
}
hash.append(length64.binary())
for i in 0...(hash.characters.count/512)-1{
	i
	chunkedStringArray[i] = hash.blockArray(charactersPerBlock: 32, blockStartPosition:i, blockLength:16)
	if i != (hash.characters.count/512)-1{
		chunkedStringArray+=[[""]]
	}
}
chunkedStringArray
for i in 0...chunkedStringArray.count-1 {
	for a in 0...chunkedStringArray[i].count-1{
		chunkedStringArray[i][a]
		numberArray[i].insert(UInt32(chunkedStringArray[i][a].binaryToInteger()), at: a)
	}
	if (numberArray[i].count>80){
	numberArray[i].removeLast()//removes extra "0" from the end of the array
	}
	if (i<chunkedStringArray.count-1){
		numberArray+=[[]]
	}
}
numberArray
for a in 0...(numberArray.count)-1{
	for i in 16...79 {
		var xorAndRotated : UInt32 = numberArray[a][i-3]^numberArray[a][i-8]^numberArray[a][i-14]^numberArray[a][i-16]
		let extraBit:Int = Int(((xorAndRotated.binary()).segment())[0])!
		xorAndRotated = xorAndRotated<<1
		if extraBit == 1{
			xorAndRotated+=1
		}
		numberArray[a].insert(xorAndRotated, at: i)
	}
	if (numberArray[a].count>80){
		numberArray[a].removeLast()
	}
}
numberArray
