# Folder structure

Here is an opiniated view of how your app can scale.

This is just a suggested approach to help you project yourself.

```
your-app
├── app
│   ├── assets
│   │   ├── ts
│   │   │   └── main.ts
│   │   ├── sass
│   │   │   └── main.sass
│   │   └── img
│   │       └── logo.png
│   ├── controllers
│   │   ├── post
│   │   │   ├── create.v
│   │   │   ├── edit.v
│   │   │   ├── store.v
│   │   │   └── update.v
│   │   └── login
│   │       ├── create.v
│   │       └── store.v
│   ├── routes
│   │   ├── guest.v
│   │   └── authenticated.v
│   ├── tests
│   │   └── controllers
│   │       └── post
│   │           ├── create_test.v
│   │           ├── edit_test.v
│   │           ├── store_test.v
│   │           └── update_test.v
│   ├── views
│   │   ├── components
│   │   │   ├── footer.v
│   │   │   └── navbar.v
│   │   ├── layouts
│   │   │   ├── guest.v
│   │   │   └── authenticated.v
│   │   └── pages
│   │       ├── login
│   │       │   └── create.v
│   │       └── post
│   │           ├── create.v
│   │           └── edit.v
│   └── main.v
├── build
│   ├── js
│   │   └── main.js
│   ├── css
│   │   └── main.css
│   ├── img
│   │   ├── logo-sm.png
│   │   └── logo-xl.png
│   └── main
├── .browserslistrc
├── .editorconfig
├── .env
├── .env.prod
├── .gitignore
├── docker-compose.yml
├── package.json
├── package-lock.json
├── tsconfig.json
├── v.mod
└── vite.config.js
```

- **app**: Contains all your source files.
- **build**: Built version of your source files (to be deployed to your server).
  - **main**: The executable of your server.
