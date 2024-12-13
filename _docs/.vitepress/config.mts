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
                    { text: 'Documentation', link: '/documentation' },
                    {
                        text: 'Http', items: [
                            { text: "Erorr handling", link: '/http/error-handling' },
                        ],
                    },
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
    assetsDir: "mantis",
    locales: {
        root: {
            label: 'master'
        },
        "0.1.0": {
            label: '0.1.0'
        }
    }
})
