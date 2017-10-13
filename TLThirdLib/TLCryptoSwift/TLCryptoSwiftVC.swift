//
//  TLCryptoSwiftVC.swift
//  TLThirdLib
//
//  Created by lichuanjun on 2017/10/13.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

import UIKit
import CryptoSwift
import SnapKit

class TLCryptoSwiftVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "CryptoSwift"
        self.view.backgroundColor = UIColor.white
 
        let label: UILabel = UILabel()
        label.text = "See code in TLCryptoSwiftVC.m"
        self.view.addSubview(label)
        label.snp.makeConstraints {  [weak self] (make) in
            make.center.equalTo(self!.view)
        }
        
        self.runTestFunc()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - runTestFunc
    func runTestFunc() -> (Void) {
        self.testDataFromBytes()
        self.testDataFromArray()
        
        self.testHexadecimalEncoding()
        self.testBuildBytesOutOfString()
        
        self.testHashingDataOrArrayBytes()
        
        self.testHashingString()
        self.testCalculateCRCMessageAuthenticators()
        self.testCiphersChaCha20()
        
        self.testAES()
        self.testIncrementalUpdates()
    }
}

extension TLCryptoSwiftVC {
    
    fileprivate func testDataFromBytes() {
        // Data from bytes:
        let data = Data(bytes: [0x01, 0x02, 0x03])
        
        print("DataFromBytes: \(data)")
    }
    
    fileprivate func testDataFromArray() {
        // Data from bytes:
        let data = Data(bytes: [0x01, 0x02, 0x03])
        
        //Data to Array<UInt8>
        let bytes = data.bytes  // [1,2,3]
        
        print("DataFromArray: \(bytes)")
    }
    
    fileprivate func testHexadecimalEncoding() {
        let bytes = Array<UInt8>(hex: "0x010203")  // [1,2,3]
        let hex   = bytes.toHexString()            // "010203"
        
        print("HexadecimalEncoding: \(hex)")
    }
    
    fileprivate func testBuildBytesOutOfString() {
        let bytes = Array("string".utf8)
//        "aPf/i9th9iX+vf49eR7PYk2q7S5xmm3jkRLejgzHNJs=".decryptBase64ToString(cipher: Cipher)
//        "aPf/i9th9iX+vf49eR7PYk2q7S5xmm3jkRLejgzHNJs=".decryptBase64(cipher: Cipher)
        
        print("BuildBytesOutOfString: \(String(describing: bytes.toBase64()))")
    }
    
    fileprivate func testHashingDataOrArrayBytes() {
        /* Hash struct usage */
        let bytes:Array<UInt8> = [0x01, 0x02, 0x03]
        let digest1 = bytes.md5()
        print("testHashingDataOrArrayBytes1: \(digest1)")
        let digest2 = Digest.md5(bytes)
        print("testHashingDataOrArrayBytes2: \(digest2)")
        
        let data = Data(bytes: [0x01, 0x02, 0x03])
        print("testHashingDataOrArrayBytes md5: \(data.md5().toHexString())")
        print("testHashingDataOrArrayBytes sha1: \(data.sha1().toHexString())")
        print("testHashingDataOrArrayBytes sha224: \(data.sha224().toHexString())")
        print("testHashingDataOrArrayBytes sha256: \(data.sha256().toHexString())")
        print("testHashingDataOrArrayBytes sha384: \(data.sha384().toHexString())")
        print("testHashingDataOrArrayBytes sha512: \(data.sha512().toHexString())")
        
        do {
            var digest = MD5()
            let partial1 = try digest.update(withBytes: [0x31, 0x32])
            let partial2 = try digest.update(withBytes: [0x33])
            let result = try digest.finish()
            
            print("testHashingDataOrArrayBytes partial1: \(partial1)")
            print("testHashingDataOrArrayBytes partial2: \(partial2)")
            print("testHashingDataOrArrayBytes result: \(result)")
        } catch { }
    }
    
    func testHashingString() {
        let hash = "123".md5()
        print("testHashingString: \(hash)")
    }
    
    func testCalculateCRCMessageAuthenticators() {
        let password: Array<UInt8> = Array("s33krit".utf8)
        let salt: Array<UInt8> = Array("nacllcan".utf8)
        
        var PKCS5Array:Array<UInt8>?
        do{
            try PKCS5Array = PKCS5.PBKDF2(password: password, salt: salt, iterations: 4096, variant: .sha256).calculate()
        }
        catch {
        }

        print("testCalculateCRCMessageAuthenticators -PBKDF2: \(String(describing: PKCS5Array))")
    }
    
    func testCiphersChaCha20() {
        
        let keys: [Array<UInt8>] = [
            [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
            [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01],
            [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
            [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
            [0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f],
            ]
        
        let ivs: [Array<UInt8>] = [
            [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
            [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
            [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01],
            [0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
            [0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07],
            ]
        
        let expectedHexes = [
            "76B8E0ADA0F13D90405D6AE55386BD28BDD219B8A08DED1AA836EFCC8B770DC7DA41597C5157488D7724E03FB8D84A376A43B8F41518A11CC387B669B2EE6586",
            "4540F05A9F1FB296D7736E7B208E3C96EB4FE1834688D2604F450952ED432D41BBE2A0B6EA7566D2A5D1E7E20D42AF2C53D792B1C43FEA817E9AD275AE546963",
            "DE9CBA7BF3D69EF5E786DC63973F653A0B49E015ADBFF7134FCB7DF137821031E85A050278A7084527214F73EFC7FA5B5277062EB7A0433E445F41E3",
            "EF3FDFD6C61578FBF5CF35BD3DD33B8009631634D21E42AC33960BD138E50D32111E4CAF237EE53CA8AD6426194A88545DDC497A0B466E7D6BBDB0041B2F586B",
            "F798A189F195E66982105FFB640BB7757F579DA31602FC93EC01AC56F85AC3C134A4547B733B46413042C9440049176905D3BE59EA1C53F15916155C2BE8241A38008B9A26BC35941E2444177C8ADE6689DE95264986D95889FB60E84629C9BD9A5ACB1CC118BE563EB9B3A4A472F82E09A7E778492B562EF7130E88DFE031C79DB9D4F7C7A899151B9A475032B63FC385245FE054E3DD5A97A5F576FE064025D3CE042C566AB2C507B138DB853E3D6959660996546CC9C4A6EAFDC777C040D70EAF46F76DAD3979E5C5360C3317166A1C894C94A371876A94DF7628FE4EAAF2CCB27D5AAAE0AD7AD0F9D4B6AD3B54098746D4524D38407A6DEB3AB78FAB78C9",
            ]
        
        for idx in 0..<keys.count {
            let expectedHex = expectedHexes[idx]
            let message = Array<UInt8>(repeating: 0, count: (expectedHex.characters.count / 2))
            
            do {
                let encrypted = try message.encrypt(cipher: ChaCha20(key: keys[idx], iv: ivs[idx]))
                let decrypted = try encrypted.decrypt(cipher: ChaCha20(key: keys[idx], iv: ivs[idx]))
                print("testCiphersChaCha20 - encrypted: \(encrypted)")
                print("testCiphersChaCha20 - decrypted: \(decrypted)")
            } catch CipherError.encrypt {
                print("Encryption failed")
            } catch CipherError.decrypt {
                print("Decryption failed")
            } catch {
                print("Failed")
            }
        }
    }
    
    func testAES() {
        do {
            let aes = try AES(key: "passwordpassword", iv: "drowssapdrowssap") // aes128
            let ciphertext = try aes.encrypt(Array("Nullam quis risus eget urna mollis ornare vel eu leo.".utf8))
            print("testAES: \(ciphertext)")
        } catch { }
    }
    
    func testIncrementalUpdates() {
        do {
            var encryptor = try AES(key: "passwordpassword", iv: "drowssapdrowssap").makeEncryptor()
            
            var ciphertext = Array<UInt8>()
            // aggregate partial results
            ciphertext += try encryptor.update(withBytes: Array("Nullam quis risus ".utf8))
            ciphertext += try encryptor.update(withBytes: Array("eget urna mollis ".utf8))
            ciphertext += try encryptor.update(withBytes: Array("ornare vel eu leo.".utf8))
            // finish at the end
            ciphertext += try encryptor.finish()
            
            print("testIncrementalUpdates: \(ciphertext.toHexString())")
        } catch {
            print(error)
        }
    }
    
    func testAESAdvancedUsage() {
        let input: Array<UInt8> = [0,1,2,3,4,5,6,7,8,9]
        
        let key: Array<UInt8> = [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00]
        let iv: Array<UInt8> = AES.randomIV(AES.blockSize)
        
        do {
            let encrypted = try AES(key: key, iv: iv, blockMode: .CBC, padding: .pkcs7).encrypt(input)
            let decrypted = try AES(key: key, iv: iv, blockMode: .CBC, padding: .pkcs7).decrypt(encrypted)
            
            print("testAESAdvancedUsage - encrypted: \(encrypted)")
            print("testAESAdvancedUsage - decrypted: \(decrypted)")
        } catch {
            print(error)
        }
    }
    
}
