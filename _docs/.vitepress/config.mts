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
                    { text: 'Type safety', link: '/type-safety' },
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
                        ],
                    },
                    { text: 'Validation', link: '/validation' },
                    { text: 'HTML', link: '/html' },
                    { text: 'URL', link: '/url' },
                    { text: 'Environment', link: '/environment' },
                    {
                        text: 'Database', items: [
                            { text: 'Query', link: '/database/query' }
                        ]
                    },
                    {
                        text: 'Testing', items: [
                            { text: 'Assertion', link: '/testing/assertion' }
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
