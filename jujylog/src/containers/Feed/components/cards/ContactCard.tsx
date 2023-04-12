import CONFIG from "site.config"
import React from "react"
import {
  AiOutlineInstagram,
  AiOutlineGithub,
  AiOutlineRead
} from "react-icons/ai"
// import {
//   RxNotionLogo,
// } from "react-icons/rx";

const ContactCard: React.FC = () => {
  return (
    <>
      <div className="p-1 mb-3 dark:text-white">💬 Contact</div>
      <ul className="rounded-2xl bg-white dark:bg-zinc-700 p-1 flex flex-col">
        {CONFIG.profile.github && (
          <a
            href={`https://github.com/${CONFIG.profile.github}`}
            rel="noreferrer"
            target="_blank"
            className="p-3 hover:bg-gray-100 dark:hover:bg-zinc-700 rounded-2xl cursor-pointer flex items-center gap-3 text-gray-500 dark:text-white hover:text-black dark:hover:text-white "
          >
            <AiOutlineGithub className="text-2xl" />
            <div className="text-sm">github</div>
          </a>
        )}
        {CONFIG.profile.notion && (
          <a
            href={`${CONFIG.profile.notion}`}
            rel="noreferrer"
            target="_blank"
            className="overflow-hidden p-3 hover:bg-gray-100 dark:hover:bg-zinc-700 rounded-2xl cursor-pointer flex items-center gap-3 text-gray-500 dark:text-white hover:text-black dark:hover:text-white"
          >
            <AiOutlineRead className="text-2xl flex-shrink-0" />
            <div className="text-sm">notion</div>
          </a>
        )}
      </ul>
    </>
  )
}

export default ContactCard

