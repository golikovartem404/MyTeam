//
//  EmployeeModel.swift
//  MyTeam
//
//  Created by User on 21.11.2022.
//

import Foundation

struct EmployeeModel: Codable {
    let id: String
    let avatarURL: String?
    let firstName: String
    let lastName: String
    let userTag: String
    let department: DepartmentModel
    let position: String
    let birthday: String
    var birthdayDate: Date? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let date = dateFormatterGet.date(from: birthday)
        return date
    }
    let phone: String
}

struct EmployeeList: Codable {
    let items: [EmployeeModel]
}
