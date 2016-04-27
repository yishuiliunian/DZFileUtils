//
//  DZFileUtils.m
//  Pods
//
//  Created by stonedong on 16/3/6.
//
//

#import "DZFileUtils.h"
#import <Foundation/Foundation.h>
void DZEnsurePathExist(NSString* path)
{
    NSCParameterAssert(path);
    BOOL exist = [NSShareFileManager fileExistsAtPath:path];
    if (!exist) {
        NSError* error = nil;
        [NSShareFileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    }
}



NSString* DZDocumentsPath()
{
    static NSString* documentsPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray* urls =  [NSShareFileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask];
        NSURL* url = urls[0];
        documentsPath = [url path];
        documentsPath = [documentsPath stringByAppendingPathComponent:@"TrackBugs"];
        DZEnsurePathExist(documentsPath);
    });
    return documentsPath;
}


NSString* DZSettingsFilePath()
{
    return [DZDocumentsPath() stringByAppendingPathComponent:@"settings.plist"];
}

NSString* DZAppendPath(NSString* parentPath, NSString* sub) {
    NSString* str = [parentPath stringByAppendingPathComponent:sub];
    DZEnsurePathExist(str);
    return str;
}

NSString* DZTempDir(){
    return NSTemporaryDirectory();
}

NSString* DZMKTempDirectory(){
    NSString* path = [[NSUUID UUID] UUIDString];
    return DZAppendPath(DZTempDir(), path);
}

NSString* DZDocumentsSubPath(NSString* str) {
    return DZAppendPath(DZDocumentsPath(), str);
}


NSString* DZPathJoin(NSString* a, NSString* b) {
    return [a stringByAppendingPathComponent:b];
}


NSString* DZTempFilePathWithExtension(NSString* extension){
    NSString* fileName = [NSUUID UUID].UUIDString;
    NSString* path = DZTempDir();
    path = [path stringByAppendingPathComponent:fileName];
    path = [path stringByAppendingPathExtension:extension];
    return path;
}

void DZRemoveFileByPath(NSString* path) {
    NSError* error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
}


NSString* DZFileInSubPath(NSString* fileName, NSString* subPath){
    NSString* sp = DZDocumentsSubPath(subPath);
    return DZAppendPath(fileName, sp);
}
