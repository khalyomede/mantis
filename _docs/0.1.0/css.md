# CSS

Mantis provides type-safe CSS generation through its css module.

## Style

Use the `style()` function to generate CSS rules in a type-safe manner.

::: code-group

```v [main.v]
module main

import khalyomede.mantis.css { style, selector }
import khalyomede.mantis.css.property { display, align_items }

fn main() {
  content := style([
    selector(".card-title", [
      display(.flex)
      align_items(.center)
    ])
  ])

  println(content) // .card-title{display:flex;align-items:center;}
}
```

:::

## Paired with HTML

This method pairs well with the [`style()` HTML function](/0.1.0/html#style):

::: code-group

```v [main.v]
module main

import khalyomede.mantis.css { selector }
import khalyomede.mantis.css.property { display, align_items }
import khalyomede.mantis.html { style }

fn main() {
  content := style({}, [
    css.style([
      selector(".card-title", [
        display(.flex)
        align_items(.center)
      ])
    ])
  ])

  println(content) // <style>.card-title{display:flex;align-items:center;}</style>
}
```

:::

## Available properties

As there is too much elements, follow these steps:

1. Try to "guess" the function by importing and using it according to the name you would expect
2. If it does not compile, check on the [Github repository css/property](https://github.com/khalyomede/mantis/tree/master/css/property) folder to you find it (make sure to select the correct version)
3. If it does not exists, please make a pull request or create an issue with the link to the [MDN](https://developer.mozilla.org/en-US/) doc
