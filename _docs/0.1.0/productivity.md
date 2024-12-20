# Productivity

Here is some quick aliases to run [V](https://vlang.io/) without Docker Compose prefixes.

::: code-group

```bash [Linux]
# ~/.bash_aliases
alias v="docker compose run --rm v"
alias vs="docker compose run --rm --service-ports v"
```

```bash [Mac]
# ~/.zshrc
alias v="docker compose run --rm v"
alias vs="docker compose run --rm --service-ports v"
```

:::

## Running V in development

[V](https://vlang.io/) can watch your files when you save. It will recompile your files and let you know of any errors.

```bash
v watch run main.v
```

## Running V in production mode

[V](https://vlang.io/) will compile your whole web app into a single executable.

You need to target the OS where your executable will be run using the `-os` flag.

```bash
v -N -W -prod -compress -os linux -obfuscate -skip-unused -o main main.v
```
