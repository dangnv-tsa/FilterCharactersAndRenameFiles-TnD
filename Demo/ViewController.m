//
//  ViewController.m
//  Demo
//
//  Created by NGUYEN VAN DANG on 5/24/13.
//  Copyright (c) 2013 NGUYEN VAN DANG. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize txtRenamed;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.    
    [self renameFiles];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)renameFiles{
    txtRenamed.hidden = TRUE;
    NSString *documentsDirectory = @"/Users/dangnv/Desktop/untitled folder/"; //Enter path of directory to rename
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *fileList = [manager contentsOfDirectoryAtPath:documentsDirectory error:nil];
    for (NSString *s in fileList){
        NSString *checkStr = [[s stringByReplacingOccurrencesOfString:@".png" withString:@""] stringByReplacingOccurrencesOfString:@"@2x" withString:@""];
        
        NSString *newName = [self filterStr:checkStr withCharacters:@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
        if ([s rangeOfString:@"@2x"].location != NSNotFound) {
            newName = [NSString stringWithFormat:@"%@%@", newName,@"@2x"];
        }
        
        NSLog(@"%@/%@", s, newName);
        
        NSString *newPath = [NSString stringWithFormat:@"%@/%@.png", documentsDirectory, newName];
        NSString *oldPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, s];
        [[NSFileManager defaultManager] moveItemAtPath:oldPath toPath:newPath error:nil];
    }
    
    txtRenamed.hidden = FALSE;

}


- (NSString *)filterStr:(NSString *)str withCharacters:(NSString *)charSet{
//    NSString *inputStr = [str lowercaseString];
    NSString *inputStr = str;
    NSMutableString *strippedString = [NSMutableString
                                       stringWithCapacity:inputStr.length];
    
    NSScanner *scanner = [NSScanner scannerWithString:inputStr];
    NSCharacterSet *filter = [NSCharacterSet
                               characterSetWithCharactersInString:charSet];
    
    while ([scanner isAtEnd] == NO) {
        NSString *buffer;
        if ([scanner scanCharactersFromSet:filter intoString:&buffer]) {
            [strippedString appendString:buffer];
            
        } else {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
    }
    
    return strippedString;
}


@end
