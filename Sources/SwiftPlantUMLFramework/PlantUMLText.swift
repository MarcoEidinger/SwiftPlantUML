//
import Compression
import Foundation

struct PlantUMLText: RawRepresentable {
    var rawValue: String

    var encodedValue: String {
        let compressedData = deflate(rawValue)
        let encodedText = base64plantuml(compressedData)
        return encodedText
    }
}

private extension PlantUMLText {
    /**
     deflates according to IETF RFC 1951

     https://developer.apple.com/documentation/accelerate/compressing_and_decompressing_data_with_buffer_compression

      - Parameter text: diagram textual description ("@startuml ... @enduml")
      - Returns: compressed data according to DEFLATE (IETF RFC 1951) a.k.a zlib compression algorithm
     */
    func deflate(_ text: String) -> NSData {
        let sourceString = text
        let sourceBuffer = Array(sourceString.utf8)
        let destinationBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: sourceString.count)
        let algorithm = COMPRESSION_ZLIB
        let compressedSize = compression_encode_buffer(destinationBuffer, sourceString.count,
                                                       sourceBuffer, sourceString.count,
                                                       nil,
                                                       algorithm)
        return NSData(bytesNoCopy: destinationBuffer,
                      length: compressedSize)
    }
}

// implementation based on SwiftyBase64 (Created by Doug Richardson)
internal extension PlantUMLText {
    /**
      Encode a [UInt8] byte array using Base64 algorithm (as decribed by RFC 4648 section 4) **BUT uses a different translation table / alphabet**.

      For PlantUML, the mapping array for values 0-63 is:
     `0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_`

       See https://plantuml.com/en/text-encoding for more info

     - Parameter compressedData: of a deflated string
     - Returns: encoded string
      */
    func base64plantuml(_ compressedData: NSData) -> String { // swiftlint:disable:this function_body_length
        let bytes = [UInt8](compressedData)

        let encodingAlphabetTable: [UInt8] = [
            48, // 0=0
            49, // 1=1
            50, // 2=2
            51, // 3=3
            52, // 4=4
            53, // 5=5
            54, // 6=6
            55, // 7=7
            56, // 8=8
            57, // 9=9
            65, // 10=A
            66, // 11=B
            67, // 12=C
            68, // 13=D
            69, // 14=E
            70, // 15=F
            71, // 16=G
            72, // 17=H
            73, // 18=I
            74, // 19=J
            75, // 20=K
            76, // 21=L
            77, // 22=M
            78, // 23=N
            79, // 24=O
            80, // 25=P
            81, // 26=Q
            82, // 27=R
            83, // 28=S
            84, // 29=T
            85, // 30=U
            86, // 31=V
            87, // 32=W
            88, // 33=X
            89, // 34=Y
            90, // 35=Z
            97, // 36=a
            98, // 37=b
            99, // 38=c
            100, // 39=d
            101, // 40=e
            102, // 41=f
            103, // 42=g
            104, // 43=h
            105, // 44=i
            106, // 45=j
            107, // 46=k
            108, // 47=l
            109, // 48=m
            110, // 49=n
            111, // 50=o
            112, // 51=p
            113, // 52=q
            114, // 53=r
            115, // 54=s
            116, // 55=t
            117, // 56=u
            118, // 57=v
            119, // 58=w
            120, // 59=x
            121, // 60=y
            122, // 61=z
            45, // 62=-
            95, // 63=_
            // PADDING FOLLOWS, not used during lookups
            61, // 64==
        ]

        var encodedBytes: [UInt8] = []
        let padding = encodingAlphabetTable[64]

        var i = 0 // swiftlint:disable:this identifier_name
        let count = bytes.count

        while i + 3 <= count {
            let one = bytes[i] >> 2
            let two = ((bytes[i] & 0b11) << 4) | ((bytes[i + 1] & 0b1111_0000) >> 4)
            let three = ((bytes[i + 1] & 0b0000_1111) << 2) | ((bytes[i + 2] & 0b1100_0000) >> 6)
            let four = bytes[i + 2] & 0b0011_1111

            encodedBytes.append(encodingAlphabetTable[Int(one)])
            encodedBytes.append(encodingAlphabetTable[Int(two)])
            encodedBytes.append(encodingAlphabetTable[Int(three)])
            encodedBytes.append(encodingAlphabetTable[Int(four)])

            i += 3
        }

        if i + 2 == count {
            // (3) The final quantum of encoding input is exactly 16 bits; here, the
            // final unit of encoded output will be three characters followed by
            // one "=" padding character.
            let one = bytes[i] >> 2
            let two = ((bytes[i] & 0b11) << 4) | ((bytes[i + 1] & 0b1111_0000) >> 4)
            let three = ((bytes[i + 1] & 0b0000_1111) << 2)
            encodedBytes.append(encodingAlphabetTable[Int(one)])
            encodedBytes.append(encodingAlphabetTable[Int(two)])
            encodedBytes.append(encodingAlphabetTable[Int(three)])
            encodedBytes.append(padding)
        } else if i + 1 == count {
            // (2) The final quantum of encoding input is exactly 8 bits; here, the
            // final unit of encoded output will be two characters followed by
            // two "=" padding characters.
            let one = bytes[i] >> 2
            let two = ((bytes[i] & 0b11) << 4)
            encodedBytes.append(encodingAlphabetTable[Int(one)])
            encodedBytes.append(encodingAlphabetTable[Int(two)])
            encodedBytes.append(padding)
            encodedBytes.append(padding)
        } else {
            // (1) The final quantum of encoding input is an integral multiple of 24
            // bits; here, the final unit of encoded output will be an integral
            // multiple of 4 characters with no "=" padding.
            assert(i == count)
        }

        return String(decoding: encodedBytes, as: Unicode.UTF8.self)
    }
}

extension PlantUMLText: CustomStringConvertible {
    var description: String {
        encodedValue
    }
}

extension PlantUMLText: CustomDebugStringConvertible {
    var debugDescription: String {
        "\(rawValue) encoded is \(encodedValue)"
    }
}
