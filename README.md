# Arqonara Java Images

Multi-version Azul Zulu JDK images based on Debian Bookworm, optimized for Pterodactyl Panel.

## Java Versions
- Java 25
- Java 21
- Java 17
- Java 11
- Java 8

## Available Images

Copy the image path below to your Pterodactyl Docker Image configuration:

| Version | Image Path |
| :--- | :--- |
| **Java 25** | `ghcr.io/arqonarateam/arqonara-java:java_25` |
| **Java 21** | `ghcr.io/arqonarateam/arqonara-java:java_21` |
| **Java 17** | `ghcr.io/arqonarateam/arqonara-java:java_17` |
| **Java 11** | `ghcr.io/arqonarateam/arqonara-java:java_11` |
| **Java 8** | `ghcr.io/arqonarateam/arqonara-java:java_8` |

## Customization

You can customize the terminal output prefix using environment variables in your Pterodactyl startup settings or Docker environment.

### Environment Variables

| Variable | Description | Default Value |
| :--- | :--- | :--- |
| `PREFIX_DOCKER` | The text displayed before commands in the console. | `container@pterodactyl~ ` |
| `PREFIX_COLOR` | The ANSI color code for the prefix. | `\033[1m\033[33m` (Bold Yellow) |

### Usage Examples

#### Changing the Prefix Text
Set `PREFIX_DOCKER` to `my-server > `:
```env
PREFIX_DOCKER="my-server > "
```

#### Changing the Color
Set `PREFIX_COLOR` to Bold Cyan (`\033[1m\033[36m`):
```env
PREFIX_COLOR="\033[1m\033[36m"
```

#### Common ANSI Color Codes
- **Red:** `\033[0;31m`
- **Green:** `\033[0;32m`
- **Yellow:** `\033[0;33m`
- **Blue:** `\033[0;34m`
- **Purple:** `\033[0;35m`
- **Cyan:** `\033[0;36m`
- **Bold White:** `\033[1;37m`

## Image Features
- **Azul Zulu JDK**: High-performance, production-ready OpenJDK distribution.
- **Auto-IP**: Automatically detects internal container IP (`INTERNAL_IP`).
- **Startup Parsing**: Automatically converts Pterodactyl `{{VARIABLE}}` format to shell variables.
- **Pre-execution Utility**: Runs the Arqonara entrypoint utility before starting the Java process.
