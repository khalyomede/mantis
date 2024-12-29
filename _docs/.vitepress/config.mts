import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
    title: "Mantis",
    description: "Type safe and simple web framework.",
    themeConfig: {
        // https://vitepress.dev/reference/default-theme-config
        nav: [

        ],

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
                            { text: "Configuration", link: '/http/configuration' },
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
        "0.1.0": {
            label: '0.1.0'
        }
    }
})
