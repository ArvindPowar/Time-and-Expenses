//
//  ProjectVO.h
//  TaskTracker
//
//  Created by arvind on 4/1/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectVO : NSObject
@property(nonatomic,retain) NSString *project_id,*client_id,*user_id,*project_name,*project_location,*usedefaultsetting,*ratehourly_daily_project,*project_tax,*project_vat,*projectovertimehour,*projectovertimerate,*projectdaily_weekly,*activeprojectStr,*citrStr,*stateStr,*zipStr,*countryStr,*defaultratevalue;
@end
