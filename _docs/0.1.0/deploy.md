# Deploy

Here are the steps to get your app in production with HTTPS support.

## Create the production folder

Create a "build" folder where you can put all your static assets and production files.

Here is an example of structure:

```
build/
├── js  /
│   └── main.js
├── css/
│   └── main.css
├── img/
│   ├── logo-sm.png
│   └── logo-xl.png
└── main
```

::: tip INFO
Configure your asset builder (Vite.js, ...) to store the files inside the "build" folder.
:::

## Compile for production

First, add a prod directive to serve your app on port `9000`:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app }

fn main() {
  app := create_app(
    port: $if prod { 9000 } $else { 80 }
    // ...
  )

  app.serve() or { panic(err) }
}
```

:::

Run this command to build your HTTP app (main.v):


```bash [/home/user/app]
v -prod -obsfucate -compress -os linux -o build/main main.v
```

::: tip INFO
Change the option `-os linux` with the target OS of your choice. See V documentation about [cross compilation](https://docs.vlang.io/cross-compilation.html).
:::

## Production serveur (VPS)

Launch your server:

::: code-group

```bash [/home/user/app]
> ./main
2024-12-23T16:11:59.304636018Z [INFO] listening on 0.0.0.0:9000
2024-12-23T16:11:59.304667317Z [INFO] Serving requests with up to 1 workers (standalone mode)
```

:::

Then, we advice you use Nginx to serve your app. It will allow you to use certbot to setup an SSL ceritifcate (HTTPS).

::: warning
Make sure you own a domain name as getting an SSL certificate requires a valid domain name.
:::

Here is a typical Nginx configuration:

::: code-group

```nginx [/etc/nginx/sites-enabled/your-domain-name.com.conf]
server {
    listen 80;
    listen 443 default_server ssl;
    server_name your-domain-name.com;
    root /home/user/app; # Customize this folder where you put the content of the "build" folder.

    # Custom access and error logs for this server
    access_log /var/log/nginx/access.log combined;
    error_log  /var/log/nginx/error.log warn;

    # Try static files first, then proxy to Mantis
    location / {
        try_files $uri @mantis;
        expires 7d;
        add_header Cache-Control "public, no-transform";
    }

    # Fallback location for Mantis
    location @mantis {
        proxy_pass http://localhost:9000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }
}
```

:::
