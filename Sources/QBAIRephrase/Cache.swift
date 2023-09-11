import Foundation
/// A class responsible for caching and managing tones using UserDefaults.
final class Cache {
    /// The UserDefaults key used for storing custom locale data.
    static var key = "QBAIRephrase.Tones"
    
    /// An array of default tone information.
    static private let defaultTones: [ToneInfo] = [
        .professional,
        .friendly,
        .encouraging,
        .empathetic,
        .neutral,
        .assertive,
        .instructive,
        .persuasive,
        .sarcastic,
        .poetic
    ]
    
    /// Retrieves the cached or default tones.
    static var tones: [ToneInfo] {
        get {
            if let cached = cached {
                return cached
            } else {
                save(defaultTones)
            }
            return defaultTones
        }
    }
    
    /// Retrieves the cached tones from UserDefaults, if available.
    static private var cached: [ToneInfo]? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        return try? JSONDecoder().decode([ToneInfo].self, from: data)
    }
    
    /// Saves the provided tones to UserDefaults.
    ///
    /// - Parameter tones: The tones to be saved.
    static func save(_ tones: [ToneInfo]) {
        guard let data = try? JSONEncoder().encode(tones) else {
            return
        }
        UserDefaults.standard.set(data, forKey: key)
    }
    
    /// Resets the cached tones by removing the UserDefaults data.
    static func reset() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
