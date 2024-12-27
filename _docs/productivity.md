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
