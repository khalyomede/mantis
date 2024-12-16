# CSS

Mantis provides type-safe CSS generation through its css module.

## Selectors

Create CSS selectors with type-checked properties:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.css { selector }

fn main() {
  content := selector(".container", {
    "max-width": "1200px"
    "margin": "0 auto"
  })

  println(content)
  // .container {
  //   max-width: 1200px;
  //   margin: 0 auto;
  // }
}
```

:::

## Mixed Property Types

The selector function accepts both string and numeric values:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.css { selector }

fn main() {
  button_style := selector(".button", {
    "padding": "8px 16px"
    "border-radius": 4
    "font-size": "1.2rem"
    "z-index": 100
  })

  println(button_style)
  // .button {
  //   padding: 8px 16px;
  //   border-radius: 4;
  //   font-size: 1.2rem;
  //   z-index: 100;
  // }
}
```

:::

## Combining With HTML

Use CSS generation alongside HTML components:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.html { style }
import khalyomede.mantis.css { selector }

fn main() {
  styles := [
    selector(".container", {
      "max-width": "1200px"
      "margin": "0 auto"
    }),
    selector(".button", {
      "padding": "8px 16px"
      "border-radius": 4
    })
  ]

  // Embed in HTML style tag
  stylesheet := style({}, [styles.join("\n")])

  println(stylesheet)
  // <style>
  // .container {
  //   max-width: 1200px;
  //   margin: 0 auto;
  // }
  // .button {
  //   padding: 8px 16px;
  //   border-radius: 4;
  // }
  // </style>
}
```

:::
