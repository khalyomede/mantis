# Versioning policy

Here is what you need to know about the maintenance and evolution of versions for this package.

## Before 1.0.0

Breaking changes may occur in any minor version increment (0.x.0).

This follows the SemVer specification for initial development, which states that anything may change at any time during this phase.

Read the [upgrade instructions](/upgrade) for details on required changes between versions.

## After 1.0.0

### One Breaking Change Policy

Each major version increment introduces exactly one breaking change. This deliberate constraint makes upgrades more predictable and manageable.

When an upgrade causes an issue, you can quickly identify which change is responsible.

This approach also enables clear communication about what changed and why, as each major version has a single, well-defined purpose.

### Edge maintenance policy

Edge maintenance offers several benefits aligned with modern development practices.

#### Technical perspective

Your application receives security fixes faster since there's only one version to maintain.

The community naturally gravitates toward the latest version, creating a more unified ecosystem where everyone benefits from and contributes to the same codebase.

#### Development perspective

The development experience becomes more pleasant as you learn new features gradually rather than being overwhelmed by many changes at once. Each upgrade brings a small, digestible change that you can understand and implement at your own pace.

This approach reduces technical debt since you're never too far behind the latest version.

#### Maintenance considerations

Your team needs to actively monitor changes through social networks or release feeds.

Your development process must account for regular maintenance windows to handle updates.

While updates may be more frequent, each one is smaller and more manageable than traditional large-scale version migrations.

We believe these trade-offs create a more sustainable and developer-friendly ecosystem. By keeping changes small and focused, we can evolve the framework in response to real-world needs while maintaining stability and predictability.
