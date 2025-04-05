# Sui Certificate Web3 (Bootcamp Project)

Sui Certificate Web3 is a blockchain-based system for issuing and managing verifiable digital certificates on the Sui network. It leverages the Move programming language to provide secure and efficient certificate management.

## Features

- **Digital Certificates**: Issue and manage verifiable digital certificates.
- **Institutional Verification**: Support multi-party verification for credentials.

## Prerequisites

- Sui CLI installed
- Move language knowledge
## Quick Start

1. **Clone the repository**:

   ```bash
   git clone https://github.com/kowalski21/sui-certificate-web3.git
   cd sui-certificate-web3
   ```

2. **Build the project**:

   ```bash
   sui move build
   ```

3. **Deploy to network **:

   ```bash
   # Using the active environment
   sui client publish --gas-budget 20000000
   ```
## Architecture

### Core Components

1. **Platform**: System administration, fee management, global settings.
2. **Institution**: Credential management, certificate issuance, reputation tracking.
3. **Credentials**: Certificate templates, validation rules, metadata management.

## Data Structures

### Main Structs


```move
struct Platform has key {
    id: UID,
    admin: address,
    revenue: Balance<SUI>,
    verification_fee: u64
}

struct Institution has key {
    id: UID,
    name: String,
    address: address,
    credentials: LinkedTable<String, Credential>,
    reputation_score: u64,
    verified: bool
}
```


## Security

### Key Security Features

- Multi-party verification
- Time-locked credentials
- Revocation system
- Access control mechanisms

### Best Practices

1. Always verify institutional authority.
2. Implement proper access controls.
3. Validate all credential requirements.
4. Maintain audit trails.

## Contributing

1. Fork the repository.
2. Create a feature branch.
3. Commit your changes.
4. Push to the branch.
5. Create a Pull Request.

## License

This project is licensed under the MIT License.

## Contact

- **Project Maintainer**: [Douglas Amoo-Sargon]
- **Email**: [douglasbiomed3@gmail.com]


## Troubleshooting

### Common Issues

1. **Transaction Failures**:
   - Check gas budget
   - Verify proper permissions.

## Additional Resources

- [Sui Documentation](https://sui.io/developers)
- [Move Language Book](https://move-language.github.io/move/)
- [Sui Security Audits](https://sui.io/security)

A big shoutout to the SUI Move Team Ghana for helping me understand Sui..