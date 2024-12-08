module layouts

import mantis { App }
import mantis.html { html, head, title, link, style, script, body, main, nav }
import mantis.css { selector }
import views.components { footer_page, navbar }

pub fn layout(app App, content []string) string {
    app_name := app.env.get('APP_NAME') or { 'Mantis' }

    return html({"lang": "en"}, [
        head({}, [
            title({}, ["Reliable type safe no magic web framework - ${app_name}"]),
            link({"rel": "stylesheet", "type":"text/css", "href": "https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css", "integrity": "sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH", "crossorigin": "anonymous"}),
            link({ "rel": "preconnect", "href": "https://fonts.googleapis.com" })
            link({ "rel": "preconnect", "href": "https://fonts.gstatic.com", "crossorigin": true })
            link({ "href": "https://fonts.googleapis.com/css2?family=Fira+Code:wght@300..700&family=Fira+Sans+Condensed:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap", "rel": "stylesheet" })
            link({"rel": "stylesheet", "href": "https://unpkg.com/@highlightjs/cdn-assets@11.10.0/styles/github-dark.min.css"})
            style({}, [
                selector("*", {
                    "font-family": '"Fira Sans Condensed", sans-serif'
                    "font-style": "normal"
                })
                selector("code *", {
                    "font-family": '"Fira Code", monospace !important'
                    "font-optical-sizing": "auto",
                    "font-variant-ligatures": "common-ligatures",
                })
            ]),
            script({}, [
                "(function(w,d,e,u,f,l,n){w[f]=w[f]||function(){(w[f].q=w[f].q||[]).push(arguments);},l=d.createElement(e),l.async=1,l.src=u,n=d.getElementsByTagName(e)[0],n.parentNode.insertBefore(l,n);})(window,document,'script','https://assets.mailerlite.com/js/universal.js','ml');ml('account', '1195915');"
            ])
        ]),
        body({"data-bs-theme": "dark"}, [
            navbar(app_name, app.route("index", {}) or { "#" }, {
                "Getting started": "#",
                "Documentation": app.route("documentation.index", {}) or {"#"}
            }),
            main({"class": "container my-5"}, content)
            footer_page(),
            script({ "src": "https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js", "integrity": "sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz", "crossorigin": "anonymous" }, [])
            script({ "src": "https://unpkg.com/@highlightjs/cdn-assets@11.10.0/highlight.min.js"}, [])
            script({ "src": "https://unpkg.com/@highlightjs/cdn-assets@11.10.0/languages/go.min.js"}, [])
            script({ "type": "text/javascript" }, [
                "hljs.highlightAll();"
            ])
        ])
    ])
}
