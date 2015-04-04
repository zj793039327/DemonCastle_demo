//
//  SaveAndLoad.m
//  DemonCastle
//
//  Created by macbook on 13-6-20.
//
//

#import "SaveAndLoad.h"

@interface SaveAndLoad ()

@end

@implementation SaveAndLoad
@synthesize db;

-(id)init
{
    return self;
}
-(void)dealloc
{
    [super dealloc];
}

//获取document目录并返回数据库目录
-(NSString *)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"=======%@",documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:@"data.db"];//这里很神奇，可以定义成任何类型的文件，也可以不定义成.db文件，任何格局都行，定义成.sb文件都行，达到了很好的数据隐秘性
}

//创建，打开数据库
-(BOOL)openDB {
    //获取数据库路径
    NSString *path = [self dataFilePath];
    //文件经管器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //断定数据库是否存在
    BOOL find = [fileManager fileExistsAtPath:path];
    //若是数据库存在，则用sqlite3_open直接打开（不要愁闷，若是数据库不存在sqlite3_open会主动创建）
    if (find) {
        NSLog(@"Database file have already existed.");
        //打开数据库，这里的[path UTF8String]是将NSString转换为C字符串，因为SQLite3是采取可移植的C（而不是Objective-C）编写的，它不知道什么是NSString.
        if(sqlite3_open([path UTF8String], &db)!= SQLITE_OK) {
            //若是打开数据库失败则封闭数据库
            sqlite3_close(self.db);
            NSLog(@"Error: open database file.");
            return NO;
        }
        //创建一个新表
        [self createTestList:self.db];
        return YES;
    }
    //若是发明数据库不存在则哄骗sqlite3_open创建数据库（上方已经提到过），与上方雷同，路径要转换为C字符串
    if(sqlite3_open([path UTF8String], &db) == SQLITE_OK) {
        //创建一个新表
        [self createTestList:self.db];
        return YES;
    } else {
        //若是创建并打开数据库失败则封闭数据库
        sqlite3_close(self.db);
        NSLog(@"Error: open database file.");
        return NO;
    }
    return NO;
}

//创建表
-(BOOL)createTestList:(sqlite3*)database {
    //这句是大师熟悉的SQL语句
    char *sql = "create table if not exists testTable(ID INTEGER PRIMARY KEY AUTOINCREMENT, sqlID int,sqlStartX float,sqlStartY float,sqlPlayerScore int,sqlPlayerLevel int,sqlPlayerTotleLife float,sqlPlayerTotleMagic float,sqlSaveWay int)";// testID是列名，int 是数据类型，testValue是列名，text是数据类型，是字符串类型
    sqlite3_stmt *statement;
    //sqlite3_prepare_v2 接口把一条SQL语句解析到statement布局里去. 应用该接口接见数据库是当前斗劲好的的一种办法
    NSInteger sqlReturn = sqlite3_prepare_v2(database,sql,-1,&statement,nil);
    //第一个参数跟前面一样，是个sqlite3 * 类型变量，
    //第二个参数是一个 sql 语句。
    //第三个参数我写的是-1，这个参数含义是前面 sql 语句的长度。若是小于0，sqlite会主动策画它的长度（把sql语句当成以\0结尾的字符串）。
    //第四个参数是sqlite3_stmt 的指针的指针。解析今后的sql语句就放在这个布局里。
    //第五个参数是错误信息提示，一般不消，为nil就可以了。
    //若是这个函数履行成功（返回值是 SQLITE_OK 且 statement 不为NULL ），那么下面就可以开端插入二进制数据。
    
    //若是SQL语句解析失足的话法度返回
    if(sqlReturn != SQLITE_OK) {
        NSLog(@"Error: failed to prepare statement:create test table");
        return NO;
    }
    //履行SQL语句
    int success = sqlite3_step(statement);
    //开释sqlite3_stmt
    sqlite3_finalize(statement);
    //履行SQL语句失败
    if(success != SQLITE_DONE) {
        NSLog(@"Error: failed to dehydrate:create table test");
        return NO;
    }
    NSLog(@"Create table ""testTable"" successed.");
    return YES;
}

//插入数据
-(BOOL)insertList:(sqlTestList *)List {
    //先断定数据库是否打开
    if([self openDB]) {
        sqlite3_stmt *statement;
        //这个 sql 语句希罕之处在于 values 里面有个？ 号。在sqlite3_prepare函数里，？号默示一个不决的值，它的值等下才插入。
        static char *sql = "INSERT OR REPLACE INTO testTable(sqlID,sqlStartX,sqlStartY,sqlPlayerScore,sqlPlayerLevel,sqlPlayerTotleLife,sqlPlayerTotleMagic,sqlSaveWay) VALUES(?,?,?,?,?,?,?,?)";
        int success2 = sqlite3_prepare_v2(db, sql, -1, &statement, NULL);
        if(success2 != SQLITE_OK) {
            NSLog(@"Error: failed to :testTable");
            sqlite3_close(db);
            return NO;
        }
        //这里的数字1，2，3代表上方的第几个问号，这里将三个值绑定到三个绑定变量
        sqlite3_bind_int(statement, 1, List.sqlID);
        sqlite3_bind_double(statement, 2, List.sqlStartX);
        sqlite3_bind_double(statement, 3, List.sqlStartY);
        sqlite3_bind_double(statement, 4, List.sqlPlayerScore);
        sqlite3_bind_double(statement, 5, List.sqlPlayerLevel);
        sqlite3_bind_double(statement, 6, List.sqlPlayerTotleLife);
        sqlite3_bind_double(statement, 7, List.sqlPlayerTotleMagic);
        sqlite3_bind_double(statement, 8, List.sqlSaveWay);
        //履行插入语句
        success2 = sqlite3_step(statement);
        //开释statement
        sqlite3_finalize(statement);
        //若是插入失败
        if(success2 == SQLITE_ERROR) {
            NSLog(@"Error: failed to  into the database with message.");
            //封闭数据库
            sqlite3_close(db);
            return NO;
        }
        //封闭数据库
        sqlite3_close(db);
        return YES;
    }
    return NO;
}

//获取数据
-(NSMutableArray*)getTestList{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    //断定数据库是否打开
    if ([self openDB]) {
        sqlite3_stmt *statement = nil;
        //sql语句
        char *sql = "SELECT sqlID, sqlStartX, sqlStartY, sqlPlayerScore, sqlPlayerLevel, sqlPlayerTotleLife, sqlPlayerTotleMagic, sqlSaveWay FROM testTable";//从testTable这个表中获取 testID， testValue ，testName，若获取全部的话可以用*庖代testID， testValue ，testName。
        if(sqlite3_prepare_v2(db, sql, -1, &statement, NULL) != SQLITE_OK) {
            NSLog(@"Error: failed to prepare statement with message:get testValue.");
            return NO;
        } else {
            //查询成果集中一条一条的遍历所有的记录，这里的数字对应的是列值，重视这里的列值，跟上方sqlite3_bind_text绑定的列值不一样！必然要分隔，不然会crash，只有这一处的列号不合，重视！
            while(sqlite3_step(statement) == SQLITE_ROW) {
                sqlTestList* sqlList = [[sqlTestList alloc] init] ;
                sqlList.sqlID = sqlite3_column_int(statement,0);
                sqlList.sqlStartX = sqlite3_column_double(statement,1);
                sqlList.sqlStartY = sqlite3_column_double(statement,2);
                sqlList.sqlPlayerScore = sqlite3_column_int(statement,3);
                sqlList.sqlPlayerLevel = sqlite3_column_int(statement,4);
                sqlList.sqlPlayerTotleLife = sqlite3_column_double(statement,5);
                sqlList.sqlPlayerTotleMagic = sqlite3_column_double(statement,6);
                sqlList.sqlSaveWay = sqlite3_column_int(statement,7);
                
                [array addObject:sqlList];
                [sqlList release];
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return [array retain];//定义了主动开释的NSArray，如许不是个好办法，会造成内存泄漏，建议大师定义局部的数组，再赋给属性变量。
}

//更新数据
-(BOOL)saveList:(sqlTestList *)List {
    if([self openDB]) {
        sqlite3_stmt *statement;//这相当一个容器，放转化OK的sql语句
        //组织SQL语句
        char *sql = "update testTable set sqlStartX = ?, sqlStartY= ?, sqlPlayerScore= ?, sqlPlayerLevel= ?, sqlPlayerTotleLife= ?, sqlPlayerTotleMagic= ?, sqlSaveWay = ? WHERE sqlID = ?";
        //将SQL语句放入sqlite3_stmt中
        int success = sqlite3_prepare_v2(db, sql, -1, &statement, NULL);
        if (success != SQLITE_OK){
            NSLog(@"Error: failed to :testTable");
            sqlite3_close(db);
            return NO;
        }
        //这里的数字1，2，3代表第几个问号。这里只有1个问号，这是一个相对斗劲简单的数据库操纵，真正的项目中会远远比这个错杂
        //绑定text类型的数据库数据
        sqlite3_bind_double(statement, 1, List.sqlStartX);
        sqlite3_bind_double(statement, 2, List.sqlStartY);
        sqlite3_bind_int(statement, 3, List.sqlPlayerScore);
        sqlite3_bind_int(statement, 4, List.sqlPlayerLevel);
        sqlite3_bind_double(statement, 5, List.sqlPlayerTotleLife);
        sqlite3_bind_double(statement, 6, List.sqlPlayerTotleMagic);
        sqlite3_bind_int(statement, 7, List.sqlSaveWay);
        sqlite3_bind_int(statement, 8, List.sqlID);
        
        //履行SQL语句。这里是更新数据库
        success = sqlite3_step(statement);
        //开释statement
        sqlite3_finalize(statement);
        //若是履行失败
        if(success == SQLITE_ERROR) {
            NSLog(@"Error: failed to  the database with message.");
            //封闭数据库
            sqlite3_close(db);
            return NO;
        }
        //履行成功后依然要封闭数据库
        sqlite3_close(db);
        return YES;
    }
    return NO;
}
//删除数据
-(BOOL)deleteList:(sqlTestList *)deletList{
    if([self openDB]){
        sqlite3_stmt *statement;
        //组织SQL语句
        static char *sql = "delete from testTable  where testID = ?";
        //将SQL语句放入sqlite3_stmt中
        int success = sqlite3_prepare_v2(db, sql, -1, &statement, NULL);
        if (success != SQLITE_OK){
            NSLog(@"Error: failed to :testTable");
            sqlite3_close(db);
            return NO;
        }
        //这里的数字1，2，3代表第几个问号。这里只有1个问号，这是一个相对斗劲简单的数据库操纵，真正的项目中会远远比这个错杂
        sqlite3_bind_int(statement, 1, deletList.sqlID);
        //履行SQL语句。这里是更新数据库
        success = sqlite3_step(statement);
        //开释statement
        sqlite3_finalize(statement);
        //若是履行失败
        if(success == SQLITE_ERROR){
            NSLog(@"Error: failed to  the database with message.");
            //封闭数据库
            sqlite3_close(db);
            return NO;
        }
        //履行成功后依然要封闭数据库
        sqlite3_close(db);
        return YES;
    }
    return NO;
}

//查询数据
-(sqlTestList*)searchTestList:(int)searchID{
    sqlTestList* sqlList = [[sqlTestList alloc] init] ;
    //断定数据库是否打开
    if([self openDB]) {
        sqlite3_stmt *statement = nil;
        //sql语句
        char *sql = "SELECT * FROM testTable where sqlID = ?";
        //char *sql = "SELECT * FROM testTable WHERE testName like ？";//这里用like庖代=可以履行模糊查找，本来是"SELECT * FROM testTable WHERE testName = ？"
        if (sqlite3_prepare_v2(db, sql, -1, &statement, NULL) != SQLITE_OK){
            NSLog(@"Error: failed to prepare statement with message:search testValue.");
            return NO;
        } else {
            sqlite3_bind_int(statement, 1, searchID);
            //查询成果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while(sqlite3_step(statement) == SQLITE_ROW) {
                
                sqlList.sqlID = sqlite3_column_int(statement,1);
                sqlList.sqlStartX = sqlite3_column_double(statement,2);
                sqlList.sqlStartY = sqlite3_column_double(statement,3);
                sqlList.sqlPlayerScore = sqlite3_column_int(statement,4);
                sqlList.sqlPlayerLevel = sqlite3_column_int(statement,5);
                sqlList.sqlPlayerTotleLife = sqlite3_column_double(statement,6);
                sqlList.sqlPlayerTotleMagic = sqlite3_column_double(statement,7);
                sqlList.sqlSaveWay = sqlite3_column_double(statement,8);
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return sqlList;
}
@end

@implementation sqlTestList
@synthesize sqlID;
@synthesize sqlSaveWay,sqlStartX,sqlStartY;
@synthesize sqlPlayerScore,sqlPlayerLevel,sqlPlayerTotleLife,sqlPlayerTotleMagic;
-(id)init
{
    sqlID = 0;
    sqlStartX = 0.0;
    sqlStartY = 0.0;
    sqlPlayerScore = 0;
    sqlPlayerLevel = 0;
    sqlPlayerTotleLife = 0.0;
    sqlPlayerTotleMagic = 0.0;
    sqlSaveWay=0;
    return self;
};

-(void)dealloc
{
    [super dealloc];
}
@end