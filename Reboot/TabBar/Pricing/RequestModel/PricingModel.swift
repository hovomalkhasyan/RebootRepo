//
//  PricingModel.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 16.03.21.
//

import Foundation

// MARK: - Welcome
struct PlanModel: Codable {
    let numResults, offset, limit: Int
    let objects: [Objects]
}

// MARK: - Object
struct Objects: Codable {
    let title: String
    let id: Int
    let plansList: [PlansList]
    let content, slug: String
    let isTab: Bool
    let contentBottom: String
}

// MARK: - PlansList
struct PlansList: Codable {
    let title: String
    let id: Int
    let planTypeVerbose: String
    let expirationDays, categoryID: Int?
    let isSale, allowTrial, allowCredit: Bool
    let content: String
    let isFree, isShowTitle, isFirst: Bool
    let price: Int
    let planType: String
    let isUnlimited: Bool
    let workoutsCount: Int
    let isShowTitleAccountPage, isOnline: Bool
    let bottomContent: String

}
