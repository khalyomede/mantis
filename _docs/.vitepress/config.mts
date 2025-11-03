import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
    title: "Mantis",
    head: [
        [
            "script",
            {
                async: "true"
            },
            '(function(){if(!window.chatbase||window.chatbase("getState")!=="initialized"){window.chatbase=(...arguments)=>{if(!window.chatbase.q){window.chatbase.q=[]}window.chatbase.q.push(arguments)};window.chatbase=new Proxy(window.chatbase,{get(target,prop){if(prop==="q"){return target.q}return(...args)=>target(prop,...args)}})}const onLoad=function(){const script=document.createElement("script");script.src="https://www.chatbase.co/embed.min.js";script.id="WxqvtdQdLRG6MWnPo44yU";script.domain="www.chatbase.co";document.body.appendChild(script)};if(document.readyState==="complete"){onLoad()}else{window.addEventListener("load",onLoad)}})();'
        ]
    ],
    description: "Type safe and simple web framework.",
    themeConfig: {
        // https://vitepress.dev/reference/default-theme-config
        nav: [

        ],

        search: {
            provider: "local"
        },

        sidebar: [
            {
                items: [
                    { text: 'Introduction', link: '/introduction' },
                    { text: 'Upgrade', link: '/upgrade' },
                    { text: 'Quick start', link: '/quick-start' },
                    { text: 'Productivity', link: '/productivity' },
                    { text: 'Folder structure', link: '/folder-structure' },
                    {
                        text: 'Http', items: [
                            { text: "Life cycle", link: '/http/life-cycle' },
                            { text: "Routing", link: '/http/routing' },
                            { text: "Response", link: '/http/response' },
                            { text: "Request", link: '/http/request' },
                            { text: "View", link: '/http/view' },
                            { text: "Translation", link: '/http/translation' },
                            { text: "Session (file)", link: '/http/session-file' },
                            { text: "Environment", link: '/http/environment' },
                            { text: "Database", link: '/http/database' },
                            { text: "Erorr handling", link: '/http/error-handling' },
                            { text: "Logging", link: "/http/logging.md" },
                            { text: "Middleware", link: "/http/middleware.md" },
                            { text: "Configuration", link: '/http/configuration' },
                            { text: "Cors", link: "/http/cors" },
                            { text: "Extending", link: '/http/extending' },
                        ],
                    },
                    {
                        text: 'Console', items: [
                            { text: "Routing", link: '/console/routing' },
                            { text: "Command", link: '/console/command' },
                            { text: "Argument", link: '/console/argument' },
                            { text: "Flag", link: '/console/flag' },
                            { text: "Option", link: '/console/option' },
                            { text: "Logging", link: '/console/logging' },
                        ],
                    },
                    { text: 'Validation', link: '/validation' },
                    { text: 'HTML', link: '/html' },
                    { text: 'CSS', link: '/css' },
                    { text: 'URL', link: '/url' },
                    { text: 'Environment', link: '/environment' },
                    {
                        text: 'Database', items: [
                            { text: 'Query', link: '/database/query' }
                        ]
                    },
                    { text: 'Logging', link: '/logging' },
                    {
                        text: 'Testing', items: [
                            { text: 'Assertion', link: '/testing/assertion' },
                            { text: 'HTTP', link: '/testing/http' },
                            { text: 'Console', link: '/testing/console' },
                            { text: 'Fake data', link: '/testing/fake-data' },
                        ]
                    },
                    { text: "Deploy", link: "/deploy" },
                    {
                        text: "Comparison", items: [
                            { text: "Laravel", link: "/comparison/laravel" }
                        ]
                    },
                    { text: 'Versioning policy', link: '/versioning-policy' },
                    { text: 'Reference', link: '/reference' },
                ]
            }
        ],

        socialLinks: [
            { icon: 'github', link: 'https://github.com/khalyomede/mantis' }
        ],
        langMenuLabel: "version",

    },
    base: "/mantis/",
    outDir: "../docs",
    locales: {
        root: {
            label: 'master'
        },
        "0.0.1": {
            label: '0.0.1',
            ...defineConfig({
                themeConfig: {
                    sidebar: [
                        {
                            items: [
                                { text: 'Introduction', link: '/0.0.1/introduction' },
                                { text: 'Upgrade', link: '/0.0.1/upgrade' },
                                { text: 'Quick start', link: '/0.0.1/quick-start' },
                                { text: 'Productivity', link: '/0.0.1/productivity' },
                                { text: 'Folder structure', link: '/0.0.1/folder-structure' },
                                {
                                    text: 'Http', items: [
                                        { text: "Life cycle", link: '/0.0.1/http/life-cycle' },
                                        { text: "Routing", link: '/0.0.1/http/routing' },
                                        { text: "Response", link: '/0.0.1/http/response' },
                                        { text: "Request", link: '/0.0.1/http/request' },
                                        { text: "View", link: '/0.0.1/http/view' },
                                        { text: "Translation", link: '/0.0.1/http/translation' },
                                        { text: "Session (file)", link: '/0.0.1/http/session-file' },
                                        { text: "Environment", link: '/0.0.1/http/environment' },
                                        { text: "Database", link: '/0.0.1/http/database' },
                                        { text: "Erorr handling", link: '/0.0.1/http/error-handling' },
                                        { text: "Logging", link: "/0.0.1/http/logging.md" },
                                        { text: "Middleware", link: "/0.0.1/http/middleware.md" },
                                        { text: "Configuration", link: '/0.0.1/http/configuration' },
                                        { text: "Cors", link: "/0.0.1/http/cors" },
                                        { text: "Extending", link: '/0.0.1/http/extending' },
                                    ],
                                },
                                {
                                    text: 'Console', items: [
                                        { text: "Routing", link: '/0.0.1/console/routing' },
                                        { text: "Command", link: '/0.0.1/console/command' },
                                        { text: "Argument", link: '/0.0.1/console/argument' },
                                        { text: "Flag", link: '/0.0.1/console/flag' },
                                        { text: "Option", link: '/0.0.1/console/option' },
                                        { text: "Logging", link: '/0.0.1/console/logging' },
                                    ],
                                },
                                { text: 'Validation', link: '/0.0.1/validation' },
                                { text: 'HTML', link: '/0.0.1/html' },
                                { text: 'CSS', link: '/0.0.1/css' },
                                { text: 'URL', link: '/0.0.1/url' },
                                { text: 'Environment', link: '/0.0.1/environment' },
                                {
                                    text: 'Database', items: [
                                        { text: 'Query', link: '/0.0.1/database/query' }
                                    ]
                                },
                                { text: 'Logging', link: '/0.0.1/logging' },
                                {
                                    text: 'Testing', items: [
                                        { text: 'Assertion', link: '/0.0.1/testing/assertion' },
                                        { text: 'HTTP', link: '/0.0.1/testing/http' },
                                        { text: 'Console', link: '/0.0.1/testing/console' },
                                        { text: 'Fake data', link: '/0.0.1/testing/fake-data' },
                                    ]
                                },
                                { text: "Deploy", link: "/0.0.1/deploy" },
                                {
                                    text: "Comparison", items: [
                                        { text: "Laravel", link: "/0.0.1/comparison/laravel" }
                                    ]
                                },
                                { text: 'Versioning policy', link: '/0.0.1/versioning-policy' },
                                { text: 'Reference', link: '/0.0.1/reference' },
                            ]
                        }
                    ],
                }
            })
        }
    }
})
