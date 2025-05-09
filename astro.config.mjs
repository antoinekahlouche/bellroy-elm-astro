// @ts-check
import elmstronaut from "elmstronaut";
import { defineConfig } from "astro/config";
import tailwindcss from "@tailwindcss/vite";

// https://astro.build/config
export default defineConfig({
	integrations: [elmstronaut()],
	vite: {
		plugins: [tailwindcss()],
	},
});
