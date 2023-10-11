<div align="center">

<p>
        <a href="https://discord.gg/bDyKXGAQRu"><img src="https://img.shields.io/discord/1042743094833065985?color=5865F2&logo=discord&logoColor=white&label=QuickBlox%20Discord%20server&style=for-the-badge" alt="Discord server" /></a>
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
let text: String = ... // Replace this with the text you want to rephrase

let friendly = AITone(
    name: "Friendly",
    description: "This would adjust messages to reflect a casual, friendly tone. It would incorporate casual language, use emoticons, exclamation points, and other informalities to make the message seem more friendly and approachable.",
        icon: "🤝"
)

// Optionally, you can provide a history of previous messages to aid in rephrasing. 
let message1 = AIMessage(role: .me, text: "Hi there, how can I help you today?")
let message2 = AIMessage(role: .other, text: "I need help with the iOS Swift Package. How do I set it up? ")
let messages = [message1, message2]

// Rephrase text using an API key
do {
    let apiKey = "YOUR_OPENAI_API_KEY"
    let settings = AISettings(apiKey: apiKey, tone: friendly)
    let rephrasedText = try await QBAIRephrase.rephrase(text: text, history: messages, using: settings)
    print("Rephrased Text: \(rephrasedText)")
} catch {
    print("Error: \(error)")
}

// Rephrase text using a QuickBlox user token and proxy URL
do {
    let qbToken = "YOUR_QUICKBLOX_USER_TOKEN"
    let proxyURL = "https://your-proxy-server-url"
    let settings = AISettings(token: qbToken, serverPath: proxyURL, tone: friendly)
    let rephrasedText = try await QBAIRephrase.rephrase(text: text, history: messages, using: settings)
    print("Rephrased Text: \(rephrasedText)")
} catch {
    print("Error: \(error)")
}

```

## OpenAI

To use the OpenAI API and generate answers, you need to obtain an API key from OpenAI. Follow these steps to get your API key:

1. Go to the [OpenAI website](https://openai.com) and sign in to your account or create a new one.
2. Navigate to the [API](https://platform.openai.com/signup) section and sign up for access to the API.
3. Once approved, you will receive your [API key](https://platform.openai.com/account/api-keys), which you can use to make requests to the OpenAI API.

## Proxy Server

Using a proxy server like the [QuickBlox AI Assistant Proxy Server](https://github.com/QuickBlox/qb-ai-assistant-proxy-server) offers significant benefits in terms of security and functionality:

Enhanced Security:
- When making direct requests to the OpenAI API from the client-side, sensitive information like API keys may be exposed. By using a proxy server, the API keys are securely stored on the server-side, reducing the risk of unauthorized access or potential breaches.
- The proxy server can implement access control mechanisms, ensuring that only authenticated and authorized users with valid QuickBlox user tokens can access the OpenAI API. This adds an extra layer of security to the communication.

Protection of API Keys:
- Exposing API keys on the client-side could lead to misuse, abuse, or accidental exposure. A proxy server hides these keys from the client, mitigating the risk of API key exposure.
- Even if an attacker gains access to the client-side code, they cannot directly obtain the API keys, as they are kept confidential on the server.

Rate Limiting and Throttling:
- The proxy server can enforce rate limiting and throttling to control the number of requests made to the OpenAI API. This helps in complying with API usage policies and prevents excessive usage that might lead to temporary or permanent suspension of API access.

Request Logging and Monitoring:
- By using a proxy server, requests to the OpenAI API can be logged and monitored for auditing and debugging purposes. This provides insights into API usage patterns and helps detect any suspicious activities.

Flexibility and Customization:
- The proxy server acts as an intermediary, allowing developers to introduce custom functionalities, such as response caching, request modification, or adding custom headers. These customizations can be implemented without affecting the client-side code.

SSL/TLS Encryption:
- The proxy server can enforce SSL/TLS encryption for data transmission between the client and the server. This ensures that data remains encrypted and secure during communication.

## License

QBAIRephrase is released under the MIT License.

## Contribution

We welcome contributions to improve QBAIRephrase. If you find any issues or have suggestions, feel free to open an issue or submit a pull request on GitHub.
Join our Discord Server: https://discord.gg/bDyKXGAQRu

Happy coding! 🚀
