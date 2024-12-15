# Contributing

These guidelines help having a systematic approach to contributions.

They are not to be taken everytime at 100%. See them as guidance for coherence.

- [1. For security issues and CVE](#1-for-security-issues-and-cve)
- [2. Create an issue before a pull request](#2-create-an-issue-before-a-pull-request)
- [3. Clone the project](#3-clone-the-project)
- [4. Get familiar with testings](#4-get-familiar-with-testings)
- [5. Update the docs](5-update-the-docs)
- [6. Be respectful](6-be-respectful)
- [7. No politics](#7-no-politics)

## 1. For security issues and CVE

First of all, thank you a lot for the precious time you took to figure out a critical vunlerability.

Please make sure you have documented the way to reproduce the issue so we can patch it as quick as possible.

To report it, do not use the Github issue tracker, and instead send an email at:

```
khalyomede@gmail.com
```

Ideally with a big title

```
[MANTIS] remote code execution when...
```

Thank you again!

## 2. Create an issue before a pull request

This ensure we have a space where we can discuss and improve the spec of the feature that is contributed.

Even the smallest contributions should start from an issue to better keep track of them.

They also help avoiding duplicates and regressions.

## 3. Clone the project

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

## 4. Get familiar with testings

Your pull request must be well tested in order to not get rejected during review.

Please browse the "tests" folder to get a glimse of how mantis is tested.

## 5. Update the docs

If you contribution is modifying or adding new features, think about documenting the change on the appropriate section of the documentation.

_The documentation support is not ready yet. This will most likely be a Vitepress project at first, moving to a Mantis web app in the long term._

## 6. Be respectful

Speak nicely, say hello, try to be optimistic in any regards.

Encourage people. Repeat and explain even if the questions has already been asked. Rephrase and clarify if needed.

Always take into account that negative (constructive) comments have required time for the reviewer. This means despite the negative aspect, the person actually cares about making this project better.

Try to balance (constructive) critics with compliments. This helps value the time spent by other people contributing.

As a good teacher of mine said:

> There is no problems, only solutions.

## 7. No politics

We believe code and open-source is a inclusive space where every people regardless their politic beliefs, religion, ethnicity is welcome.

Only debate about code.

Let this repository be a programming safe heaven (there is enough bad things out there).
