//
//  HttpRequest.m
//  sinaWeibo
//
//  Created by app on 17/4/19.
//  Copyright © 2017年 Feizj. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest
{
    NSString *urlString;
    NSString *responseString;
    NSData *aJsonData;
    NSError *error;
    NSDictionary *jsonObject;
}

- (NSDictionary *)requestHttpForLogin:(NSString *)passUrlString{
    /**
     *  将 URL 传递进来的
     */
    urlString = passUrlString;
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        responseString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        
    }];
    
    
    
    return jsonObject;
}

@end
