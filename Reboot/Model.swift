//
//  Model.swift
//  Reboot
//
//  Created by Hovo on 11/11/20.
//

import Foundation

// MARK: - Welcome
struct LoginResponse: Codable {
    var lastOccupiedReserve: String?
    var user: User
    var token: String
    
}

// MARK: - User
struct User: Codable {
    let referralKey: String
    let lastName: String
    let city: String?
    let id: Int
    let avatarThumb: String?
    let birthDate: String?
    let subscribedToTriggerEmails: Bool
    let onlinePackages, packages: [Package]
    let favoriteStudio: String?
    let watchedVideoWorkouts: [Int]
    let gender, email: String?
    let loyaltyLevel: LoyaltyLevel
    let emergencyName, instagram: String?
    let username : String?
    let phone: String?
    let rulesAcceptedVersion: Int
    let firstName: String
    let emergencyPhone: String?
    let bonusesBalance: Int
    let isStaff: Bool
    let hasAnyPackage: Bool
    let address: String?
    let avatar: String?
    let occupation: String?
    
}

// MARK: - LoyaltyLevel
struct LoyaltyLevel: Codable {
    let iconInactive: String?
    let activationPeriod: Int
    let title, description: String?
    let id: Int?
    let iconActive: String?
    let progress: [Int]
    let subscribePercentage: Int?
}

// MARK: - Package
struct Package: Codable {
    let created: String?
    let plan: Plan
    let id: Int
    let expirationDate: String?
    let initialWorkoutsCount, workoutsCount: Int?
    
}

// MARK: - Plan
struct Plan: Codable {
    let isOnline: Bool
    let planType: String?
    let expirationDays: Int?
    let title, content: String?
    let isFirst, isFree: Bool
    let price, id: Int?
    let isSale, isShowTitleAccountPage: Bool?
    let planTypeVerbose: String?
    let categoryID: Int?
    let isUnlimited: Bool
    let bottomContent: String?
    let isShowTitle, allowTrial, allowCredit: Bool
    let workoutsCount: Int?
    
    
}

//MARK: - USER

struct AccountResponse: Codable {
    let occupation: String?
    let city: String?
    let gender: String?
    let onlinePackages: [Packages]?
    let username: String
    let hasAnyPackage: Bool
    let favoriteStudio, emergencyPhone: String?
    let packages: [Packages]?
    let referralKey, birthDate, email: String?
    let watchedVideoWorkouts: [Int]?
    let loyaltyLevel: LoyaltyLevels?
    let id: Int
    let firstName: String
    let bonusesBalance: Int
    let altID: Int?
    let subscribedToTriggerEmails: Bool
    let rulesAcceptedVersion: Int?
    let instagram, emergencyName, avatarThumb: String?
    let address: String?
    let avatar: String?
    let isStaff: Bool
    let lastName, phone: String?
    
    var fullName: String {
        return (lastName ?? "") + " " + firstName
    }
}

// MARK: - LoyaltyLevel
struct LoyaltyLevels: Codable {
    let activationPeriod: Int
    let iconActive, description: String?
    let subscribePercentage: Int
    let progress: [Int]
    let id: Int
    let title, iconInactive: String?
    
}

// MARK: - Package
struct Packages: Codable {
    let expirationDate: String?
    let plan: Plans
    let workoutsCount: Int
    let created: String?
    let id, initialWorkoutsCount: Int
    
}

// MARK: - Plan
struct Plans: Codable {
    let isFree, isOnline: Bool
    let workoutsCount, expirationDays: Int
    let isShowTitleAccountPage: Bool
    let planType: String?
    let categoryID: Int?
    let allowTrial: Bool
    let bottomContent: String?
    let allowCredit, isSale: Bool
    let title: String?
    let price: Int
    let content: String?
    let id: Int
    let isUnlimited, isFirst: Bool
    let planTypeVerbose: String?
    let isShowTitle: Bool
    
}

//MARK: - reserves
struct ReserveResp: Codable {
    let numResults, offset, limit: Int
    let objects: [Object]
    
}

// MARK: - Object
struct Object: Codable {
    let workoutPlace: WorkoutPlace
    let created, reserveCode: String
    let workout: Workout
    let isCancelled: Bool
    let id: Int
    let trainingProductsOrders: [String]
    let altID : String?
    let reserveStatus: String
    
    
}

// MARK: - Workout
struct Workout: Codable {
    let hint, dateFrom, hintPopup: String
    let trainer: Trainer
    let workoutDay: WorkoutDay
    let replacedTrainer: String?
    let id: Int
    let dateTo, title: String
    let inEnglish: Bool
    
}

// MARK: - Trainer
struct Trainer: Codable {
    let thumb, slug, image, titleGeniitive: String
    let imageAlt, slogan, job: String
    let id: Int
    let title: String
}

// MARK: - WorkoutDay
struct WorkoutDay: Codable {
    let workoutType: WorkoutType
    let room: Room
    let id: Int
    let workoutDate: String
    
}

// MARK: - Room
struct Room: Codable {
    let isOnline: Bool
    let titleShort, schemaImage, slug, imageAlt: String
    let id: Int
    let title, phone, onlineLink: String
    
}

// MARK: - WorkoutType
struct WorkoutType: Codable {
    let slug, iconAlt, body: String
    let id: Int
    let icon, title: String
    
}

// MARK: - WorkoutPlace
struct WorkoutPlace: Codable {
    let roomPlace: RoomPlace
    let status: String?
    let id: Int
    
}

// MARK: - RoomPlace
struct RoomPlace: Codable {
    let standardPlace: StandardPlace
    let roomPlaceLeft: Int?
    let id: Int
    let placeNumber: String
    let top: Int
    
}

// MARK: - StandardPlace
struct StandardPlace: Codable {
    let height: Int
    let image, bg: String
    let id, width: Int
}

//MARK: - mobile

struct BaseResponseModel: Codable {
    let user: UserResponse
    let bonus: Bonus
    let reserves: [Reserves]?
    let activity: Activity?
    let achievement: Achievement?
    let ads: [Ads]?
}

// MARK: - Activity
struct Activity: Codable {
    let lastActivity, activityDays, activityWeeks: Int
    let compareCount: String
}

struct Achievement: Codable {
   let title: String?
   let achievement: Int?
    
    var achivementWithTitle: String {
        guard let title = title, let achvements = achievement else {
            return "Нет достижений"
        }
        return title + " " + String(achvements) + "X"
    }
}
// MARK: - Bonus
struct Bonus: Codable {
    let bonus: String
}

// MARK: - User
struct UserResponse: Codable {
    let userAvatar: String?
    let userName: String
    let loyalty: Loyalty?
}

// MARK: - Loyalty
struct Loyalty: Codable {
    let title, description: String
    let activationPeriod, subscribePercentage: Int
    let body, iconActive, iconInactive: String
}

struct Ads: Codable {
    let title: String
    let image: String?
    let url: String
}

struct Reserves:Codable {
    let dateFrom: String
    let workoutTrainerTitle: String
    let workoutDayRoomSlug: String
    let workoutPlaceRoomPlaceNumber: String
}
