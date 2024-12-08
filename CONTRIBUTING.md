# Contributing

These guidelines help having a systematic approach to contributions.

They are not to be taken everytime at 100%. See them as guidance for coherence.

- [1. Create an issue before a pull request](#1-create-an-issue-before-a-pull-request)
- [2. Clone the project](#2-clone-the-project)
- [3. Get familiar with testings](#3-get-familiar-with-testings)
- [4. Update the docs](#2-update-the-docs)
- [5. Be respectful](3-be-respectful)
- [6. No politics](#4-no-politics)

## 1. Create an issue before a pull request

This ensure we have a space where we can discuss and improve the spec of the feature that is contributed.

Even the smallest contributions should start from an issue to better keep track of them.

They also help avoiding duplicates and regressions.

## 2. Clone the project

```bash
git clone git@github.com:khalyomede/mantis.git
cd mantis
docker compose up
docker compose exec v sh
```

Then inside the Docker container, ensure V is working:

```bash
v --version
```

Run the tests:

```bash
v test src
```

## 3. Get familiar with testings

Your pull request must be well tested in order to not get rejected during review.

Please browse the "tests" folder to get a glimse of how mantis is tested.

## 4. Update the docs

If you contribution is modifying or adding new features, think about documenting the change on the appropriate section of the documentation.

_The documentation support is not ready yet. This will most likely be a Vitepress project at first, moving to a Mantis web app in the long term._

## 5. Be respectful

Speak nicely, say hello, try to be optimistic in any regards.

Encourage people. Repeat and explain even if the questions has already been asked. Rephrase and clarify if needed.

Always take into account that negative (constructive) comments have required time for the reviewer. This means despite the negative aspect, the person actually cares about making this project better.

Try to balance (constructive) critics with compliments. This helps value the time spent by other people contributing.

As a good teacher of mine said:

> There is no problems, only solutions.

## 6. No politics

We believe code and open-source is a inclusive space where every people regardless their politic beliefs, religion, ethnicity is welcome.

Only debate about code.

Let this repository be a programming safe heaven (there is enough bad things out there).
