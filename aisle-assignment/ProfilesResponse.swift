//
//  ProfilesResponse.swift
//  aisle-assignment
//
//  Created by Shruti S on 19/08/23.
//


import Foundation

// MARK: - ProfilesResponse
struct ProfilesResponse: Codable {
    let invites: Invites
    let likes: Likes
}

// MARK: - Invites
struct Invites: Codable {
    let profiles: [InvitesProfile]
    let totalPages, pendingInvitationsCount: Int

    enum CodingKeys: String, CodingKey {
        case profiles, totalPages
        case pendingInvitationsCount = "pending_invitations_count"
    }
}

// MARK: - InvitesProfile
struct InvitesProfile: Codable {
    let generalInformation: GeneralInformation
    let approvedTime, disapprovedTime: Double
    let photos: [Photo]
    let userInterests: [JSONAny]
    let work: Work
    let preferences: [ProfilePreference]
    let instagramImages: JSONNull?
    let lastSeenWindow: String
    let isFacebookDataFetched: Bool
    let icebreakers, story, meetup: JSONNull?
    let verificationStatus: String
    let hasActiveSubscription, showConciergeBadge: Bool
    let lat, lng: Double
    let lastSeen: JSONNull?
    let onlineCode: Int
    let profileDataList: [ProfileDataList]

    enum CodingKeys: String, CodingKey {
        case generalInformation = "general_information"
        case approvedTime = "approved_time"
        case disapprovedTime = "disapproved_time"
        case photos
        case userInterests = "user_interests"
        case work, preferences
        case instagramImages = "instagram_images"
        case lastSeenWindow = "last_seen_window"
        case isFacebookDataFetched = "is_facebook_data_fetched"
        case icebreakers, story, meetup
        case verificationStatus = "verification_status"
        case hasActiveSubscription = "has_active_subscription"
        case showConciergeBadge = "show_concierge_badge"
        case lat, lng
        case lastSeen = "last_seen"
        case onlineCode = "online_code"
        case profileDataList = "profile_data_list"
    }
}

// MARK: - GeneralInformation
struct GeneralInformation: Codable {
    let dateOfBirth, dateOfBirthV1: String
    let location: Location
    let drinkingV1: DrinkingV1Class
    let firstName, gender: String
    let maritalStatusV1: MaritalStatusV1Class
    let refID: String
    let smokingV1: DrinkingV1Class
    let sunSignV1, motherTongue, faith: Faith
    let height: Int
    let cast, kid, diet, politics: JSONNull?
    let pet, settle, mbti: JSONNull?
    let age: Int

    enum CodingKeys: String, CodingKey {
        case dateOfBirth = "date_of_birth"
        case dateOfBirthV1 = "date_of_birth_v1"
        case location
        case drinkingV1 = "drinking_v1"
        case firstName = "first_name"
        case gender
        case maritalStatusV1 = "marital_status_v1"
        case refID = "ref_id"
        case smokingV1 = "smoking_v1"
        case sunSignV1 = "sun_sign_v1"
        case motherTongue = "mother_tongue"
        case faith, height, cast, kid, diet, politics, pet, settle, mbti, age
    }
}

// MARK: - DrinkingV1Class
struct DrinkingV1Class: Codable {
    let id: Int
    let name, nameAlias: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAlias = "name_alias"
    }
}

// MARK: - Faith
struct Faith: Codable {
    let id: Int
    let name: String
}

// MARK: - Location
struct Location: Codable {
    let summary, full: String
}

// MARK: - MaritalStatusV1Class
struct MaritalStatusV1Class: Codable {
    let id: Int
    let name: String
    let preferenceOnly: Bool

    enum CodingKeys: String, CodingKey {
        case id, name
        case preferenceOnly = "preference_only"
    }
}

// MARK: - Photo
struct Photo: Codable {
    let photo: String
    let photoID: Int
    let selected: Bool
    let status: String?

    enum CodingKeys: String, CodingKey {
        case photo
        case photoID = "photo_id"
        case selected, status
    }
}

// MARK: - ProfilePreference
struct ProfilePreference: Codable {
    let answerID, id, value: Int
    let preferenceQuestion: PreferenceQuestion

    enum CodingKeys: String, CodingKey {
        case answerID = "answer_id"
        case id, value
        case preferenceQuestion = "preference_question"
    }
}

// MARK: - PreferenceQuestion
struct PreferenceQuestion: Codable {
    let firstChoice, secondChoice: String

    enum CodingKeys: String, CodingKey {
        case firstChoice = "first_choice"
        case secondChoice = "second_choice"
    }
}

// MARK: - ProfileDataList
struct ProfileDataList: Codable {
    let question: String
    let preferences: [ProfileDataListPreference]
    let invitationType: String

    enum CodingKeys: String, CodingKey {
        case question, preferences
        case invitationType = "invitation_type"
    }
}

// MARK: - ProfileDataListPreference
struct ProfileDataListPreference: Codable {
    let answerID: Int
    let answer, firstChoice, secondChoice: String

    enum CodingKeys: String, CodingKey {
        case answerID = "answer_id"
        case answer
        case firstChoice = "first_choice"
        case secondChoice = "second_choice"
    }
}

// MARK: - Work
struct Work: Codable {
    let industryV1: MaritalStatusV1Class
    let monthlyIncomeV1: JSONNull?
    let experienceV1: DrinkingV1Class
    let highestQualificationV1: MaritalStatusV1Class
    let fieldOfStudyV1: Faith

    enum CodingKeys: String, CodingKey {
        case industryV1 = "industry_v1"
        case monthlyIncomeV1 = "monthly_income_v1"
        case experienceV1 = "experience_v1"
        case highestQualificationV1 = "highest_qualification_v1"
        case fieldOfStudyV1 = "field_of_study_v1"
    }
}

// MARK: - Likes
struct Likes: Codable {
    let profiles: [LikesProfile]
    let canSeeProfile: Bool
    let likesReceivedCount: Int

    enum CodingKeys: String, CodingKey {
        case profiles
        case canSeeProfile = "can_see_profile"
        case likesReceivedCount = "likes_received_count"
    }
}

// MARK: - LikesProfile
struct LikesProfile: Codable {
    let firstName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case avatar
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
