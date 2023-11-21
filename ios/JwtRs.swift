//
//  JwtRs.swift
//  RSToken
//
//  Created by Akhtar on 11/19/23.
//

import Foundation
import SwiftJWT



@objc(JwtRs)
class JwtRs:NSObject{
  
  private var counter=0;
  
  struct StoreData: Codable {
      let store_id: String
      let name: String
  }
  struct User: Codable {
      let store_id: String
      let data: StoreData
  }
  
  struct MyClaims: Claims {
      let iss: String
      let sub: String
      let exp: Date
      let admin: Bool
      let aud:String
      let user: User
  }
  
  
  
  func getAbsolutePath(relativePath: String) -> String {
      return FileManager.default.currentDirectoryPath + relativePath
  }

  @objc
  func generateJWT(_ 
    iss:String,
    sub:String,
    exp:Date,
    admin:Bool,
    aud:String,
    store_id:String,
    name:String,
    callback: @escaping RCTResponseSenderBlock
  ){
    let myClaims = MyClaims(
            iss: iss,
            sub: sub,
            exp: Date(timeIntervalSinceNow: 3600), 
            admin: admin,
            aud: aud,
            user: User(
                store_id: store_id,
                data: StoreData(
                    store_id: store_id,
                    name: name
                  ) 
                )
            );


  let myHeader = Header(kid: "KeyID1")
    counter+=1;
    print(counter)
    print(getAbsolutePath(relativePath: "privateKey.key"))
    do {
        let privateKeyPath = URL(fileURLWithPath: "/Users/Akhtar/Documents/intelliquarck/learning/RSToken/ios/privateKey.key")
        let privateKey: Data = try Data(contentsOf: privateKeyPath, options: .alwaysMapped)

        let publicKeyPath = URL(fileURLWithPath: "/Users/Akhtar/Documents/intelliquarck/learning/RSToken/ios/privateKey.key.pub")
        let publicKey: Data = try Data(contentsOf: publicKeyPath, options: .alwaysMapped)
        var myJWT = JWT(header: myHeader, claims: myClaims)

        // You can now use privateKey and publicKey here
        let jwtSigner = JWTSigner.rs256(privateKey: privateKey)
        let signedJWT = try myJWT.sign(using: jwtSigner)
        callback([signedJWT])


    } catch {
        // Handle the error here, for example:
        print("Error loading private or public key: \(error)")
    }
  }
  
  @objc
  func verifyJwt(_ jwt:String, callback: @escaping RCTResponseSenderBlock){
    do {
      let publicKeyPath = URL(fileURLWithPath: "/Users/Akhtar/Documents/intelliquarck/learning/RSToken/ios/privateKey.key.pub")
      let publicKey: Data = try Data(contentsOf: publicKeyPath, options: .alwaysMapped)
      let jwtVerifier = JWTVerifier.rs256(publicKey: publicKey)
      let verified = JWT<MyClaims>.verify(jwt, using: jwtVerifier)
      callback([verified])
    } catch {
      callback([error])
    }
  }

  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
