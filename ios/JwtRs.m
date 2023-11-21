//
//  JwtRs.m
//  RSToken
//
//  Created by Akhtar on 11/19/23.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(JwtRs, NSObject)

RCT_EXTERN_METHOD(generateJWT:
    (NSString *)iss
    sub:(NSString *)sub
    exp:(NSDate *)exp
    admin:(BOOL)admin
    aud:(NSString *)aud
    store_id:(NSString *)store_id
    name:(NSString *)name
    callback:(RCTResponseSenderBlock)callback

)

RCT_EXTERN_METHOD(verifyJwt:
    (NSString *)jwt
    callback:(RCTResponseSenderBlock)callback
)

@end
