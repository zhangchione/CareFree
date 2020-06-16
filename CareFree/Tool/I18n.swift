//
//  I18n.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/30.
//  Copyright © 2020 张驰. All rights reserved.
//

import Foundation



// 国际化适配
class I18n {
    class func localizedString(_ key: String?) -> String {
        guard let key = key else { return "" }
        return NSLocalizedString(key, tableName: nil, bundle: Bundle(for: I18n.self), value: "", comment: "")
    }
}
