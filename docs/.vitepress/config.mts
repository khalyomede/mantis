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
                    { text: 'Quick start', link: '/quick-start' },
                    { text: 'Productivity', link: '/productivity' },
                    { text: 'Folder structure', link: '/folder-structure' },
                    { text: 'Documentation', link: '/documentation' }
                ]
            }
        ],

        socialLinks: [
            { icon: 'github', link: 'https://github.com/khalyomede/mantis' }
        ],
        langMenuLabel: "version",
    },
    base: "/docs/",
    locales: {
        root: {
            label: 'master'
        },
        "0.1.0": {
            label: '0.1.0'
        }
    }
})
