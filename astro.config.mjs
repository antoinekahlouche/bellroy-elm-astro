// @ts-check
import elmstronaut from "elmstronaut";
import { defineConfig } from "astro/config";
import tailwindcss from "@tailwindcss/vite";

// https://astro.build/config
export default defineConfig({
	site: "https://antoinekahlouche.github.io",
	base: "bellroy-elm-astro",
	integrations: [elmstronaut()],
	vite: {
		plugins: [tailwindcss()],
	},
});
