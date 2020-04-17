// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class ContinentsInfoQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query ContinentsInfo {
      continents {
        __typename
        name
        code
        countries {
          __typename
          ...CountryBasics
        }
      }
    }
    """

  public let operationName: String = "ContinentsInfo"

  public var queryDocument: String { return operationDefinition.appending(CountryBasics.fragmentDefinition) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("continents", type: .nonNull(.list(.nonNull(.object(Continent.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(continents: [Continent]) {
      self.init(unsafeResultMap: ["__typename": "Query", "continents": continents.map { (value: Continent) -> ResultMap in value.resultMap }])
    }

    public var continents: [Continent] {
      get {
        return (resultMap["continents"] as! [ResultMap]).map { (value: ResultMap) -> Continent in Continent(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Continent) -> ResultMap in value.resultMap }, forKey: "continents")
      }
    }

    public struct Continent: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Continent"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("code", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("countries", type: .nonNull(.list(.nonNull(.object(Country.selections))))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String, code: GraphQLID, countries: [Country]) {
        self.init(unsafeResultMap: ["__typename": "Continent", "name": name, "code": code, "countries": countries.map { (value: Country) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var code: GraphQLID {
        get {
          return resultMap["code"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "code")
        }
      }

      public var countries: [Country] {
        get {
          return (resultMap["countries"] as! [ResultMap]).map { (value: ResultMap) -> Country in Country(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Country) -> ResultMap in value.resultMap }, forKey: "countries")
        }
      }

      public struct Country: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Country"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(CountryBasics.self),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String, code: GraphQLID) {
          self.init(unsafeResultMap: ["__typename": "Country", "name": name, "code": code])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var countryBasics: CountryBasics {
            get {
              return CountryBasics(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public final class CountryInfoQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query CountryInfo($code: ID!) {
      country(code: $code) {
        __typename
        ...CountryDetails
      }
    }
    """

  public let operationName: String = "CountryInfo"

  public var queryDocument: String { return operationDefinition.appending(CountryDetails.fragmentDefinition).appending(StateDetails.fragmentDefinition).appending(LanguageDetails.fragmentDefinition) }

  public var code: GraphQLID

  public init(code: GraphQLID) {
    self.code = code
  }

  public var variables: GraphQLMap? {
    return ["code": code]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("country", arguments: ["code": GraphQLVariable("code")], type: .object(Country.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(country: Country? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "country": country.flatMap { (value: Country) -> ResultMap in value.resultMap }])
    }

    public var country: Country? {
      get {
        return (resultMap["country"] as? ResultMap).flatMap { Country(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "country")
      }
    }

    public struct Country: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Country"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(CountryDetails.self),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var countryDetails: CountryDetails {
          get {
            return CountryDetails(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public struct CountryBasics: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment CountryBasics on Country {
      __typename
      name
      code
    }
    """

  public static let possibleTypes: [String] = ["Country"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("code", type: .nonNull(.scalar(GraphQLID.self))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(name: String, code: GraphQLID) {
    self.init(unsafeResultMap: ["__typename": "Country", "name": name, "code": code])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var name: String {
    get {
      return resultMap["name"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  public var code: GraphQLID {
    get {
      return resultMap["code"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "code")
    }
  }
}

public struct CountryDetails: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment CountryDetails on Country {
      __typename
      code
      name
      phone
      currency
      emoji
      continent {
        __typename
        name
        code
      }
      states {
        __typename
        ...StateDetails
      }
      languages {
        __typename
        ...LanguageDetails
      }
    }
    """

  public static let possibleTypes: [String] = ["Country"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("code", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("phone", type: .nonNull(.scalar(String.self))),
    GraphQLField("currency", type: .scalar(String.self)),
    GraphQLField("emoji", type: .nonNull(.scalar(String.self))),
    GraphQLField("continent", type: .nonNull(.object(Continent.selections))),
    GraphQLField("states", type: .nonNull(.list(.nonNull(.object(State.selections))))),
    GraphQLField("languages", type: .nonNull(.list(.nonNull(.object(Language.selections))))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(code: GraphQLID, name: String, phone: String, currency: String? = nil, emoji: String, continent: Continent, states: [State], languages: [Language]) {
    self.init(unsafeResultMap: ["__typename": "Country", "code": code, "name": name, "phone": phone, "currency": currency, "emoji": emoji, "continent": continent.resultMap, "states": states.map { (value: State) -> ResultMap in value.resultMap }, "languages": languages.map { (value: Language) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var code: GraphQLID {
    get {
      return resultMap["code"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "code")
    }
  }

  public var name: String {
    get {
      return resultMap["name"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  public var phone: String {
    get {
      return resultMap["phone"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "phone")
    }
  }

  public var currency: String? {
    get {
      return resultMap["currency"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "currency")
    }
  }

  public var emoji: String {
    get {
      return resultMap["emoji"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "emoji")
    }
  }

  public var continent: Continent {
    get {
      return Continent(unsafeResultMap: resultMap["continent"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "continent")
    }
  }

  public var states: [State] {
    get {
      return (resultMap["states"] as! [ResultMap]).map { (value: ResultMap) -> State in State(unsafeResultMap: value) }
    }
    set {
      resultMap.updateValue(newValue.map { (value: State) -> ResultMap in value.resultMap }, forKey: "states")
    }
  }

  public var languages: [Language] {
    get {
      return (resultMap["languages"] as! [ResultMap]).map { (value: ResultMap) -> Language in Language(unsafeResultMap: value) }
    }
    set {
      resultMap.updateValue(newValue.map { (value: Language) -> ResultMap in value.resultMap }, forKey: "languages")
    }
  }

  public struct Continent: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Continent"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("name", type: .nonNull(.scalar(String.self))),
      GraphQLField("code", type: .nonNull(.scalar(GraphQLID.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(name: String, code: GraphQLID) {
      self.init(unsafeResultMap: ["__typename": "Continent", "name": name, "code": code])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var name: String {
      get {
        return resultMap["name"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "name")
      }
    }

    public var code: GraphQLID {
      get {
        return resultMap["code"]! as! GraphQLID
      }
      set {
        resultMap.updateValue(newValue, forKey: "code")
      }
    }
  }

  public struct State: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["State"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLFragmentSpread(StateDetails.self),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(name: String, code: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "State", "name": name, "code": code])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }

    public struct Fragments {
      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var stateDetails: StateDetails {
        get {
          return StateDetails(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }

  public struct Language: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Language"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLFragmentSpread(LanguageDetails.self),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(name: String? = nil, native: String? = nil, code: GraphQLID) {
      self.init(unsafeResultMap: ["__typename": "Language", "name": name, "native": native, "code": code])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }

    public struct Fragments {
      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var languageDetails: LanguageDetails {
        get {
          return LanguageDetails(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }
}

public struct LanguageDetails: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment LanguageDetails on Language {
      __typename
      name
      native
      code
    }
    """

  public static let possibleTypes: [String] = ["Language"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("name", type: .scalar(String.self)),
    GraphQLField("native", type: .scalar(String.self)),
    GraphQLField("code", type: .nonNull(.scalar(GraphQLID.self))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(name: String? = nil, native: String? = nil, code: GraphQLID) {
    self.init(unsafeResultMap: ["__typename": "Language", "name": name, "native": native, "code": code])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var name: String? {
    get {
      return resultMap["name"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  public var native: String? {
    get {
      return resultMap["native"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "native")
    }
  }

  public var code: GraphQLID {
    get {
      return resultMap["code"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "code")
    }
  }
}

public struct StateDetails: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment StateDetails on State {
      __typename
      name
      code
    }
    """

  public static let possibleTypes: [String] = ["State"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("code", type: .scalar(String.self)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(name: String, code: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "State", "name": name, "code": code])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var name: String {
    get {
      return resultMap["name"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  public var code: String? {
    get {
      return resultMap["code"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "code")
    }
  }
}
