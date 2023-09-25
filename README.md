<div align="center">

<p>
        <a href="https://discord.gg/SSSdDNgf"><img src="https://img.shields.io/discord/1042743094833065985?color=5865F2&logo=discord&logoColor=white&label=QuickBlox%20Discord%20server&style=for-the-badge" alt="Discord server" /></a>
</p>

</div>

#  QBAIRephrase

QBAIRephrase is a Swift package that provides text rephrasing and tone management functionalities, including integration with the OpenAI API.

## Installation

QBAIRephrase can be installed using Swift Package Manager. To include it in your Xcode project, follow these steps:

1. In Xcode, open your project, and navigate to File > Swift Packages > Add Package Dependency.
2. Enter the repository URL `https://github.com/QuickBlox/ios-ai-rephrase` and click Next.
3. Choose the appropriate version rule and click Next.
4. Finally, click Finish to add the package to your project.

## Usage

To use QBAIRephrase in your project, follow these steps:

1. Import the QBAIRephrase module:

```swift
import QBAIRephrase
```

2. Rephrase text using the OpenAI API:

```swift
let text: String = ... // Replace with your text
// Rephrase text using an API key
do {
    let apiKey = "YOUR_OPENAI_API_KEY"
    let rephrasedText = try await QBAIRephrase.openAI(rephrase: text, tone: .empathetic, secret: apiKey)
    print("Rephrased Text: \(rephrasedText)")
} catch {
    print("Error: \(error)")
}

// Rephrase text using a QuickBlox user token and proxy URL
do {
    let qbToken = "YOUR_QUICKBLOX_USER_TOKEN"
    let proxyURL = "https://your-proxy-server-url"
    let rephrasedText = try await QBAIRephrase.openAI(rephrase: text, tone: .empathetic, qbToken: qbToken, proxy: proxyURL)
    print("Rephrased Text: \(rephrasedText)")
} catch {
    print("Error: \(error)")
}

```
## Customization

You can manage tones and rephrase text as follows:
```swift
// Access available tones
let availableTones = QBAIRephrase.tones

// Reset tones to default predefined values
QBAIRephrase.resetTonesToDefault()

// Remove a specific tone
let toneToRemove: Tone = ... // Replace with your tone that corresponds to the Tone protocol
QBAIRephrase.remove(toneToRemove)

// Remove a specific tone (ToneInfo)
QBAIRephrase.remove(tone: .sarcastic)

// Remove a tone at a specified index
let indexToRemove: Int = 0 // Replace with the index
QBAIRephrase.removeTone(at: indexToRemove)

// Retrieve the index of a specific tone
let toneToFind: Tone = ... // Replace with your tone that corresponds to the Tone protocol
let toneIndex = QBAIRephrase.index(of: toneToFind)

// Retrieve the index of a specific tone (ToneInfo)
let toneIndex = QBAIRephrase.toneIndex(.sarcastic)

// Insert a specific tone at a specified index
let toneToInsert: Tone = ... // Replace with your tone that corresponds to the Tone protocol
let indexToInsert: Int = 0 // Replace with the index
QBAIRephrase.insert(toneToInsert, at: indexToInsert)

// Insert a specific tone (ToneInfo) at a specified index
QBAIRephrase.insert(tone: .sarcastic, at: 2)

// Append a specific tone
let toneToAppend: Tone = ... // Replace with your tone type
QBAIRephrase.append(toneToAppend)

// Append a specific tone (ToneInfo)
let toneInfoToAppend: ToneInfo = ... // Replace with your tone that corresponds to the Tone protocol
QBAIRephrase.append(tone: toneInfoToAppend)
```
## Exception Handling

The QBAIException enum represents various exceptions that can be thrown during rephrasing:

- incorrectToken: Thrown when the provided token has an incorrect value.
- incorrectTokensCount: Thrown when the provided text tokens count has an incorrect value.
- incorrectProxyServerUrl: Thrown when the server URL has an incorrect value.

## License

QBAIRephrase is released under the MIT License.

## Contribution

We welcome contributions to improve QBAIRephrase. If you find any issues or have suggestions, feel free to open an issue or submit a pull request on GitHub.
Join our Discord Server: https://discord.gg/SSSdDNgf

Happy coding! 🚀
