//
//  SaveAndLoad.h
//  DemonCastle
//
//  Created by macbook on 13-6-20.
//
//

#import <UIKit/UIKit.h>
#import "/usr/include/sqlite3.h"
@class sqlTestList;
@interface SaveAndLoad : NSObject{
    sqlite3 *db; //声明一个sqlite3数据库
}
@property (nonatomic)sqlite3 *db;
-(BOOL)createTestList:(sqlite3 *)db;//创建数据库
-(BOOL)insertList:(sqlTestList *)List;//插入数据
-(BOOL)saveList:(sqlTestList *)List;//更新数据
-(NSMutableArray*)getTestList;//获取全部数据
-(BOOL)deleteList:(sqlTestList *)deletList;//删除数据
-(sqlTestList*)searchTestList:(int)searchID;//查询数据库，searchID为要查询数据的ID，返回数据为查询到的数据
@end

@interface sqlTestList : NSObject//从头定义了一个类，专门用于存储数据
{
    int sqlID;
    float sqlStartX;
    float sqlStartY;
    int sqlPlayerScore;
    int sqlPlayerLevel;
    float sqlPlayerTotleLife;
    float sqlPlayerTotleMagic;
    int sqlSaveWay;
}
@property(nonatomic) int sqlID;
@property(nonatomic,assign) float sqlStartX;
@property(nonatomic,assign) float sqlStartY;
@property(nonatomic,assign) int sqlPlayerScore;
@property(nonatomic,assign) int sqlPlayerLevel;
@property(nonatomic,assign) float sqlPlayerTotleLife;
@property(nonatomic,assign) float sqlPlayerTotleMagic;
@property(nonatomic,assign) int sqlSaveWay;
@end
