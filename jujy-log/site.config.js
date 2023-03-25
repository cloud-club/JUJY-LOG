const CONFIG = {
  // profile setting (required)
  profile: {
    name: "JUJY",
    image: "/jujyimg.jpg", // If you want to create your own notion avatar, check out https://notion-avatar.vercel.app
    role: "devops engineer",
    bio: "Hi! We are JUJY 👋",
    email: "na3150@gmail.com",
    linkedin: "nayoungsung",
    notion: "https://cloudclub.notion.site/f9da849b1e0c435ea7c3cc90b91a8ae0?v=7818918f26dc4b4a8e853551f808e940",
    github: "cloud-club/JUJY-LOG",
    instagram: "",
  },
  projects: [
    {
      name: `jujy-log`,
      href: "https://github.com/cloud-club/JUJY-LOG",
    },
  ],
  // blog setting (required)
  blog: {
    title: "☁️ jujy-log ☁️",
    description: "welcome to jujy-log!",
    theme: "light", // ['light', 'dark', 'auto']
  },

  // CONFIG configration (required)
  link: "https://morethan-log.vercel.app",
  since: 2022, // If leave this empty, current year will be used.
  lang: "en-US", // ['en-US', 'zh-CN', 'zh-HK', 'zh-TW', 'ja-JP', 'es-ES', 'ko-KR']
  ogImageGenerateURL: "https://og-image-korean.vercel.app", // The link to generate OG image, don't end with a slash
  seo: {
    keywords: ["Blog", "Website", "Notion"],
  },

  // notion configuration (required)
  notionConfig: {
    pageId: process.env.NOTION_PAGE_ID,
  },

  // plugin configuration (optional)
  googleAnalytics: {
    enable: false,
    config: {
      measurementId: process.env.GOOGLE_MEASUREMENT_ID || "",
    },
  },
  googleSearchConsole: {
    enable: false,
    config: {
      siteVerification: process.env.GOOGLE_SITE_VERIFICATION || "",
    },
  },
  utterances: {
    enable: true,
    config: {
      repo: "morethanmin/morethan-log",
      "issue-term": "og:title",
      label: "💬 Utterances",
    },
  },
  cusdis: {
    enable: false,
    config: {
      host: "https://cusdis.com",
      appid: "", // Embed Code -> data-app-id value
    },
  },
  isProd: process.env.VERCEL_ENV === "production", // distinguish between development and production environment (ref: https://vercel.com/docs/environment-variables#system-environment-variables)
}
module.exports = CONFIG
