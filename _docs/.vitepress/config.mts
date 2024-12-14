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
                            { text: "Database", link: '/http/database' },
                            { text: "Erorr handling", link: '/http/error-handling' },
                        ],
                    },
                    { text: 'Validation', link: '/validation' },
                    { text: 'HTML', link: '/html' },
                    { text: 'Database', link: '/database' },
                    { text: 'Testing', link: '/testing' },
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
