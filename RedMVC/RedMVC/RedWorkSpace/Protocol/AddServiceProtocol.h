//
//  RedTestProtocol.h
//  RedMVC
//
//  Created by jackiedeng on 2018/12/29.
//  Copyright © 2018 jackiedeng. All rights reserved.
//

#ifndef RedTestProtocol_h
#define RedTestProtocol_h

@protocol AddServiceProtocol <NSObject>
@required
- (int)Adda:(int)a
          b:(int)b;
@end

#endif /* RedTestProtocol_h */
